import 'package:provider/provider.dart';
import 'screens/mood_screen.dart';
import './screens/now_playing_screen.dart';
import './providers/imp_data_provider.dart';
import './helpers/my_colors.dart';
import './providers/exercise_provider.dart';
import './screens/exercise_pack_screen.dart';
import './screens/calories_screen.dart';
import './screens/exercise_screen.dart';
import 'root_page.dart';
import './screens/settings_screen.dart';
import './screens/splash_screen.dart';
import './screens/water_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (BuildContext context) => ImpDataProvider()),
        ChangeNotifierProvider(
            create: (BuildContext context) => ExerciseProvider()),
      ],
      child: MaterialApp(
        initialRoute: '/',
        debugShowCheckedModeBanner: false,
        title: 'TrackIt',
        theme: ThemeData(
          primarySwatch: MyColors().teal,
          accentColor: MyColors().myAmber,
          backgroundColor: MyColors().bgColor,
        ),
        home: Rootpage(),
        routes: {
          Rootpage.routName: (ctx) => Rootpage(),
          SplashScreen.routName: (ctx) => SplashScreen(),
          CaloriesScreen.routName: (ctx) => CaloriesScreen(),
          ExerciseScreen.routName: (ctx) => ExerciseScreen(),
          WaterScreen.routName: (ctx) => WaterScreen(),
          SettingsScren.routName: (ctx) => SettingsScren(),
          ExercisePackScreen.routName: (ctx) => ExercisePackScreen(),
          NowPlayingScreen.routName: (ctx) => NowPlayingScreen(),
          MoodScreen.routName: (ctx) => MoodScreen()
          //TODO: call SplashScreen
        },
      ),
    );
  }
}
