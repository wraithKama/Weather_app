import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app_final/domain/api/api.dart';
import 'package:weather_app_final/domain/hive/favorite_history.dart';
import 'package:weather_app_final/domain/hive/hive_boxes.dart';
import 'package:weather_app_final/domain/json_convertors/coord.dart';
import 'package:weather_app_final/domain/json_convertors/weather_data.dart';
import 'package:weather_app_final/ui/constants/constants.dart';
import 'package:weather_app_final/ui/resources/app_bg.dart';
import 'package:weather_app_final/ui/ui_theme/app_colors.dart';

class WeatherProvider extends ChangeNotifier {
  //хранение координат
  static Coord? _coords;
  Coord? get coords => _coords;

  //хранение данных о погоде
  WeatherData? weatherData;

  //хранение текущих данных о погоде
  Current? current;

  //контроллер ввода
  TextEditingController searchController = TextEditingController();

/*Главная функция которую мы запускаем в Futurebuilder*/

  Future<WeatherData?> setUp({String? cityName}) async {
    final pref = await SharedPreferences.getInstance();

    cityName = pref.getString('city_name');
    _coords = await Api.getCoords(cityName: cityName ?? 'Ташкент');
    weatherData = await Api.getWeather(coords);
    current = weatherData?.current;
    setCurrentTime();
    setCurrentTemp();
    setSevenDays();
    return weatherData;
  }

/*установка текущего города*/

  void setCurrentCity(BuildContext context, {String? cityName}) async {
    if (searchController.text != null && searchController.text != '') {
      cityName = searchController.text;
      final pref = await SharedPreferences.getInstance();
      await pref.setString('city_name', cityName);
      await setUp(cityName: pref.getString('city_name'))
          .then((value) => Navigator.pop(context))
          .then((value) => searchController.clear());
      notifyListeners();
    }
  }

  /* текущее время  */

  String? currentTime;

  String setCurrentTime() {
    final getTime = (current?.dt ?? 0) + (weatherData?.timezoneOffset ?? 0);
    final setTime = DateTime.fromMillisecondsSinceEpoch(getTime * 1000);
    currentTime = DateFormat('HH:mm a').format(setTime);

    return currentTime ?? 'Error';
  }
  //*******************/

/* текущий статус погоды*/
  String currentStatus = 'Ошибка';

  String getCurrentStatus() {
    currentStatus = current?.weather?[0].description ?? 'ошибка';
    return capitalize(currentStatus);
  }
//**********************/

/*получение текущей иконки в зависимости от погоды*/
  String iconData() {
    return '${Constants.weatherIconsUrl}${current?.weather?[0].icon}.png';
  }
  //**********************/

/* получение иконок для каждого дня недели в зависимости от погоды */

  final String _iconUrlPath = 'http://openweathermap.org/img/wn/';

  String setDailyIcons(int index) {
    final String getIcon = '${weatherData?.daily?[index].weather?[0].icon}';
    final String setIcon = '$_iconUrlPath$getIcon.png';

    return setIcon;
  }

  //**********************/

  /* получение дневной температуры на каждый день*/
  int dailyTemp = 0;

  int setDailyTemp(int index) {
    dailyTemp =
        ((weatherData?.daily?[index].temp?.morn ?? -kelvin) + kelvin).round();
    return dailyTemp;
  }

  //**********************/

  /* получение ночной температуры на каждый день*/

  int nightTemp = 0;

  int setNightTemp(int index) {
    nightTemp =
        ((weatherData?.daily?[index].temp?.night ?? -kelvin) + kelvin).round();
    return nightTemp;
  }

/*приведение градусов погоды к Цельсию*/
  int kelvin = -273;

  int currentTemp = 0;
  // обработка текущей погоды
  int setCurrentTemp() {
    currentTemp = ((current?.temp ?? -kelvin) + kelvin).round();
    return currentTemp;
  }

  //**********************/

/* max температура */

  int maxTemp = 0;

