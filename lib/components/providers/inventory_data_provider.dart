import 'package:flutter/material.dart';

class InventoryDataProvider extends ChangeNotifier {
  List<Map<String, dynamic>> inventoryData = [
    {
      'sn': '1',
      'date': '2023-09-20',
      'name': 'Product 1',
      'item id': 'tgs',
      'Qty-In': '3',
      'value': '3',
      'Qty-Out': '3',
      'Qty Balance': '0',
      'cost price': '\$300',
      'sales price': '\$500',
      'category': 'Category 1',
    },
    {
      'sn': '2',
      'date': '2023-09-21',
      'name': 'Product 2',
      'item id': 'xyz',
      'Qty-In': '5',
      'value': '4',
      'Qty-Out': '2',
      'Qty Balance': '3',
      'cost price': '\$250',
      'sales price': '\$600',
      'category': 'Category 2',
    },
    {
      'sn': '3',
      'date': '2023-09-22',
      'name': 'Product 3',
      'item id': 'abc',
      'Qty-In': '2',
      'value': '2',
      'Qty-Out': '1',
      'Qty Balance': '1',
      'cost price': '\$350',
      'sales price': '\$550',
      'category': 'Category 1',
    },
    {
      'sn': '4',
      'date': '2023-09-23',
      'name': 'Product 4',
      'item id': 'def',
      'Qty-In': '4',
      'value': '4',
      'Qty-Out': '3',
      'Qty Balance': '1',
      'cost price': '\$400',
      'sales price': '\$700',
      'category': 'Category 2',
    },
    {
      'sn': '5',
      'date': '2023-09-24',
      'name': 'Product 5',
      'item id': 'ghi',
      'Qty-In': '6',
      'value': '6',
      'Qty-Out': '5',
      'Qty Balance': '1',
      'cost price': '\$320',
      'sales price': '\$480',
      'category': 'Category 1',
    },
    {
      'sn': '6',
      'date': '2023-09-25',
      'name': 'Product 6',
      'item id': 'jkl',
      'Qty-In': '3',
      'value': '3',
      'Qty-Out': '2',
      'Qty Balance': '1',
      'cost price': '\$280',
      'sales price': '\$520',
      'category': 'Category 2',
    },
    {
      'sn': '7',
      'date': '2023-09-26',
      'name': 'Product 7',
      'item id': 'mno',
      'Qty-In': '5',
      'value': '5',
      'Qty-Out': '4',
      'Qty Balance': '1',
      'cost price': '\$380',
      'sales price': '\$600',
      'category': 'Category 1',
    },
    {
      'sn': '8',
      'date': '2023-09-27',
      'name': 'Product 8',
      'item id': 'pqr',
      'Qty-In': '4',
      'value': '4',
      'Qty-Out': '3',
      'Qty Balance': '1',
      'cost price': '\$420',
      'sales price': '\$720',
      'category': 'Category 2',
    },
    {
      'sn': '9',
      'date': '2023-09-28',
      'name': 'Product 9',
      'item id': 'stu',
      'Qty-In': '7',
      'value': '7',
      'Qty-Out': '6',
      'Qty Balance': '1',
      'cost price': '\$300',
      'sales price': '\$500',
      'category': 'Category 1',
    },
    {
      'sn': '10',
      'date': '2023-09-29',
      'name': 'Product 10',
      'item id': 'vwx',
      'Qty-In': '8',
      'value': '8',
      'Qty-Out': '7',
      'Qty Balance': '1',
      'cost price': '\$350',
      'sales price': '\$550',
      'category': 'Category 2',
    },
    {
      'sn': '10',
      'date': '2023-09-29',
      'name': 'Product 10',
      'item id': 'vwx',
      'Qty-In': '8',
      'value': '8',
      'Qty-Out': '7',
      'Qty Balance': '1',
      'cost price': '\$350',
      'sales price': '\$550',
      'category': 'Category 2',
    },
    {
      'sn': '10',
      'date': '2023-09-29',
      'name': 'Product 10',
      'item id': 'vwx',
      'Qty-In': '8',
      'value': '8',
      'Qty-Out': '7',
      'Qty Balance': '1',
      'cost price': '\$350',
      'sales price': '\$550',
      'category': 'Category 2',
    },
    {
      'sn': '10',
      'date': '2023-09-29',
      'name': 'Product 10',
      'item id': 'vwx',
      'Qty-In': '8',
      'value': '8',
      'Qty-Out': '7',
      'Qty Balance': '1',
      'cost price': '\$350',
      'sales price': '\$550',
      'category': 'Category 2',
    },
    // Add more data if needed
  ];
  // Variables for date filtering
  DateTime? fromDate;
  DateTime? toDate;
  String searchText = '';

  // Pagination variables
  int currentPage = 1;
  int itemsPerPage = 10; // Adjust this based on your preference

  // Previous page
  void previousPage() {
    if (currentPage > 1) {
      currentPage--;
      notifyListeners();
    }
  }

  // Next page
  void nextPage() {
    final maxPage = (inventoryData.length / itemsPerPage).ceil();
    if (currentPage < maxPage) {
      currentPage++;
      notifyListeners();
    }
  }

  // Apply date filtering
  void filterByDate(DateTime? from, DateTime? to) {
    fromDate = from;
    toDate = to;
    currentPage = 1; // Reset page to 1 when applying filters
    notifyListeners();
  }

  // Search by item name
  void searchByItemName(String query) {
    searchText = query;
    currentPage = 1; // Reset page to 1 when searching
    notifyListeners();
  }

  // Getter method for paginated and filtered data
  List<Map<String, dynamic>> get paginatedAndFilteredData {
    // Add your date and search filtering logic here
    List<Map<String, dynamic>> filteredData = List.from(inventoryData);

    if (fromDate != null && toDate != null) {
      filteredData = filteredData.where((item) {
        final itemDate = DateTime.parse(item['date']);
        return itemDate.isAfter(fromDate!) &&
            itemDate.isBefore(toDate!.add(Duration(days: 1)));
      }).toList();
    }

    if (searchText.isNotEmpty) {
      filteredData = filteredData.where((item) {
        return item['name'].toLowerCase().contains(searchText.toLowerCase());
      }).toList();
    }

    final startIndex = (currentPage - 1) * itemsPerPage;
    return filteredData.skip(startIndex).take(itemsPerPage).toList();
  }

  Future<void> fetchInventoryData() async {
    // Fetching data from a repository can be added here if needed.
    notifyListeners();
  }
}
