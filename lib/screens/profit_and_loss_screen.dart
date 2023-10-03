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
import 'package:my_desktop_app/data_lists.dart';

class ProfitAndLossReportScreen extends StatefulWidget {
  @override
  _ProfitAndLossReportScreenState createState() =>
      _ProfitAndLossReportScreenState();
}

class _ProfitAndLossReportScreenState extends State<ProfitAndLossReportScreen> {
  late DashboardWidget dashboardWidget; // Declare
  List<Map<String, dynamic>> filteredAndPaginatedData = [];
  int currentPage = 1;
  int itemsPerPage = 5;

  @override
  void initState() {
    super.initState();

    // Initialize dashboardWidget here
    DashboardWidget(
      title: 'Inventory Items',
      items: inventoryData, // Replace with your actual inventory data
      dataTable: CustomDataTableWidget(
        data: inventoryData, // Replace 'yourDataList' with your actual data
        currentPage: currentPage, // Provide the current page
        itemsPerPage: itemsPerPage, // Provide items per page
        onPageChanged: (int page) {
          // Implement your logic for page change here
          // You can update the 'currentPage' and manage data accordingly
          // For example:
          setState(() {
            currentPage = page;
          });
        },
        totalItems: inventoryData.length, // Provide the total number of items

        // Provide the onUpdateFilter function to handle filtering
        onUpdateFilter:
            (String searchText, DateTime? fromDate, DateTime? toDate) {
          // Implement your filter logic here using the provided parameters.
          // You can filter your data based on the searchText, fromDate, and toDate.
          // Once you have the filtered data, you can update your UI accordingly.
          // For example:

          // 1. Filter your data based on searchText, fromDate, and toDate
          List<Map<String, dynamic>> filteredData = inventoryData.where((item) {
            // Implement your filtering logic here.
            // For example, check if item['name'] contains searchText
            bool textMatch = item['name'].toString().contains(searchText);

            // Check if the date is within the selected date range
            bool dateMatch = true;
            if (fromDate != null && toDate != null) {
              DateTime itemDate = DateTime.parse(item[
                  'date']); // Assuming 'date' is a string in ISO 8601 format
              dateMatch =
                  itemDate.isAfter(fromDate) && itemDate.isBefore(toDate);
            }

            // Return true if both text and date match, indicating that this item should be included in the filtered data
            return textMatch && dateMatch;
          }).toList();

          // 2. Update your UI with the filtered data
          setState(() {
            // Update your data source with the filteredData
            inventoryData = filteredData;
          });
        },
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

  void _printIncomeStatement() {
    print(expenseData);
  }

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
  data: inventoryData, // Replace 'yourDataList' with your actual data
  currentPage: currentPage, // Provide the current page
  itemsPerPage: itemsPerPage, // Provide items per page
  onPageChanged: (int page) {
    // Implement your logic for page change here
    // You can update the 'currentPage' and manage data accordingly
    // For example:
    setState(() {
      currentPage = page;
    });
  },
  totalItems: inventoryData.length, // Provide the total number of items

  // Provide the onUpdateFilter function to handle filtering
  onUpdateFilter: (String searchText, DateTime? fromDate, DateTime? toDate) {
    // Implement your filter logic here using the provided parameters.
    // You can filter your data based on the searchText, fromDate, and toDate.
    // Once you have the filtered data, you can update your UI accordingly.
    // For example:

    // 1. Filter your data based on searchText, fromDate, and toDate
    List<Map<String, dynamic>> filteredData = inventoryData.where((item) {
      // Implement your filtering logic here.
      // For example, check if item['name'] contains searchText
      bool textMatch = item['name'].toString().contains(searchText);

      // Check if the date is within the selected date range
      bool dateMatch = true;
      if (fromDate != null && toDate != null) {
        DateTime itemDate = DateTime.parse(item['date']); // Assuming 'date' is a string in ISO 8601 format
        dateMatch = itemDate.isAfter(fromDate) && itemDate.isBefore(toDate);
      }

      // Return true if both text and date match, indicating that this item should be included in the filtered data
      return textMatch && dateMatch;
    }).toList();

    // 2. Update your UI with the filtered data
    setState(() {
      // Update your data source with the filteredData
      inventoryData = filteredData;
    });
  },
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
