import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_final/domain/provider/weather_provider.dart';
import 'package:weather_app_final/ui/ui_theme/app_colors.dart';
import 'package:weather_app_final/ui/ui_theme/app_syle.dart';

class SearchPageAppBar extends StatelessWidget {
  const SearchPageAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<WeatherProvider>(context);
    return SafeArea(
      child: SizedBox(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: AppColors.blackColor,
                size: 26,
              ),
            ),
            SizedBox(
              width: 312,
              height: 35,
              child: TextFormField(
                controller: model.searchController,
                cursorColor: AppColors.blackColor.withOpacity(0.5),
                decoration: InputDecoration(
                  hintText: 'Введите город/регион',
                  hintStyle: AppStyle.fontStyle.copyWith(
                    fontSize: 14,
                    color: const Color.fromRGBO(0, 0, 0, 0.5),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 15,
                  ),
                  fillColor: AppColors.inputColor,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                model.setCurrentCity(context);
              },
              icon: Icon(
                Icons.search,
                color: AppColors.blackColor,
                size: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