  String setMaxTemp() {
    maxTemp = ((weatherData?.daily?[0].temp?.max ?? -kelvin) + kelvin).round();
    return maxTemp.toString();
  }

  //**********************/

/* min температура */

  int minTemp = 0;

  String setMinTemp() {
    minTemp = ((weatherData?.daily?[0].temp?.min ?? -kelvin) + kelvin).round();
    return minTemp.toString();
  }

  //**********************/

  /* изменение заднего фона */

  String? currentBg;

  String setBg() {
    int id = current?.weather?[0].id ?? -1;

    if (id == -1 || current?.sunset == null || current?.dt == null) {
      currentBg = AppBg.shinyDay;
    }

    try {
      if (current!.sunset! < current!.dt!) {
        if (id >= 200 && id <= 531) {
          currentBg = AppBg.rainyNight;
          AppColors.sevenDayBoxColor = const Color.fromRGBO(35, 35, 35, 0.5);
          AppColors.gridBoxColor = const Color.fromRGBO(35, 35, 35, 0.5);
          AppColors.darkBlueColor = const Color(0xFFFFFFFF);
          AppColors.blackColor = const Color(0xFFFFFFFF);
          AppColors.iconsColor = const Color(0xFFFFFFFF);
          AppColors.sunItemColor = const Color(0xFFFFFFFF);
        } else if (id >= 600 && id <= 622) {
          currentBg = AppBg.snowNight;
          AppColors.sevenDayBoxColor = const Color.fromRGBO(12, 23, 27, 0.5);
          AppColors.gridBoxColor = const Color.fromRGBO(12, 23, 27, 0.5);
        } else if (id >= 701 && id <= 781) {
          currentBg = AppBg.fogNight;
          AppColors.blackColor = const Color(0xFFFFFFFF);
          AppColors.nightTempColor = const Color(0xFF999999);
          AppColors.sevenDayBoxColor = const Color.fromRGBO(35, 35, 35, 0.5);
          AppColors.gridBoxColor = const Color.fromRGBO(35, 35, 35, 0.5);
          AppColors.darkBlueColor = const Color(0xFFFFFFFF);
          AppColors.weatherStatusIconColor =
              const Color.fromARGB(237, 37, 36, 36);
        } else if (id == 800) {
          currentBg = AppBg.shinyNight;
          AppColors.sevenDayBoxColor = const Color.fromRGBO(47, 97, 148, 0.5);
          AppColors.gridBoxColor = const Color.fromRGBO(47, 97, 148, 0.5);
        } else if (id >= 801 && id <= 804) {
          currentBg = AppBg.cloudyNight;
          AppColors.sevenDayBoxColor = const Color.fromRGBO(12, 23, 27, 0.5);
          AppColors.gridBoxColor = const Color.fromRGBO(12, 23, 27, 0.5);
        }
      } else {
        if (id >= 200 && id <= 531) {
          currentBg = AppBg.rainyDay;
          AppColors.sevenDayBoxColor = const Color.fromRGBO(106, 141, 135, 0.5);
          AppColors.gridBoxColor = const Color.fromRGBO(106, 141, 135, 0.5);
        } else if (id >= 600 && id <= 622) {
          currentBg = AppBg.snowDay;
          AppColors.sevenDayBoxColor = const Color.fromRGBO(109, 160, 192, 0.5);
          AppColors.gridBoxColor = const Color.fromRGBO(109, 160, 192, 0.5);
        } else if (id >= 701 && id <= 781) {
          currentBg = AppBg.fogDay;
          AppColors.sevenDayBoxColor = const Color.fromRGBO(142, 141, 141, 0.5);
          AppColors.gridBoxColor = const Color.fromRGBO(142, 141, 141, 0.5);
        } else if (id == 800) {
          currentBg = AppBg.shinyDay;
          AppColors.sevenDayBoxColor = const Color.fromRGBO(80, 130, 155, 0.3);
          AppColors.gridBoxColor = const Color.fromARGB(121, 140, 196, 224);
        } else if (id >= 801 && id <= 804) {
          currentBg = AppBg.cloudyDay;
          AppColors.sevenDayBoxColor = const Color.fromRGBO(140, 155, 170, 0.5);
          AppColors.gridBoxColor = const Color.fromRGBO(140, 155, 170, 0.5);
        }
      }
    } catch (e) {
      return AppBg.shinyDay;
    }

    return currentBg ?? AppBg.shinyDay;
  }

