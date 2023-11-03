import "package:equatable/equatable.dart";

enum FailureType {
  fileSystem,
  platform,
  format,
  socket,
  unsupported,

  /// Local database failures
  openFailed,
  tableNotFound,
  syntaxError,
  readOnly,
  uniqueField,
  notNull,
  databaseClosed,

  /// Generic Failure
  generic,
}

abstract class Either<E extends Exception, S> extends Equatable {
  const Either();

  @override
  List<Object?> get props => [];
}

class Success<S> extends Either<Exception, S> {
  const Success({
    required this.value,
  });

  final S value;

  @override
  List<Object?> get props => [value];
}

class Failure<E extends Exception, S> extends Either<E, S> {
  const Failure({
    required this.type,
    required this.message,
  });

  final FailureType type;
  final String message;

  @override
  List<Object?> get props => [type, message];
}
