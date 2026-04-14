import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/api_service.dart';
import '../../data/repositories/food_truck_repository.dart';
import '../../domain/usecases/get_food_trucks.dart';
import '../../data/models/food_truck_model.dart';

final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService();
});

final foodTruckRepositoryProvider = Provider((ref) {
  return FoodTruckRepository(ref.read(apiServiceProvider));
});

final getFoodTrucksProvider = Provider((ref) {
  return GetFoodTrucks(ref.read(foodTruckRepositoryProvider));
});

class SearchQueryNotifier extends Notifier<String?> {
  @override
  String? build() => null;

  void setQuery(String? value) {
    state = value;
  }
}

final searchQueryProvider = NotifierProvider<SearchQueryNotifier, String?>(
  SearchQueryNotifier.new,
);

final foodTruckProvider = FutureProvider<List<FoodTruckModel>>((ref) async {
  final query = ref.watch(searchQueryProvider);
  final usecase = ref.read(getFoodTrucksProvider);

  return usecase(query);
});
