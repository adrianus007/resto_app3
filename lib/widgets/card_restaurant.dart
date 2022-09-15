import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restorant_app/data/model/restaurant.dart';
import 'package:restorant_app/provider/database_provider.dart';
import 'package:restorant_app/ui/restaurant_detail_page.dart';
import '../common/styles.dart';

class CardRestaurant extends StatelessWidget {
  final Restaurant restaurant;

  const CardRestaurant({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        return FutureBuilder<bool>(
          future: provider.isFavorited(restaurant.id),
          builder: (context, snapshot) {
            var isBookmarked = snapshot.data ?? false;
            return Material(
              color: primaryColor,
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                leading: Hero(
                  tag: restaurant.pictureId,
                  child: Image.network(
                    'https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}',
                    width: 100,
                  ),
                ),
                title: Text(
                  restaurant.name,
                ),
                subtitle: Text(restaurant.city),
                onTap: () => Navigator.pushNamed(
                  context,
                  RestaurantDetailPage.routeName,
                  arguments: restaurant,
                ),
                trailing: isBookmarked
                    ? IconButton(
                        icon: const Icon(Icons.favorite),
                        color: Theme.of(context).colorScheme.secondary,
                        onPressed: () => provider.removeFavorite(restaurant.id),
                      )
                    : IconButton(
                        icon: const Icon(Icons.favorite_border),
                        color: Theme.of(context).colorScheme.secondary,
                        onPressed: () => provider.addFavorite(restaurant),
                      ),
              ),
            );
          },
        );
      },
    );
  }
}
