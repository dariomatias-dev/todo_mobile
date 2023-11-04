import 'dart:io';

import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

import 'package:todo/src/core/result_types/either.dart';

class DatabaseClientService {
  DatabaseClientService({
    required this.table,
    required this.columns,
    required this.createTableQuery,
  });

  final Logger _logger = Logger();
  late Database _db;

  static const _databaseName = "todo.db";
  static const _databaseVersion = 1;

  final String table;
  final List<String> columns;
  final String createTableQuery;

  Future<Either> init() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _databaseName);

    final result = await _handleRequest(
      () => openDatabase(
        path,
        version: _databaseVersion,
        onCreate: _onCreate,
      ),
    );

    if (result is Success) {
      _db = result.value;
    }

    return result;
  }

  Future<Either> _onCreate(Database db, int _) async {
    return await _handleRequest(
      () => db.execute(createTableQuery),
    );
  }

  Future<Either> create(Map<String, dynamic> data) async {
    const uuid = Uuid();
    final id = uuid.v4();

    return await _handleRequest(
      () => _db.insert(
        table,
        {'id': id, ...data},
        conflictAlgorithm: ConflictAlgorithm.replace,
      ),
    );
  }

  Future<Either> getAll() async {
    return await _handleRequest(
      () => _db.query(table),
    );
  }

  Future<Either> getOne(String id) async {
    return await _handleRequest(
      () => _db.query(
        table,
        where: 'id = ?',
        whereArgs: [id],
      ),
    );
  }

  Future<Either> update(String id, Map<String, dynamic> row) async {
    return _handleRequest(
      () => _db.update(
        table,
        row,
        where: 'id = ?',
        whereArgs: [id],
      ),
    );
  }

  Future<Either> delete(String id) async {
    return await _handleRequest(
      () => _db.delete(
        table,
        where: 'id = ?',
        whereArgs: [id],
      ),
    );
  }

  Future<void> dispose() async {
    await _db.close();
  }

  Future<Either> _handleRequest(Future<dynamic> Function() request) async {
    try {
      final value = await request();

      return Success(
        value: value,
      );
    } on Exception catch (err, stackTrace) {
      _logger.e(
        err,
        stackTrace: stackTrace,
      );

      if (err is DatabaseException) {
        if (err.isOpenFailedError()) {
          return const Failure(
            type: FailureType.openFailed,
            message: 'Error opening database.',
          );
        } else if (err.isNoSuchTableError()) {
          return const Failure(
            type: FailureType.generic,
            message: 'Table not found',
          );
        } else if (err.isReadOnlyError()) {
          return const Failure(
            type: FailureType.readOnly,
            message: 'Read-only error.',
          );
        } else if (err.isUniqueConstraintError()) {
          return const Failure(
            type: FailureType.uniqueField,
            message: 'Unique constraint violation error.',
          );
        } else if (err.isNotNullConstraintError()) {
          return const Failure(
            type: FailureType.notNull,
            message: 'NOT NULL constraint error.',
          );
        } else if (err.isDatabaseClosedError()) {
          return const Failure(
            type: FailureType.databaseClosed,
            message: 'Database closed unexpectedly.',
          );
        }
      } else if (err is FileSystemException) {
        return const Failure(
          type: FailureType.fileSystem,
          message: 'File system error.',
        );
      } else if (err is PlatformException) {
        return const Failure(
          type: FailureType.platform,
          message: 'Platform error.',
        );
      } else if (err is FormatException) {
        return const Failure(
          type: FailureType.format,
          message: 'Format error.',
        );
      } else if (err is SocketException) {
        return const Failure(
          type: FailureType.socket,
          message: 'Socket error.',
        );
      } else if (err is UnsupportedError) {
        return const Failure(
          type: FailureType.unsupported,
          message: 'Unsupported error.',
        );
      }

      return Failure(
        type: FailureType.generic,
        message: err.toString(),
      );
    }
  }
}
