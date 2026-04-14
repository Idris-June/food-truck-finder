import '../../data/models/food_truck_model.dart';
import '../../data/repositories/food_truck_repository.dart';

class GetFoodTrucks {
  final FoodTruckRepository repository;

  GetFoodTrucks(this.repository);

  Future<List<FoodTruckModel>> call(String? query) {
    return repository.getFoodTrucks(query);
  }
}