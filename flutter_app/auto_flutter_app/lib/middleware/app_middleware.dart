import 'package:auto_flutter_app/middleware/control_middleware.dart';
import 'package:auto_flutter_app/middleware/status_middleware.dart';
import 'package:redux/redux.dart';
import 'package:auto_flutter_app/state/app_state.dart';

// final String api = "http://192.168.4.1:80/";
final String api = "http://192.168.1.5:80/";
final int retries = 1;

List<Middleware<AppState>> createAppMiddleware(client) {
  return [
    StatusMiddleware(client, api, retries),
    ControlMiddleware(client, api)
  ];
}