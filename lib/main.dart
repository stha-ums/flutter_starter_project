import 'package:flutter/material.dart';
import 'package:starter_proj/config/logger/logger.dart';
import 'package:starter_proj/config/service_locator/service_locator.dart';
import 'package:url_strategy/url_strategy.dart';

import 'app/app.dart';

void main() => ConfiguredApp()();

class ConfiguredApp {
  /// Configure and run the app.
  Future<void> call() async {
    /*
  Add all the configurations here 
  that needed to be done before app initialze
  */
    WidgetsFlutterBinding.ensureInitialized();

    // this will remove # from url of the app in web
    setPathUrlStrategy();

    // initialize the getit service locator
    await initServiceLocator();

    // setup logging
    initLogging();

    //start app
    runApp(const App());
  }
}
