import '../../../../core/network/api_service.dart';
import '../models/food_truck_model.dart';

class FoodTruckRepository {
  final ApiService api;

  FoodTruckRepository(this.api);

  Future<List<FoodTruckModel>> getFoodTrucks(String? query) async {
    final response = await api.getFoodTrucks(query: query);

    return response
        .map<FoodTruckModel>((json) => FoodTruckModel.fromJson(json))
        .toList();
  }
}