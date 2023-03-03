import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app_final/domain/hive/favorite_history.dart';
import 'package:weather_app_final/domain/hive/hive_boxes.dart';
import 'package:weather_app_final/weather_app.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
 
  await Hive.initFlutter();
  Hive.registerAdapter(FavoriteHistoryAdapter());
  await Hive.openBox<FavoriteHistory>(HiveBoxes.favoriteBox);

  await dotenv.load(fileName: '.env');
  runApp(
    const WeatherApp(),
  );
}
