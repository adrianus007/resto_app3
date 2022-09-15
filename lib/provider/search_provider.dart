import 'dart:async';
import 'package:flutter/material.dart';
import 'package:restorant_app/data/api/api_service.dart';
import 'package:restorant_app/data/model/restorant_search.dart';

enum ResultState { loading, noData, hasData, error }

class RestaurantSearchProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantSearchProvider({required this.apiService});

  late RestaurantSearch? _restaurantsResult;
  String _message = '';
  String _query = '';
  late ResultState _state;

  String get message => _message;
  String get query => _query;

  RestaurantSearch? get result => _restaurantsResult;

  ResultState get state => _state;

  Future<dynamic> fetchAllRestaurant(String query) async {
    try {
      _state = ResultState.loading;
      _query = query;

      final screstaurants = await apiService.getSearchRestaurant(query);
      if (screstaurants.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantsResult = screstaurants;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      //$e = 'error internet anda terputus atau gangguan'
      return _message = 'Error, internet anda terputus atau gangguan';
    }
  }
}
