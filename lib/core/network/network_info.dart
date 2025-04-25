import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'network_info.g.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
  Stream<bool> get onConnectionChange;
}

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity connectivity;

  NetworkInfoImpl(this.connectivity);

  @override
  Future<bool> get isConnected async {
    final result = await connectivity.checkConnectivity();
    return result.first != ConnectivityResult.none;
  }

  @override
  Stream<bool> get onConnectionChange async* {
    await for (final result in connectivity.onConnectivityChanged) {
      yield result.first != ConnectivityResult.none;
    }
  }
}

@riverpod
NetworkInfo networkInfo(Ref ref) {
  final connectivity = Connectivity();
  return NetworkInfoImpl(connectivity);
}
