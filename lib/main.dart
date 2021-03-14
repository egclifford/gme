import 'data_model.dart';
import 'home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

extension BuildContextExtension on BuildContext {
  AppThemeData get appTheme {
    return watch<AppThemeData>();
  }
}

class AppThemeData {
  final Color colorAppBackground = Colors.blueGrey[800];
  final Color colorAppBar = Colors.blueGrey[800];
  final Color colorAppBarText = Colors.white;
  final Color colorDisplayMat = Colors.grey[100];
  final Color colorMat = Colors.blueGrey[800];
  final Color colorMatText = Colors.white;
  final Color colorMatButton = Colors.blue[600];
  final Color colorMatButtonText = Colors.white;

  ThemeData get materialTheme {
    return ThemeData(
      primaryColor: colorAppBar,
      backgroundColor: colorAppBackground,
      scaffoldBackgroundColor: colorAppBackground,
    );
  }
}

class AppTheme extends StatelessWidget {
  final Widget child;
  AppTheme({this.child});

  @override
  Widget build(BuildContext context) {
    final themeData = AppThemeData(); // Online this has context as an arg.
    return Provider.value(value: themeData, child: child);
  }
}

class GmeApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AppTheme(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'GM Emulator',
        theme: AppThemeData().materialTheme,
        home: HomeScreen(),
      ),
    );
  }
}

void main() {
  runApp(
    ChangeNotifierProvider<GmeModel>(
      create: (context) => GmeModel(context),
      child: GmeApp(),
    )
  );
}
