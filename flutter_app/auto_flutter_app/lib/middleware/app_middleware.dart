import 'package:auto_flutter_app/middleware/control_middleware.dart';
import 'package:auto_flutter_app/middleware/status_middleware.dart';
import 'package:redux/redux.dart';
import 'package:auto_flutter_app/state/app_state.dart';

final String api = "http://192.168.5.103:80/";

List<Middleware<AppState>> createAppMiddleware(client) {
  return [
    StatusMiddleware(client, api),
    ControlMiddleware(client, api)
  ];
}