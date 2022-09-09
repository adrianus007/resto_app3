import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restorant_app/data/model/article.dart';

import '../data/api/api_service.dart';
import '../provider/retorant_detail_provider.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/article_detail';

  final Restaurant restaurant;

  const RestaurantDetailPage({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantDetailProvider>(
        create: (_) => RestaurantDetailProvider(restoranId: restaurant.id, apiService: ApiService()),
        child: Consumer<RestaurantDetailProvider>(
        builder: (context, state, _) {
      if (state.state == ResultState.Loading) {
        return const Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.blueAccent,
          ),
        );
      } else if (state.state == ResultState.HasData) {

        return Scaffold(
          appBar: AppBar(
            title: const Text('Detail Restaurant'),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Hero(
                  tag: restaurant.pictureId,
                  child: Image.network(
                      'https://restaurant-api.dicoding.dev/images/large/${restaurant.pictureId}'
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        restaurant.name,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      const Divider(color: Colors.grey),
                      Text(
                        'Date: ${restaurant.city}',
                        style: Theme.of(context).textTheme.caption,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Author: ${restaurant.rating}',
                        style: Theme.of(context).textTheme.caption,
                      ),
                      const Divider(color: Colors.grey),
                      Text(
                        restaurant.description ?? "-",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),

                const ListTile(
                  leading: Icon(Icons.category),
                  title: Text('Categories'),
                ),
                SizedBox(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.result.restaurant.categories.length,
                    itemBuilder: (context, index) => ListTile(
                      subtitle: Text(state.result.restaurant.categories[index].name),
                    ),
                  ),
                ),


                const ListTile(
                  leading: Icon(Icons.food_bank),
                  title: Text('Food'),
                ),
                SizedBox(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.result.restaurant.menus.foods.length,
                    itemBuilder: (context, index) => ListTile(
                      subtitle: Text(state.result.restaurant.menus.foods[index].name),
                    ),
                  ),
                ),
                const ListTile(
                  leading: Icon(Icons.local_drink),
                  title: Text('Drink'),
                ),
                SizedBox(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.result.restaurant.menus.drinks.length,
                    itemBuilder: (context, index) => ListTile(
                      subtitle: Text(state.result.restaurant.menus.drinks[index].name),
                    ),
                  ),
                ),

              ],
            ),
          ),
        );
      } else if (state.state == ResultState.NoData) {
        return const Scaffold(
            body: Center(
                child: Text('Eror memuat data')
            )
        );

      } else if (state.state == ResultState.Error) {
        return const Scaffold(
            body: Center(
                child: Text('Gagal memuat data, silahkan periksa koneksi internet Anda')
            )
        );
      } else {
        return const Scaffold(body: Center(child: Text('')));
      }

        },
    )
    );
  }
}
