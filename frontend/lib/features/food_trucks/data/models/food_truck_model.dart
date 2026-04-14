class FoodTruckModel {
  final String? name;
  final String? foodItems;
  final String? latitude;
  final String? longitude;
  final String? address;

  FoodTruckModel({
    this.name,
    this.foodItems,
    this.latitude,
    this.longitude,
    this.address,
  });

  factory FoodTruckModel.fromJson(Map<String, dynamic> json) {
    return FoodTruckModel(
      name: json['name'],
      foodItems: json['food_items'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      address: json['address'],
    );
  }
}