import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  Failure({this.message});
  final String? message;
  @override
  List<Object> get props => [];
}

// General failures
class ServerFailure extends Failure {
  ServerFailure({String? message}) : super(message: message);
}

class CacheFailure extends Failure {
  CacheFailure({String? message}) : super(message: message);
}

class FailureMessage {
  FailureMessage._();
  static const String articleNotFound = 'news not found';
  static const String articlesEmpty = 'news is empty';
}
