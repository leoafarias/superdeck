import 'package:flutter/material.dart';

ThemeData get theme => ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.black,
        dynamicSchemeVariant: DynamicSchemeVariant.fidelity,
        contrastLevel: 1,
        error: Colors.red,
        onTertiary: Colors.cyan,
        brightness: Brightness.dark,
      ),
    );
