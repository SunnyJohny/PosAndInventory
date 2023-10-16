import 'package:flutter/foundation.dart';
import 'package:my_desktop_app/data_lists.dart';


class InventoryDataProvider extends ChangeNotifier {
  // Define your data properties
  List<Map<String, dynamic>> _inventoryData = [];

  // Method to get the inventory data
  List<Map<String, dynamic>> get inventoryData => _inventoryData;

  // Method to fetch or update inventory data
  Future<void> fetchInventoryData() async {
    // Replace this with your actual data fetching logic
    _inventoryData = inventoryData;
    notifyListeners(); // Notify listeners about the change
  }

  // Add any other methods you need for data manipulation
}