  //**********************/

  /* установка дней недели */

  final List<String> _date = [];
  List<String> get date => _date;

  List<Daily> _daily = [];
  List<Daily> get daily => _daily;

  void setSevenDays() {
    _daily = weatherData!.daily!;
    for (var i = 0; i < _daily.length; i++) {
      if (i == 0 && _daily.isNotEmpty) {
        _date.clear();
      }

      if (i == 0) {
        date.add('Сегодня');
      } else if (i == 1) {
        date.add('Завтра');
      } else {
        var timeNum = _daily[i].dt * 1000;
        var itemDate = DateTime.fromMillisecondsSinceEpoch(timeNum);
        _date.add(capitalize(DateFormat('EEEE', 'ru').format(itemDate)));
      }
    }
  }

  //**********************/

  /*метод превращения первой буквы слова в заглавную, остальные строчные*/

  String capitalize(String str) => str[0].toUpperCase() + str.substring(1);

  //**********************/

  /*Добавление в массив данных о погодных условиях*/
  final List<dynamic> _weatherValues = [];
  List<dynamic> get weatheValues => _weatherValues;

  dynamic setValues(int index) {
    _weatherValues.add((current?.windSpeed ?? 0));
    _weatherValues
        .add(((current?.feelsLike ?? -kelvin) + kelvin).roundToDouble());

    _weatherValues.add((current?.humidity ?? 0) / 1);
    _weatherValues.add((current?.visibility ?? 0) / 1000);
    return weatheValues[index];
  }

  //**********************/

  /*текущее время восхода*/
  String sunRise = '';

  String setCurrentSunRise() {
    final getSunTime =
        (current?.sunrise ?? 0) + (weatherData?.timezoneOffset ?? 0);

    final setSunRise = DateTime.fromMillisecondsSinceEpoch(getSunTime * 1000);
    sunRise = DateFormat('HH:mm a').format(setSunRise);
    return sunRise;
  }

  //**********************/
  /*текущее время заката*/
  String sunSet = '';

  String setCurrentSunSet() {
    final getSunTime =
        (current?.sunset ?? 0) + (weatherData?.timezoneOffset ?? 0);

    final setSunSet = DateTime.fromMillisecondsSinceEpoch(getSunTime * 1000);
    sunSet = DateFormat('HH:mm a').format(setSunSet);
    return sunSet;
  }
  //**********************/

  /*добавление в избранное*/

  Future<void> setFavorite(BuildContext context, {String? cityName}) async {
    var box = Hive.box<FavoriteHistory>(HiveBoxes.favoriteBox);
    box
        .add(
          FavoriteHistory(
            weatherData?.timezone ?? 'Error',
            currentBg ?? AppBg.shinyDay,
            AppColors.darkBlueColor.value,
          ),
        )
        .then(
          (value) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColors.sevenDayBoxColor,
              content: Text(
                'Город $cityName добавлен в избранное',
              ),
            ),
          ),
        );
    // for (var city in box.values.toList()) {
    //   if (city.cityName != cityName) {

    //   } else {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(
    //         backgroundColor: AppColors.redColor,
    //         content: const Text('Такой Город уже есть'),
    //       ),
    //     );
    //   }
    // }
  }
  //**********************/

  /*удаление из избранных*/
  Future<void> deleteFavorite(int index) async {
    var box = Hive.box<FavoriteHistory>(HiveBoxes.favoriteBox);
    box.deleteAt(index);
  }
  //**********************/
}
