import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:url_strategy/url_strategy.dart';

import 'core/config/routes/auto_router.gr.dart';
import 'core/config/service_locator.dart';
import 'core/logger/logger.dart';
import 'features/theme_manager/data/dark_theme_data.dart';
import 'features/theme_manager/data/light_theme_data.dart';

Future<void> appInitialize() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  // initiate service locator
  await initServiceLocator();

  // initialize logging
  initLogging();
}

void main() async {
  await appInitialize();

  runApp(App());
  // runApp(
  //   MultiBlocProvider(
  //     providers: [
  //       BlocProvider(create: (context) => sl<ThemeManagerBloc>()),
  //       BlocProvider(create: (context) => sl<LocalizationManagerBloc>()),
  //     ],
  //     child: App(),
  //   ),
  // );
}

class App extends StatelessWidget {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', 'US'), // English
        const Locale('ne', 'NP'), // nepali
      ],
      // locale: localeState.locale,
      // themeMode: themeState,
      darkTheme: DarkTheme()(),
      theme: LightTheme()(),
      title: "App",
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
      debugShowCheckedModeBanner: false,
    );

    // return BlocBuilder<ThemeManagerBloc, ThemeMode?>(
    //   builder: (context, themeState) {
    //     if (themeState == null) {
    //       BlocProvider.of<ThemeManagerBloc>(context).add(Init());
    //     }
    //
    //     return BlocBuilder<LocalizationManagerBloc, LocalizationManagerState>(
    //       builder: (context, localeState) {
    //         if (localeState.initialized == false) {
    //           BlocProvider.of<LocalizationManagerBloc>(context)
    //               .add(InitializeLocale());
    //         }
    //
    //         return MaterialApp.router(
    //           localizationsDelegates: [
    //             AppLocalizations.delegate,
    //             GlobalMaterialLocalizations.delegate,
    //             GlobalWidgetsLocalizations.delegate,
    //             GlobalCupertinoLocalizations.delegate,
    //           ],
    //           supportedLocales: [
    //             const Locale('en', 'US'), // English
    //             const Locale('ne', 'NP'), // nepali
    //           ],
    //           locale: localeState.locale,
    //           themeMode: themeState,
    //           darkTheme: DarkTheme()(),
    //           theme: LightTheme()(),
    //           title: "App",
    //           routerDelegate: _appRouter.delegate(),
    //           routeInformationParser: _appRouter.defaultRouteParser(),
    //           debugShowCheckedModeBanner: false,
    //         );
    //       },
    //     );
    //   },
    // );
  }
}
