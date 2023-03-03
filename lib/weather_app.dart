import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_final/domain/provider/weather_provider.dart';
import 'package:weather_app_final/ui/routes/app_navigator.dart';

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WeatherProvider(),
      child: const MainAppWidget(),
    );
  }
}

class MainAppWidget extends StatelessWidget {
  const MainAppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      initialRoute: AppNavigator.initRoute,
      routes: AppNavigator.routes,
      onGenerateRoute: AppNavigator.generate,
    );
  }
}




/* 

FutureBuilder<WeatherData?>(
      future: Provider.of<WeatherProvider>(context).setUp(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            appBar: snapshot.connectionState == ConnectionState.done
                ? AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    title: RichText(
                      text: TextSpan(
                        children: [
                          const WidgetSpan(
                            child: Icon(
                              Icons.location_on,
                              color: AppColors.redColor,
                            ),
                          ),
                          const TextSpan(text: ' '),
                          TextSpan(
                            text: '${snapshot.data?.timezone}',
                            style: AppStyle.fontStyle,
                          ),
                        ],
                      ),
                    ),
                    centerTitle: true,
                  )
                : null,
            body: const HomePage(),
          );
        } else {
          return const Center(
            child: LoadingIndicator(
              indicatorType: Indicator.lineScalePulseOut,
              colors: [
                Colors.blueAccent,
                Colors.red,
                Colors.yellow,
                Colors.green,
              ],
            ),
          );
        }
      },
    );
 */