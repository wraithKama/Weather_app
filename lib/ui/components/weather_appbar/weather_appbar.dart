import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_final/domain/provider/weather_provider.dart';
import 'package:weather_app_final/ui/ui_theme/app_colors.dart';
import 'package:weather_app_final/ui/ui_theme/app_syle.dart';

class WeatherAppBar extends StatelessWidget implements PreferredSizeWidget {
  const WeatherAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<WeatherProvider>();
    return SafeArea(
      child: Container(
        color: Colors.transparent,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 100,
            ),
            Icon(
              Icons.location_on,
              color: AppColors.redColor,
            ),
            GestureDetector(
              onDoubleTap: () {
                model.setFavorite(
                  context,
                  cityName: model.weatherData?.timezone,
                );
              },
              child: Center(
                child: Text(
                  '${model.weatherData?.timezone}',
                  style: AppStyle.fontStyle,
                ),
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/search');
              },
              icon: Icon(
                Icons.add,
                color: AppColors.iconsColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => throw const SizedBox(height: 20);
}
