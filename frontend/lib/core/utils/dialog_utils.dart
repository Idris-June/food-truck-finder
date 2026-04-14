import 'package:flutter/material.dart';
import '../../features/food_trucks/data/models/food_truck_model.dart';

void showFoodTruckDetails(BuildContext context, FoodTruckModel truck) {
  final foodItems = (truck.foodItems ?? "")
      .split(':')
      .map((e) => e.trim())
      .where((e) => e.isNotEmpty)
      .toList();

  showDialog(
    context: context,
    builder: (_) => Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 450),
        child: Material(
          borderRadius: BorderRadius.circular(16),
          elevation: 6,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),

                    Text(
                      truck.name ?? "Unknown",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 12),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 18,
                          color: Colors.red,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            truck.address ?? "No address",
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    const Text(
                      "Menu",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),

                    const SizedBox(height: 8),

                    SizedBox(
                      height: 120,
                      child: foodItems.isEmpty
                          ? const Center(child: Text("No menu available"))
                          : ListView.builder(
                              itemCount: foodItems.length,
                              itemBuilder: (_, i) => Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 2,
                                ),
                                child: Row(
                                  children: [
                                    const Icon(Icons.circle, size: 6),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        foodItems[i],
                                        style: const TextStyle(fontSize: 13),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                    ),
                  ],
                ),

                Positioned(
                  top: 0,
                  right: 0,
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
