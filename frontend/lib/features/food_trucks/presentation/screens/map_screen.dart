import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/utils/debouncer.dart';
import '../../../../core/utils/dialog_utils.dart';
import '../providers/food_truck_provider.dart';
import '../../data/models/food_truck_model.dart';

class MapScreen extends ConsumerWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final debouncer = Debouncer(delay: 500);
    final data = ref.watch(foodTruckProvider);

    ref.listen(foodTruckProvider, (previous, next) {
      next.whenOrNull(
        error: (e, _) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text("Failed to load food trucks"),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
        },
      );
    });

    return Scaffold(
      body: Stack(
        children: [
          Stack(
            children: [
              FlutterMap(
                options: MapOptions(
                  initialCenter: LatLng(37.7749, -122.4194),
                  initialZoom: 12,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                  ),
                  data.maybeWhen(
                    data: (List<FoodTruckModel> trucks) {
                      final markers = trucks
                          .map((truck) {
                            final lat = double.tryParse(truck.latitude ?? "");
                            final lng = double.tryParse(truck.longitude ?? "");

                            if (lat == null || lng == null) return null;

                            return Marker(
                              point: LatLng(lat, lng),
                              width: 50,
                              height: 50,
                              child: GestureDetector(
                                onTap: () {
                                  showFoodTruckDetails(context, truck);
                                },
                                child: const Icon(
                                  Icons.location_on,
                                  size: 36,
                                  color: Colors.red,
                                ),
                              ),
                            );
                          })
                          .whereType<Marker>()
                          .toList();

                      return MarkerLayer(markers: markers);
                    },
                    orElse: () => const SizedBox.shrink(),
                  ),
                ],
              ),

              data.maybeWhen(
                loading: () => Container(
                  color: Colors.black.withValues(alpha: 0.2),
                  child: const Center(
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 16,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(height: 10),
                            Text("Loading food trucks..."),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                orElse: () => const SizedBox.shrink(),
              ),
            ],
          ),

          Positioned(
            top: 40,
            left: 16,
            right: 16,
            child: Material(
              elevation: 6,
              borderRadius: BorderRadius.circular(30),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: "Search food trucks...",
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 14),
                ),
                onChanged: (value) {
                  debouncer.run(() {
                    ref
                        .read(searchQueryProvider.notifier)
                        .setQuery(value.isEmpty ? null : value);
                  });
                },
              ),
            ),
          ),

          const Positioned(
            top: 10,
            left: 16,
            child: Text(
              "🍔 Food Truck Finder",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
