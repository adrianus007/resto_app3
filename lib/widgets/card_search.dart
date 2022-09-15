import 'package:flutter/material.dart';
import 'package:restorant_app/common/styles.dart';
import 'package:restorant_app/data/api/api_service.dart';
import 'package:restorant_app/data/model/restaurant.dart';
import 'package:restorant_app/ui/restaurant_detail_page.dart';

class CardRestaurantSearchPage extends StatelessWidget {
  final Restaurant? restaurantSearchItems;
  const CardRestaurantSearchPage(
      {super.key, required this.restaurantSearchItems});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: primaryColor,
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        leading: Hero(
          tag: restaurantSearchItems!.pictureId,
          child: Image.network(
            ApiService.baseUrlImage + restaurantSearchItems!.pictureId,
            width: 100,
          ),
        ),
        title: Text(
          restaurantSearchItems!.name,
        ),
        subtitle: Text(restaurantSearchItems!.city),
        onTap: () => Navigator.pushNamed(
          context,
          RestaurantDetailPage.routeName,
          arguments: restaurantSearchItems,
        ),
      ),
    );
  }
}
