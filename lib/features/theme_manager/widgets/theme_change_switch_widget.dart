import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/features/theme_manager/bloc/theme_manager_bloc.dart';

class ThemeChangeSwitchWidget extends StatelessWidget {
  const ThemeChangeSwitchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Switch(
      onChanged: (bool value) {
        if (value) {
          BlocProvider.of<ThemeManagerBloc>(context)
              .add(ChangeThemeMode(themeMode: ThemeMode.light));
        } else {
          BlocProvider.of<ThemeManagerBloc>(context)
              .add(ChangeThemeMode(themeMode: ThemeMode.dark));
        }
      },
      value: BlocProvider.of<ThemeManagerBloc>(context).state ==
          ThemeMode.light,
    );
  }
}
