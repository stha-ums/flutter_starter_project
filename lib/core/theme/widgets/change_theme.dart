import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter_proj/core/utils/string_extenstions.dart';

import '../bloc/theme_manager_bloc.dart';

class ChangeThemeTristateSwitch extends StatelessWidget {
  const ChangeThemeTristateSwitch({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Change Theme"),
        const SizedBox(width: 10),
        BlocBuilder<ThemeManagerBloc, ThemeMode?>(
          builder: (context, state) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blueGrey,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ...ThemeMode.values.map(
                      (e) => InkWell(
                        onTap: () => BlocProvider.of<ThemeManagerBloc>(context)
                            .add(ChangeThemeMode(themeMode: e)),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          color: state == e
                              ? Theme.of(context).primaryColor
                              : Colors.transparent,
                          child: Text(
                            describeEnum(e).capitalize(),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
