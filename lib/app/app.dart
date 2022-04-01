import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:starter/config/localization/app_localization.dart';
import 'package:starter/config/service_locator/service_locator.dart';
import 'package:starter/core/theme/data/dark_theme_data.dart';
import 'package:starter/core/theme/data/light_theme_data.dart';

import '../config/routes/auto_routes/auto_routes.gr.dart';
import '../core/localization_manager/bloc/localization_manager_bloc.dart';
import '../core/theme/bloc/theme_manager_bloc.dart';

class App extends StatelessWidget {
  final _appRouter = AppRouter();

  App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<ThemeManagerBloc>()),
        BlocProvider(create: (context) => sl<LocalizationManagerBloc>()),
      ],
      child: Builder(builder: (context) {
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

                return MaterialApp.router(
                  localizationsDelegates: const [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  supportedLocales: const [
                    Locale('en', 'US'), // English
                    Locale('ne', 'NP'), // nepali
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
      }),
    );
  }
}
