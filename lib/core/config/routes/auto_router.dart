import 'package:auto_route/auto_route.dart';
import 'package:starter/features/home/presentation/screens/HomePage.dart';
import 'package:starter/features/theme_manager/widgets/theme_change_dropdown_widget.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: HomePage, initial: true),
    AutoRoute(page: ThemeChangeDropDownWidget),
  ],
)
class $AppRouter {}
