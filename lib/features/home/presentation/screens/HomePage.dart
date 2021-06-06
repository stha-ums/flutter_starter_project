import 'package:flutter/material.dart';
import 'package:starter/core/config/app_localization.dart';
import 'package:starter/features/localization_manager/widgets/change_locale_dropdown_widget.dart';
import 'package:starter/features/theme_manager/widgets/theme_change_dropdown_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Home", style: Theme.of(context).textTheme.headline2),
          Text(AppLocalizations.of(context)!.helloWorld),
          SizedBox(height: 20),
          ThemeChangeDropDownWidget(),
          ChangeLocaleDropDownWidget(),
          SizedBox(height: 20),
          Text("This is starter project")
        ],
      ),
    );
  }
}
