
import 'package:connectivity/connectivity.dart';

abstract class NetworkInfo{
  Future<bool> get isConnected;
  Future<bool> get isWifi;
  Future<bool> get isCellular;

}
class NetworkInfoImplementation implements NetworkInfo{
  final Connectivity connectionChecker;
  NetworkInfoImplementation({required this.connectionChecker});

  @override
  Future<bool> get isConnected async => (await connectionChecker.checkConnectivity()) != ConnectivityResult.none;

  @override

  Future<bool> get isCellular async => (await connectionChecker.checkConnectivity()) != ConnectivityResult.mobile;

  @override
  Future<bool> get isWifi async => (await connectionChecker.checkConnectivity()) != ConnectivityResult.wifi;

}