import 'package:auto_route/auto_route.dart';

import '../../../features/dashboard/presentation/screens/dashboard.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    MaterialRoute(page: DashBoard, initial: true)

    // AutoRoute(page: ThemeChangeDropDownWidget),
  ],
)
class $AppRouter {}
