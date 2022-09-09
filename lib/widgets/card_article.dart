import 'package:flutter/material.dart';
import 'package:restorant_app/data/model/article.dart';
import 'package:restorant_app/ui/restaurant_detail_page.dart';
import '../common/styles.dart';

class CardArticle extends StatelessWidget {
  final Restaurant restaurant;

  const CardArticle({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: primaryColor,
      child: ListTile(
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        leading: Hero(
          tag: restaurant.pictureId!,
          child: Image.network(
              'https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}',
            width: 100,
          ),
        ),
        title: Text(
          restaurant.name,
        ),
        subtitle: Text(restaurant.city ?? ''),
        onTap: () => Navigator.pushNamed(
          context,
          RestaurantDetailPage.routeName,
          arguments: restaurant,
        ),
      ),
    );
  }
}
