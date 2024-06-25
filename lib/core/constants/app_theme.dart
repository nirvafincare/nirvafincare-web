import 'package:flutter/material.dart';
import 'package:nirvafincare/core/constants/app_colors.dart';

ThemeData theme(BuildContext context) => ThemeData(
      primaryColor: darkBlue,
      scaffoldBackgroundColor: beige,
      useMaterial3: false,
      fontFamily: 'gotham',
      fontFamilyFallback: const [
        'roboto',
        'arial',
      ],
      textTheme: Theme.of(context).textTheme.apply(
            bodyColor: darkBlue,
            displayColor: darkBlue,
            fontFamily: 'gotham',
          ),
      colorScheme: ColorScheme.fromSeed(
        seedColor: darkBlue,
        primary: darkBlue,
        secondary: lightBlue,
        brightness: Brightness.light,
      ),
    );
