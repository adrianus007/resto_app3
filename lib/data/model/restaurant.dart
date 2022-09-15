class ArticleResult {
  ArticleResult({
    required this.error,
    required this.message,
    required this.count,
    required this.restaurants,
  });

  bool error;
  String message;
  int count;
  List<Restaurant> restaurants;

  factory ArticleResult.fromJson(Map<String, dynamic> json) => ArticleResult(
    error: json["error"],
    message: json["message"],
    count: json["count"],

    restaurants: List<Restaurant>.from(json["restaurants"].map((x) => Restaurant.fromJson(x))
    .where((restaurants) =>
    restaurants.id != null &&
    restaurants.name != null &&
    restaurants.description != null &&
    restaurants.pictureId != null &&
    restaurants.city != null &&
    restaurants.rating != null)),
  );

}

class Restaurant {
  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  String id;
  String name;
  String description;
  String pictureId;
  String city;
  double rating;

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    pictureId: json["pictureId"],
    city: json["city"],
    rating: json["rating"].toDouble(),
  );

}
