import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:starter_proj/core/theme/bloc/theme_manager_bloc.dart';

import 'theme_manager_bloc_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  late MockSharedPreferences mockSharedPreferences;
  late ThemeManagerBloc themeManagerBloc;
  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    themeManagerBloc =
        ThemeManagerBloc(sharedPreferences: mockSharedPreferences);
  });

  const tThemeModeKey = 'themeMode';
  test('initial state should be [ThemeMode.system]', () {
    //asseert
    expect(themeManagerBloc.state, equals(ThemeMode.system));
  });

  group('tests init event', () {
    arrangeSharePrefsGetInitToGet1() =>
        when(mockSharedPreferences.getInt(tThemeModeKey))
            .thenAnswer((realInvocation) => 1);
    arrangeSharePrefsGetInitToGet2() =>
        when(mockSharedPreferences.getInt(tThemeModeKey))
            .thenAnswer((realInvocation) => 2);

    arrangeSharePrefsGetInitToGetException() =>
        when(mockSharedPreferences.getInt(tThemeModeKey))
            .thenThrow("Random unkown exception");
    test('shoud return Thememode.light', () {
      //arrage
      arrangeSharePrefsGetInitToGet1();

      //assert later
      expectLater(themeManagerBloc.stream, emitsInOrder([ThemeMode.light]));

      ///act
      themeManagerBloc.add(Init());
    });

    test('shoud return Thememode.Dark', () {
      //arrage
      arrangeSharePrefsGetInitToGet2();

      //assert later
      expectLater(themeManagerBloc.stream, emitsInOrder([ThemeMode.dark]));

      ///act
      themeManagerBloc.add(Init());
    });

    test('shoud return Thememode.System', () {
      //arrage
      arrangeSharePrefsGetInitToGetException();

      //assert later
      expectLater(themeManagerBloc.stream, emitsInOrder([ThemeMode.system]));

      ///act
      themeManagerBloc.add(Init());
    });

    test('shoud return Thememode.system on exception', () {
      //arrage
      arrangeSharePrefsGetInitToGet1();

      //assert later
      expectLater(themeManagerBloc.stream, emitsInOrder([ThemeMode.light]));

      ///act
      themeManagerBloc.add(Init());
    });
  });

  group('tests change Theme event', () {
    arrageSharePrefsSet() =>
        when(mockSharedPreferences.setInt(tThemeModeKey, 1))
            .thenAnswer((realInvocation) async => true);

    test('should save and return thememode.light', () {
      arrageSharePrefsSet();

      //assert later
      expectLater(themeManagerBloc.stream, emitsInOrder([ThemeMode.light]));

      ///act
      themeManagerBloc.add(const ChangeThemeMode(themeMode: ThemeMode.light));
    });
  });
}
