// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$mainScreenRoute, $menuScreenRoute];

RouteBase get $mainScreenRoute => GoRouteData.$route(
  path: '/mainScreenRoute',

  factory: $MainScreenRouteExtension._fromState,
);

extension $MainScreenRouteExtension on MainScreenRoute {
  static MainScreenRoute _fromState(GoRouterState state) =>
      const MainScreenRoute();

  String get location => GoRouteData.$location('/mainScreenRoute');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $menuScreenRoute => GoRouteData.$route(
  path: '/menuScreenRoute',

  factory: $MenuScreenRouteExtension._fromState,
);

extension $MenuScreenRouteExtension on MenuScreenRoute {
  static MenuScreenRoute _fromState(GoRouterState state) =>
      const MenuScreenRoute();

  String get location => GoRouteData.$location('/menuScreenRoute');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
