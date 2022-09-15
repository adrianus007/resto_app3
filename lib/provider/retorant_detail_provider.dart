import 'dart:async';
import 'package:flutter/material.dart';
import 'package:restorant_app/data/api/api_service.dart';
import 'package:restorant_app/data/model/restaurant_detail.dart';

enum ResultState { loading, noData, hasData, error }

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService;

  final String restoranId; // restoran id yang digunakan pada api detail..

  RestaurantDetailProvider(
      {required this.apiService, required this.restoranId}) {
    _fetchAllRestaurant();
  }

  late RestaurantDetail _restaurantsResult;
  late ResultState _state;

  RestaurantDetail get result => _restaurantsResult;

  ResultState get state => _state;

  Future<dynamic> _fetchAllRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurantq = await apiService.getDetailRestaurant(restoranId);
      if (restaurantq.restaurant.id.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _restaurantsResult.restaurant.id = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantsResult = restaurantq;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return 'Error --> $e';
    }
  }
}
