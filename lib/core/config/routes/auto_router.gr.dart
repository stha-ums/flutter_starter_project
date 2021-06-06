// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i2;

import '../../../features/home/presentation/screens/HomePage.dart' as _i3;
import '../../../features/theme_manager/widgets/theme_change_dropdown_widget.dart'
    as _i4;

class AppRouter extends _i1.RootStackRouter {
  AppRouter([_i2.GlobalKey<_i2.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i3.HomePage();
        }),
    ThemeChangeDropDownWidget.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i4.ThemeChangeDropDownWidget();
        })
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(HomeRoute.name, path: '/'),
        _i1.RouteConfig(ThemeChangeDropDownWidget.name,
            path: '/theme-change-drop-down-widget')
      ];
}

class HomeRoute extends _i1.PageRouteInfo {
  const HomeRoute() : super(name, path: '/');

  static const String name = 'HomeRoute';
}

class ThemeChangeDropDownWidget extends _i1.PageRouteInfo {
  const ThemeChangeDropDownWidget()
      : super(name, path: '/theme-change-drop-down-widget');

  static const String name = 'ThemeChangeDropDownWidget';
}
