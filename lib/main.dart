import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokemon_app/screens/details_screen.dart';

import 'package:provider/provider.dart';
import './providers/pokemons.dart';
import './screens/tabs_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Pokemons()),
      ],
      child: MaterialApp(
        title: 'Pokemon App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          accentColor: Colors.amber,
          canvasColor: Colors.white,
          textTheme: TextTheme(
            headline6: TextStyle(
              color: Colors.black,
              fontSize: 14,
              letterSpacing: 1,
              fontWeight: FontWeight.bold,
              fontFeatures: [FontFeature.tabularFigures()],
            ),
            headline5: TextStyle(
              color: Colors.black,
              fontSize: 16,
              letterSpacing: 1,
              fontWeight: FontWeight.bold,
              fontFeatures: [FontFeature.tabularFigures()],
            ),
            headline4: TextStyle(
              color: Colors.black,
              fontSize: 16,
              letterSpacing: 1,
              fontFeatures: [FontFeature.tabularFigures()],
            ),
            subtitle1: TextStyle(
              color: Colors.black,
              fontSize: 12,
              letterSpacing: 1,
              fontWeight: FontWeight.w500,
              fontFeatures: [FontFeature.tabularFigures()],
            ),
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (ctx) => TabsScreen(),
          DetailsScreen.routeName: (ctx) => DetailsScreen(),
        },
        onUnknownRoute: (settings) {
          return MaterialPageRoute(
            builder: (ctx) => TabsScreen(),
          );
        },
      ),
    );
  }
}
