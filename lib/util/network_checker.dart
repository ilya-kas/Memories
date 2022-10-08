import 'package:data_connection_checker/data_connection_checker.dart';

abstract class NetworkChecker{
  Future<bool> get isConnected;
}

class NetworkCheckerImpl extends NetworkChecker {
  final DataConnectionChecker _checker;

  NetworkCheckerImpl(this._checker);

  @override
  Future<bool> get isConnected async => await _checker.hasConnection;

}