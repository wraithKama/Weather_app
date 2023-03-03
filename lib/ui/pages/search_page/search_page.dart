import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_final/domain/provider/weather_provider.dart';
import 'package:weather_app_final/ui/components/current_region_item/current_region_item.dart';
import 'package:weather_app_final/ui/components/favorite_list/favorite_list.dart';
import 'package:weather_app_final/ui/components/search_page_app_bar/search_page_app_bar.dart';
import 'package:weather_app_final/ui/ui_theme/app_colors.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: WeatherSearchBody(),
    );
  }
}

class WeatherSearchBody extends StatelessWidget {
  const WeatherSearchBody({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<WeatherProvider>(context);
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            model.setBg(),
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          const SearchPageAppBar(),
          const SizedBox(height: 28),
          const CurrentRegionItem(),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 24, left: 16, right: 16),
              child: Text(
                'Изранное',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.blackColor,
                ),
              ),
            ),
          ),
          const FavoriteList(),
        ],
      ),
    );
  }
}
