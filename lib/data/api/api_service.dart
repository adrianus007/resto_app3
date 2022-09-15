import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restorant_app/data/model/restaurant.dart';

import '../model/restaurant_detail.dart';
import '../model/restorant_search.dart';

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/list';
  static const String baseUrl = 'https://restaurant-api.dicoding.dev/';
  static const String baseUrlImage =
      'https://restaurant-api.dicoding.dev/images/small/';
  static const String _detail = 'detail/';
  static const String _search = 'search';

  Future<RestaurantResult> topHeadlines() async {
    final response = await http.get(Uri.parse(_baseUrl));
    if (response.statusCode == 200) {
      return RestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load top headlines');
    }
  }

  Future<RestaurantDetail> getDetailRestaurant(String id) async {
    final response = await http.get(Uri.parse(baseUrl + _detail + id));
    if (response.statusCode == 200) {
      return RestaurantDetail.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Detail Restaurant');
    }
  }

  Future<RestaurantSearch> getSearchRestaurant(String text) async {
    final response = await http.get(Uri.parse("$baseUrl$_search?q=$text"));
    if (response.statusCode == 200) {
      // Kalau Saya mengubah dari kode :
      // return RestaurantSearch.fromJson(json.decode(response.body));
      // ke:
      // return ListRestaurant.fromJson(json.decode(response.body));
      // Akan muncul error :
      // A value of type 'ListRestaurant' can't be returned from the method 'getSearchRestaurant' because it has a return type of 'Future<RestaurantSearch>'.
      return RestaurantSearch.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load top headlines');
    }
  }
}
