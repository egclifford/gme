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
  final List<Color> colorAppBackground = [Colors.blueGrey[800], Colors.green[900]];
  final List<Color> colorAppBar = [Colors.blueGrey[800], Colors.green[900]];
  final List<Color> colorAppBarText = [Colors.white, Colors.white];
  final List<Color> colorDisplayMat = [Colors.grey[100], Colors.grey[100]];
  final List<Color> colorMat = [Colors.blueGrey[800], Colors.green[900]];
  final List<Color> colorMatText = [Colors.white, Colors.white];
  final List<Color> colorMatButton = [Colors.blue[600], Colors.green[600]];
  final List<Color> colorMatButtonText = [Colors.white, Colors.white];

  ThemeData get materialTheme {
    return ThemeData(
      primaryColor: colorAppBar[0],
      backgroundColor: colorAppBackground[0],
      scaffoldBackgroundColor: colorAppBackground[0],
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
