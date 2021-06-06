import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:starter/features/localization_manager/bloc/localization_manager_bloc.dart';

class ChangeLocaleDropDownWidget extends StatelessWidget {
  const ChangeLocaleDropDownWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Text(AppLocalizations.of(context)!.changeLanguage),
        DropdownButtonHideUnderline(
          child: DropdownButton(
            value:
                BlocProvider.of<LocalizationManagerBloc>(context).state.locale,
            onChanged: (Locale? locale) {
              BlocProvider.of<LocalizationManagerBloc>(context).add(
                ChangeLocale(locale: locale!),
              );
            },
            items: AppLocalizations.supportedLocales
                .map(
                  (e) => DropdownMenuItem<Locale>(
                    child: Text(
                      e.toString(),
                    ),
                    value: e,
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
