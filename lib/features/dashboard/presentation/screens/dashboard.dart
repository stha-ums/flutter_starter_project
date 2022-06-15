import 'package:flutter/material.dart';
import 'package:starter_proj/core/theme/widgets/change_theme.dart';

import '../../../../core/localization_manager/widgets/change_locale_dropdown_widget.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          ChangeThemeTristateSwitch(),
          ChangeLocaleDropDownWidget()
        ],
      ),
    );
  }
}
