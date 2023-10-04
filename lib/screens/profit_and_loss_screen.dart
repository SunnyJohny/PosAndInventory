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
