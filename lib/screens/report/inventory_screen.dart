import 'package:flutter/material.dart';
import 'package:my_desktop_app/components/product.dart';
import 'package:my_desktop_app/components/cart_panel.dart';
import 'package:my_desktop_app/components/inventory_side_panel.dart';
import 'package:my_desktop_app/screens/report/dashboard.dart';
import 'package:my_desktop_app/screens/report/bug_report.dart';

import 'package:my_desktop_app/components/custom_table.dart';

import 'package:my_desktop_app/screens/report/add_product_screen.dart';
import 'package:my_desktop_app/components/dashboard_widget.dart';
// import 'package:my_desktop_app/data_lists.dart';

import 'package:provider/provider.dart';
import 'package:my_desktop_app/components/providers/inventory_data_provider.dart';
import 'package:my_desktop_app/data/inventory_data_repository.dart';

class InventoryScreen extends StatefulWidget {
  @override
  _InventoryScreenState createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  String selectedItem = 'Dashboard'; // Hardcoded selected
  int currentPage = 1;
  int itemsPerPage = 6;

  DateTime? fromDate;
  DateTime? toDate;
  bool isToDateSelected = false;
  String _searchText = '';

  List<Map<String, dynamic>> filteredAndPaginatedData = [];
  List<Map<String, dynamic>> items = [];

  Future<void> _selectFromDate(DateTime? selectedDate) async {
    if (selectedDate != null) {
      setState(() {
        fromDate = selectedDate;
      });
    }
  }

  Future<void> _selectToDate(DateTime? selectedDate) async {
    if (selectedDate != null) {
      setState(() {
        toDate = selectedDate;
      });
    }
  }

  void _printIncomeStatementWrapper() {
    // Call your existing _printIncomeStatement function here
    _printIncomeStatement();
  }

  void sortItemsByDate() {
    items.sort((a, b) {
      // Convert the date strings to DateTime objects
      DateTime dateA = DateTime.parse(a['date']);
      DateTime dateB = DateTime.parse(b['date']);

      // Sort in descending order (latest date first)
      return dateB.compareTo(dateA);
    });
  }

  // Update the paginatedItems getter method to handle filtering and pagination
  List<Map<String, dynamic>> get paginatedItems {
    sortItemsByDate(); // Sort the items before pagination
    List<Map<String, dynamic>> filtered = [];

    if (fromDate != null && toDate != null) {
      // If both fromDate and toDate are selected, filter by date range
      filtered = items.where((item) {
        final itemDate = DateTime.parse(item['date']);
        return itemDate.isAfter(fromDate!) &&
            itemDate.isBefore(toDate!.add(Duration(days: 1)));
      }).toList();
    } else {
      // If no date range is selected, show all items
      filtered = items;
    }

    // Apply additional filtering based on the search text
    if (_searchText.isNotEmpty) {
      filtered = filtered.where((item) {
        // Customize this part based on your search logic
        // For example, check if the item name contains the search text
        return item['name'].toLowerCase().contains(_searchText.toLowerCase());
      }).toList();
    }

    // Apply pagination
    final startIndex = (currentPage - 1) * itemsPerPage;
    filteredAndPaginatedData =
        filtered.skip(startIndex).take(itemsPerPage).toList();

    return filteredAndPaginatedData;
  }

  Widget renderSelectedWidget() {
    final inventoryDataProvider = Provider.of<InventoryDataProvider>(context);
    final items = inventoryDataProvider.inventoryData;
    switch (selectedItem) {
      case 'Inventory Report':
        return Text('Render Inventory Report Widget here');
      case 'Add Product':
        return AddProductScreen();
      case 'Categories':
        return Text('Render Categories Widget here');
      case 'Account':
        return Text('Render Account Widget here');
      case 'Report Bug':
        return BugReportWidget();
      case 'Dashboard':
        return SingleChildScrollView(
          child: DashboardWidget(
            title: 'Inventory Items',
            items: items, // Replace with your actual inventory data
            dataTable: CustomDataTableWidget(
              data: paginatedItems,
              currentPage: currentPage,
              itemsPerPage: itemsPerPage,
              onPageChanged: (int page) {
                // Implement your logic for page change here
                // You can update the 'currentPage' and manage data accordingly
                // For example:
                setState(() {
                  currentPage = page;
                });
              },
              fromDate: fromDate, // Pass the fromDate parameter
              toDate: toDate, // Pass the toDate parameter
              onFromDateSelected:
                  _selectFromDate, // Pass the function without arguments
              onToDateSelected:
                  _selectToDate, // Pass the function without arguments
              searchText: _searchText, // Pass the searchText parameter
              onSearchTextChanged: (String text) {
                // Implement your logic for handling search text changes
                // For example, updating _searchText
                setState(() {
                  _searchText = text;
                });
              },
              totalItems: paginatedItems.length, // Provide the total number of items
            ),

            statistic1Value: 200, // Replace with your specific values
            statistic2Value: 200.0, // Replace with your specific values
            statistic3Value: 300.0, // Replace with your specific values
            statistic4Value: 400.0, // Replace with your specific values
            statistic1Title:
                'Total Products', // Replace with your specific title
            statistic2Title:
                'Total Store Value', // Replace with your specific title
            statistic3Title: 'Out Of Stock', // Replace with your specific title
            statistic4Title:
                'All Categories', // Replace with your specific title
          ),
        );

      default:
        return SizedBox.shrink();
    }
  }

  void _printIncomeStatement() {
    print(items);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inventory Report'),
      ),
      body: Row(
        children: [
          InventorySidePanel(
            onItemSelected: (itemName) {
              setState(() {
                selectedItem = itemName;
              });
            },
          ),
          Expanded(
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Text(
                    ' Report',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  // SizedBox(height: 10),

                  // SizedBox(height: 10),
                  // Text('Selected Item: $selectedItem'),
                  // SizedBox(height: 10),
                  renderSelectedWidget(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
