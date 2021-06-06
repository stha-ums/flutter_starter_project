import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/features/theme_manager/bloc/theme_manager_bloc.dart';

class ThemeChangeDropDownWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  DropdownButtonHideUnderline(
      child: DropdownButton(
        value: BlocProvider.of<ThemeManagerBloc>(context).state,
        onChanged: (ThemeMode? themMode) {
          if (themMode != null)
            BlocProvider.of<ThemeManagerBloc>(context)
                .add(ChangeThemeMode(themeMode: themMode));
        },
        items: List.generate(
          3,
              (index) => DropdownMenuItem(
            child: Text(describeEnum(ThemeMode.values[index])),
            value: ThemeMode.values[index],
          ),
        ),
      ),
    );
  }
}
