import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:starter_proj/config/localization/app_localization.dart';
import 'package:starter_proj/config/service_locator/service_locator.dart';
import 'package:starter_proj/core/theme/data/dark_theme_data.dart';
import 'package:starter_proj/core/theme/data/light_theme_data.dart';

import '../config/routes/auto_routes/auto_routes.gr.dart';
import '../core/localization_manager/bloc/localization_manager_bloc.dart';
import '../core/theme/bloc/theme_manager_bloc.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<ThemeManagerBloc>()..add(Init())),
        BlocProvider(
            create: (context) =>
                sl<LocalizationManagerBloc>()..add(InitializeLocale())),
      ],
      child: Builder(
        builder: (context) {
          return BlocBuilder<ThemeManagerBloc, ThemeMode?>(
            builder: (context, themeState) {
              if (themeState == null) {
                BlocProvider.of<ThemeManagerBloc>(context).add(Init());
              }

              return BlocBuilder<LocalizationManagerBloc,
                  LocalizationManagerState>(
                builder: (context, localeState) {
                  if (localeState.initialized == false) {
                    BlocProvider.of<LocalizationManagerBloc>(context)
                        .add(InitializeLocale());
                  }

                  // return CupertinoApp.router(
                  //   routerDelegate: _appRouter.delegate(),
                  //   routeInformationParser: _appRouter.defaultRouteParser(),
                  //   localizationsDelegates: const [
                  //     AppLocalizations.delegate,
                  //     GlobalMaterialLocalizations.delegate,
                  //     GlobalWidgetsLocalizations.delegate,
                  //     GlobalCupertinoLocalizations.delegate,
                  //   ],
                  //   supportedLocales: const [
                  //     Locale('en', 'US'), // English
                  //     Locale('ne', 'NP'), // nepali
                  //   ],
                  //   locale: localeState.locale,

                  //   theme: (themeState == ThemeMode.system)
                  //       ? (Theme.of(context).brightness == Brightness.light
                  //           ? LightTheme().cupertino()
                  //           : DarkTheme().cupertino())
                  //       : themeState == ThemeMode.dark
                  //           ? DarkTheme().cupertino()
                  //           : LightTheme().cupertino(),
                  //   title: "App",
                  //   debugShowCheckedModeBanner: false,
                  // );

                  return MaterialApp.router(
                    localizationsDelegates: const [
                      AppLocalizations.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],
                    supportedLocales: const [
                      Locale('en'), // English
                      Locale('ne'), // nepali
                    ],
                    locale: localeState.locale,
                    themeMode: themeState,
                    darkTheme: DarkTheme()(),
                    theme: LightTheme()(),
                    title: "App",
                    routerDelegate: _appRouter.delegate(),
                    routeInformationParser: _appRouter.defaultRouteParser(),
                    debugShowCheckedModeBanner: false,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
