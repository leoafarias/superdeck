import 'package:flutter/material.dart';

ThemeData get theme => ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.cyan,
        error: Colors.red,
        onTertiary: Colors.orange,
        brightness: Brightness.dark,
      ),
    );
