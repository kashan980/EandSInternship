import 'package:eandsinternship/config/routes/route_helper_utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part "app_routes.g.dart";

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

String getAppInitialRouteLocation() {
  return GoRouteData.$location('/mainScreenRoute');
}

@TypedGoRoute<MainScreenRoute>(path: '/mainScreenRoute')
class MainScreenRoute extends GoRouteData {
  const MainScreenRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>  RouteHelperUtil().getMainScreenWidget();
}

@TypedGoRoute<MenuScreenRoute>(path: '/menuScreenRoute')
class MenuScreenRoute extends GoRouteData {
  const MenuScreenRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>  RouteHelperUtil().getMenuScreenWidget();
}