import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/localization/app_localization.dart';
import '../bloc/localization_manager_bloc.dart';

class ChangeLocaleDropDownWidget extends StatelessWidget {
  const ChangeLocaleDropDownWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(context.locale?.changeLanguage ?? ''),
        if (BlocProvider.of<LocalizationManagerBloc>(context).state.locale !=
            null)
          DropdownButtonHideUnderline(
            child: DropdownButton(
              value: BlocProvider.of<LocalizationManagerBloc>(context)
                  .state
                  .locale,
              onChanged: (Locale? locale) {
                BlocProvider.of<LocalizationManagerBloc>(context).add(
                  ChangeLocale(locale: locale!),
                );
              },
              items: AppLocalizations.supportedLocales
                  .map(
                    (e) => DropdownMenuItem<Locale>(
                      value: e,
                      child: Text(
                        (e.languageCode == 'ne'
                                ? context.locale?.ne
                                : context.locale?.en) ??
                            '',
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
      ],
    );
  }
}
