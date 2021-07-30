import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  Failure({this.status, this.code, this.message});
  final String? message;
  final String? status;
  final String? code;
  @override
  List<Object?> get props => [
        status,
        code,
        message,
      ];
}

// General failures
class ServerFailure extends Failure {
  ServerFailure({String? status, String? code, String? message})
      : super(status: status, code: code, message: message);
}

class CacheFailure extends Failure {
  CacheFailure({String? message}) : super(message: message);
}
