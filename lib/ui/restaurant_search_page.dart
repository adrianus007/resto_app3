import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restorant_app/data/api/api_service.dart';
import 'package:restorant_app/widgets/card_search.dart';

import '../provider/search_provider.dart';


class SearchPage extends SearchDelegate<RestaurantSearchProvider>{


  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [IconButton(icon: const Icon(Icons.clear), onPressed: () {
      query = "";
    })];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {Navigator.pop(context);});
  }

  @override
  Widget buildResults(BuildContext context) {

    return ChangeNotifierProvider<RestaurantSearchProvider>(
      create: (_) => RestaurantSearchProvider(apiService: ApiService())
        ..fetchAllRestaurant(query),
      child: Consumer<RestaurantSearchProvider>(
        builder: (context, state, _) {
          if (state.state == ResultState.Loading) {
            return const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.blueAccent,
              ),
            );
          } else if (query.length < 3) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Center(
                  child: Text(
                    "Pencarian harus lebih dari 2 huruf",
                  ),
                )
              ],
            );
          } else if (state.state == ResultState.HasData) {
            //Tampilan 1
            return ListView.builder(
              shrinkWrap: true,
              itemCount: state.result!.restaurants.length,
              itemBuilder: (context, index) {
                var restaurantItem = state.result!.restaurants[index];
                return CardRestaurantSearchPage(restaurantSearchItems: restaurantItem);

              },
            );


          } else if (state.state != ResultState.HasData) {
            //Tampilan 2
            // Provider.of<RestaurantSearchProvider>(context, listen: false);
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Center(
                  child: Text(
                    "Data tidak ditemukan atau tidak sesuai",
                  ),
                )
              ],
            );
          } else if (query.isEmpty) {
            //Tampilan 3
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Center(
                  child: Text(
                    "Data belum diisi",
                  ),
                )
              ],
            );
          } else {
            //Tampilan 4
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Center(
                  child: Text(""),
                )
              ],
            );
          }
        },
      ),
    );

  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return const Center(
      child: Text('Masukkan kata kunci disini'),
    );
  }

}