// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$mainScreenRoute, $menuScreenRoute];

RouteBase get $mainScreenRoute => GoRouteData.$route(
  path: '/mainScreenRoute',
  factory: $MainScreenRoute._fromState,
);

mixin $MainScreenRoute on GoRouteData {
  static MainScreenRoute _fromState(GoRouterState state) =>
      const MainScreenRoute();

  @override
  String get location => GoRouteData.$location('/mainScreenRoute');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $menuScreenRoute => GoRouteData.$route(
  path: '/menuScreenRoute',
  factory: $MenuScreenRoute._fromState,
);

mixin $MenuScreenRoute on GoRouteData {
  static MenuScreenRoute _fromState(GoRouterState state) =>
      const MenuScreenRoute();

  @override
  String get location => GoRouteData.$location('/menuScreenRoute');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}
