import 'package:flutter/material.dart';
import 'package:memories/presentation/widget/screen_widget.dart';
import 'package:memories/resource/values.dart';
import 'util/injection_container.dart' as di;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  runApp(
    MaterialApp(
      home: ScreenWidget(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: c_main,
          secondary: c_alt,
          onPrimary: c_text,
          onSecondary: c_text,
        ),
      ),
    ),
  );
}

