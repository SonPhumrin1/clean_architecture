import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure([this.properties = const <Object>[]]);

  final List<Object> properties;

  @override
  List<Object> get props => properties;
}

class ServerFailure extends Failure {
  final String message;
  const ServerFailure({required this.message});
}

class CacheFailure extends Failure {}

class NetworkFailure extends Failure {}
