import 'dart:async'; // Required for StreamSubscription if needed elsewhere, good practice to keep
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart'; // Import internet_connection_checker
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'network_info.g.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
  Stream<bool> get onConnectionChange;
}

class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker connectionChecker;

  NetworkInfoImpl(this.connectionChecker);

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;

  @override
  Stream<bool> get onConnectionChange => connectionChecker.onStatusChange
      .map((status) => status == InternetConnectionStatus.connected);
}

@riverpod
NetworkInfo networkInfo(Ref ref) {
  final connectionChecker = InternetConnectionChecker.instance;
  return NetworkInfoImpl(connectionChecker);
}
