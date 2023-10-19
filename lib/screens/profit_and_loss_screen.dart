import 'package:flutter/material.dart';
import 'package:my_desktop_app/components/product.dart';
import 'package:my_desktop_app/components/cart_panel.dart';
import 'package:my_desktop_app/components/profit_and_loss_side_panel.dart';
import 'package:my_desktop_app/components/custom_sales_report.dart';

import 'package:my_desktop_app/screens/report/profit_And_loss_dashboard.dart';
import 'package:my_desktop_app/screens/report/expense_dashboard.dart';

import 'package:my_desktop_app/screens/report/analytsis_dashboard.dart';

import 'package:my_desktop_app/screens/report/bug_report.dart';
import 'package:my_desktop_app/components/custom_table.dart';

import 'package:my_desktop_app/screens/report/add_product_screen.dart';

import 'package:provider/provider.dart';
import 'package:my_desktop_app/components/providers/product_cart_provider.dart';
import 'package:my_desktop_app/components/dashboard_widget.dart';


class ProfitAndLossReportScreen extends StatefulWidget {
  @override
  _ProfitAndLossReportScreenState createState() =>
      _ProfitAndLossReportScreenState();
}

class _ProfitAndLossReportScreenState extends State<ProfitAndLossReportScreen> {
  late DashboardWidget dashboardWidget; // Declare
  List<Map<String, dynamic>> filteredAndPaginatedData = [];
  List<Map<String, dynamic>> inventoryData = [];

  int currentPage = 1;
  int itemsPerPage = 5;

  DateTime? fromDate;
  DateTime? toDate;
  bool isToDateSelected = false;
  String _searchText = '';
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
      isToDateSelected = true; // Set the flag when "To Date" is selected
    });
  }
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
        return item['description']
            .toLowerCase()
            .contains(_searchText.toLowerCase());
      }).toList();
    }

    // Apply pagination
    final startIndex = (currentPage - 1) * itemsPerPage;
    filteredAndPaginatedData =
        filtered.skip(startIndex).take(itemsPerPage).toList();

    return filteredAndPaginatedData;
  }


  @override
  void initState() {
    super.initState();

    // Initialize dashboardWidget here
    DashboardWidget(
      title: 'Inventory Items',
      items: inventoryData, // Replace with your actual inventory data
      dataTable: CustomDataTableWidget(
  data: filteredAndPaginatedData,
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
 onFromDateSelected: _selectFromDate, // Pass the function without arguments
  onToDateSelected: _selectToDate, // Pass the function without arguments
  searchText: _searchText, // Pass the searchText parameter
  onSearchTextChanged: (String text) {
    // Implement your logic for handling search text changes
    // For example, updating _searchText
    setState(() {
      _searchText = text;
    });
  },
  totalItems: filteredAndPaginatedData.length, // Provide the total number of items
),

      statistic1Value: 200, // Replace with your specific values
      statistic2Value: 200.0, // Replace with your specific values
      statistic3Value: 300.0, // Replace with your specific values
      statistic4Value: 400.0, // Replace with your specific values
      statistic1Title: 'Total Products', // Replace with your specific title
      statistic2Title: 'Total Store Value', // Replace with your specific title
      statistic3Title: 'Out Of Stock', // Replace with your specific title
      statistic4Title: 'All Categories', // Replace with your specific title
    );
  }

  // void _printIncomeStatement() {
  //   print(expenseData);
  // }

  String selectedItem = 'Dashboard'; // Hardcoded selected item

  Widget renderSelectedWidget() {
    switch (selectedItem) {
      case 'Sales Report':
        return Text('Render Sales Report Widget here');
      case 'Add Product':
        return AddProductScreen();
      case 'Analysis':
        return AnalysisDashboard();
      case 'Expenses':
        return SingleChildScrollView(
          // Wrap SalesDashboard with SingleChildScrollView
          child: dashboardWidget = DashboardWidget(
  title: 'Inventory Items',
  items: inventoryData, // Replace with your actual inventory data
  dataTable: CustomDataTableWidget(
  data: filteredAndPaginatedData,
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
 onFromDateSelected: _selectFromDate, // Pass the function without arguments
  onToDateSelected: _selectToDate, // Pass the function without arguments
  searchText: _searchText, // Pass the searchText parameter
  onSearchTextChanged: (String text) {
    // Implement your logic for handling search text changes
    // For example, updating _searchText
    setState(() {
      _searchText = text;
    });
  },
  totalItems: filteredAndPaginatedData.length, // Provide the total number of items
),
  statistic1Value: 200, // Replace with your specific values
  statistic2Value: 200.0, // Replace with your specific values
  statistic3Value: 300.0, // Replace with your specific values
  statistic4Value: 400.0, // Replace with your specific values
  statistic1Title: 'Total Products', // Replace with your specific title
  statistic2Title: 'Total Store Value', // Replace with your specific title
  statistic3Title: 'Out Of Stock', // Replace with your specific title
  statistic4Title: 'All Categories', // Replace with your specific title
),
        );

      case 'Custom Report':
        return CustomSalesReport();
      // return AddProductScreen();

      // case 'Dashboard':
      //   return SingleChildScrollView(
      //     // Wrap SalesDashboard with SingleChildScrollView
      //     child: dashboardWidget,// In Ihe Maintime
      //   );
      default:
        return SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profit&Loss Report'),
      ),
      body: Row(
        children: [
          ProfitAndLossReportSidePanel(
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
                    'Profit&Loss Report',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
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
