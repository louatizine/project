import 'package:flutter/material.dart';

import '../../../constantes/colors.dart';
import '../../../constantes/sizes.dart';
class TOutlinedButtonTheme{
  TOutlinedButtonTheme._();
  static final lightElevatedButtonTheme = OutlinedButtonThemeData(
      style : OutlinedButton.styleFrom(
    shape: const RoundedRectangleBorder(),
    foregroundColor: tSecondaryColor,
    side: const BorderSide(color: tSecondaryColor),
    padding: const EdgeInsets.symmetric(vertical: tButtonHeight),
  ));
  static final darkOutlinedButton = OutlinedButtonThemeData(
      style : OutlinedButton.styleFrom(
        shape: const RoundedRectangleBorder(),
        foregroundColor: tWhiteColor,
        side: const BorderSide(color: tWhiteColor),
        padding: const EdgeInsets.symmetric(vertical: tButtonHeight),
      )
  );
}