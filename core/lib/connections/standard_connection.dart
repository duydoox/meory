part of '../core.dart';

@immutable
abstract class StandardConnection<T extends TransportationObject, E extends Object> {
  final SuperAppConn superAppConn;

  const StandardConnection({required this.superAppConn});

  @protected
  Future<void> init(T transportationObject);

  @protected
  List<RouteBase> getRoutes({required GlobalKey<NavigatorState> navigatorKey});

  //sử dụng để thực hiện event từ main app đến mini app
  @protected
  dynamic onEventMiniApp([E? params]) {}
}

mixin SuperAppConn {
  //sử dụng để thực hiện event từ mini app đến main app
  Future<dynamic> onEvent(MiniAppEvent event, [data]);
}

enum MiniAppEvent { refreshToken, logout, createTicket, goDetailTicket }
