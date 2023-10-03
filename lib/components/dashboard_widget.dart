import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_desktop_app/components/custom_sales_report_modal.dart';
import 'package:my_desktop_app/components/profitandlossmodal.dart';
import 'package:my_desktop_app/components/custom_table.dart';

import 'package:pdf/pdf.dart';
import 'dart:io';

import 'package:pdf/widgets.dart' as pw;

// Define a class for your dashboard widget

// Define a class for your dashboard widget
class DashboardWidget extends StatefulWidget {
  final String title;
  final List<Map<String, dynamic>> items;
  final CustomDataTableWidget dataTable; // CustomDataTable as a parameter

  // General and intuitive variable names
  final double statistic1Value; // E.g., Total Revenue
  final double statistic2Value; // E.g., Cost of Goods Sold
  final double statistic3Value; // E.g., Operating Expenses
  final double statistic4Value; // E.g., Total Profit

  // Add these fields to the constructor
  final String statistic1Title; // E.g., 'Total Revenue'
  final String statistic2Title; // E.g., 'Cost of Goods Sold'
  final String statistic3Title; // E.g., 'Operating Expenses'
  final String statistic4Title; // E.g., 'Total Profit'

  DashboardWidget({
    required this.title,
    required this.items,
    required this.dataTable, // Include CustomDataTableWidget as a parameter

    // Updated parameter names
    required this.statistic1Value,
    required this.statistic2Value,
    required this.statistic3Value,
    required this.statistic4Value,

    // Added parameters for statistic titles
    required this.statistic1Title,
    required this.statistic2Title,
    required this.statistic3Title,
    required this.statistic4Title,
  });

  @override
  _DashboardWidgetState createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget> {
  int currentPage = 1;
  int itemsPerPage = 5;

  DateTime? fromDate;
  DateTime? toDate;
  bool isToDateSelected = false;

  Future<void> _selectFromDate(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      setState(() {
        fromDate = selectedDate;
      });
    }
  }

  Future<void> _selectToDate(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      setState(() {
        toDate = selectedDate;
        isToDateSelected = true; // Set the flag when "To Date" is selected
      });
    }
  }

//   Future<void> generateIncomeStatement(
//   double revenue,
//   double cogs,
//   double opex,
//   double profit,
// ) async {
//   final pdf = pw.Document();

//   // Add a page to the PDF
//   pdf.addPage(
//     pw.Page(
//       build: (context) {
//         return pw.Column(
//           crossAxisAlignment: pw.CrossAxisAlignment.start,
//           children: [
//             // Add the title at the top
//             pw.Center(child: pw.Text('Income Statement', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold))),
//             pw.SizedBox(height: 20),
//             // Add revenue, COGS, opex, and profit
//             pw.Row(
//               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//               children: [
//                 pw.Text('Revenue:'),
//                 pw.Text('N${revenue.toStringAsFixed(2)}'),
//               ],
//             ),
//             pw.Row(
//               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//               children: [
//                 pw.Text('Cost of Goods Sold (COGS):'),
//                 pw.Text('N${cogs.toStringAsFixed(2)}'),
//               ],
//             ),
//             pw.Row(
//               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//               children: [
//                 pw.Text('Operating Expenses (Opex):'),
//                 pw.Text('N${opex.toStringAsFixed(2)}'),
//               ],
//             ),
//             pw.Row(
//               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//               children: [
//                 pw.Text('Profit:'),
//                 pw.Text('N${profit.toStringAsFixed(2)}', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
//               ],
//             ),
//           ],
//         );
//       },
//     ),
//   );

  // Save the PDF to a file
  // final pdfFile = File('income_statement.pdf');
  // await pdfFile.writeAsBytes(await pdf.save());

  // You can now share, print, or display the PDF as needed
  // For example, you can use a package like 'printing' to print the PDF
  // or use a package like 'open_file' to open and view the PDF
// }

// void _printIncomeStatement({
//   required double revenue,
//   required double cogs,
//   required double opex,
//   required double profit,
//   required BuildContext context,
// }) async {
  // Print the income statement PDF
  // await generateIncomeStatement(revenue, cogs, opex, profit);

  // Display a success message to the user
  // Fluttertoast.showToast(
  //   msg: 'Income statement printed successfully!',
  //   toastLength: Toast.LENGTH_SHORT,
  //   gravity: ToastGravity.CENTER,
  //   timeInSecForIosWeb: 1,
  //   backgroundColor: Colors.grey[800],
  //   textColor: Colors.white,
  //   fontSize: 16.0,
  // );
// }

  void sortItemsByDate() {
    widget.items.sort((a, b) {
      // Convert the date strings to DateTime objects
      DateTime dateA = DateTime.parse(a['date']);
      DateTime dateB = DateTime.parse(b['date']);

      // Sort in descending order (latest date first)
      return dateB.compareTo(dateA);
    });
  }

  // List<Map<String, dynamic>> get paginatedItems {
  //   sortItemsByDate(); // Sort the items before pagination
  //   final startIndex = (currentPage - 1) * itemsPerPage;
  //   return widget.items.skip(startIndex).take(itemsPerPage).toList();
  // }

/*  The  First Paginated Item*/

  List<Map<String, dynamic>> get paginatedItems {
    sortItemsByDate(); // Sort the items before pagination
    List<Map<String, dynamic>> filtered = [];

    if (fromDate != null && toDate != null) {
      // If both fromDate and toDate are selected, filter by date range
      filtered = widget.items.where((item) {
        final itemDate = DateTime.parse(item['date']);
        return itemDate.isAfter(fromDate!) &&
            itemDate.isBefore(toDate!.add(Duration(days: 1)));
      }).toList();
    } else {
      // If no date range is selected, show all items
      filtered = widget.items;
    }

    final startIndex = (currentPage - 1) * itemsPerPage;
    return filtered.skip(startIndex).take(itemsPerPage).toList();
  }

  int get totalItems => widget.items.length;
  int get totalPages => (totalItems / itemsPerPage).ceil();

  List<Map<String, dynamic>> get filteredItems {
    if (_searchText.isEmpty && fromDate == null && !isToDateSelected) {
      // If nothing is filtered and the "To Date" picker is not selected,
      // limit the displayed items to a maximum of 3
      return paginatedItems;
    } else if (_searchText.isEmpty && fromDate == null && toDate == null) {
      // If no search, no "From Date," and "To Date" is selected, show all items
      return paginatedItems;
    } else {
      // If there are filters or "To Date" is selected, show all items
      return paginatedItems;
    }
  }

  // //-------------------------filtered&PagenatedItems---------------

  // // Add a field to store the filtered and paginated data
  // List<Map<String, dynamic>> filteredAndPaginatedData = [];

  // // Update the paginatedItems getter method to handle filtering and pagination
  // List<Map<String, dynamic>> get paginatedItems {
  //   sortItemsByDate(); // Sort the items before pagination
  //   List<Map<String, dynamic>> filtered = [];

  //   if (fromDate != null && toDate != null) {
  //     // If both fromDate and toDate are selected, filter by date range
  //     filtered = widget.items.where((item) {
  //       final itemDate = DateTime.parse(item['date']);
  //       return itemDate.isAfter(fromDate!) &&
  //           itemDate.isBefore(toDate!.add(Duration(days: 1)));
  //     }).toList();
  //   } else {
  //     // If no date range is selected, show all items
  //     filtered = widget.items;
  //   }

  //   // Apply additional filtering based on the search text
  //   if (_searchText.isNotEmpty) {
  //     filtered = filtered.where((item) {
  //       // Customize this part based on your search logic
  //       // For example, check if the item name contains the search text
  //       return item['description']
  //           .toLowerCase()
  //           .contains(_searchText.toLowerCase());
  //     }).toList();
  //   }

  //   // Apply pagination
  //   final startIndex = (currentPage - 1) * itemsPerPage;
  //   filteredAndPaginatedData =
  //       filtered.skip(startIndex).take(itemsPerPage).toList();

  //   return filteredAndPaginatedData;
  // }

  // //------------------------End of Filtered&PaginatedItems---------

  double getTodaySales() {
    var now = DateTime.now();
    var formattedDate = DateFormat('yyyy-MM-dd').format(now);

    double totalSales = 0;
    for (var item in widget.items) {
      if (item['date'] == formattedDate) {
        totalSales += item['amount'];
      }
    }
    return totalSales;
  }

  double getTotalSales() {
    if (_searchText.isEmpty && fromDate == null && toDate == null) {
      // If nothing is filtered, return the total sales from the original items list
      double totalSales = 0;
      for (var item in widget.items) {
        totalSales += item['amount'];
      }
      return totalSales;
    } else {
      // If there are filters, calculate the total sales from the filtered items list
      double totalSales = 0;
      for (var item in filteredItems) {
        totalSales += item['amount'];
      }
      return totalSales;
    }
  }

  double getTotalCOGS() {
    if (_searchText.isEmpty && fromDate == null && toDate == null) {
      // If nothing is filtered, return the total COGS from the original items list
      double totalCOGS = 0;
      for (var item in widget.items) {
        totalCOGS += item['cost'] * item['quantity'];
      }
      return totalCOGS;
    } else {
      // If there are filters, calculate the total COGS from the filtered items list
      double totalCOGS = 0;
      for (var item in filteredItems) {
        totalCOGS += item['cost'] * item['quantity'];
      }
      return totalCOGS;
    }
  }

  void _printSalesReport({
    required bool shouldPrintReport,
    required List<Map<String, dynamic>> filteredItems,
    required double totalSales,
    required DateTime? fromDate,
    required DateTime? toDate,
    required BuildContext context,
  }) async {
    if (fromDate == null || toDate == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Select Date Range"),
            content: Text(
                "Please select a valid date range to generate the report."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
      return;
    }

    if (shouldPrintReport) {
      Fluttertoast.showToast(
        msg: 'Sales report is being printed...',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey[800],
        textColor: Colors.white,
        fontSize: 16.0,
      );

      await Future.delayed(Duration(seconds: 2));

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CustomSalesReportModal(
            attendantName: 'John Doe',
            cartItems: filteredItems,
            total: totalSales,
            startDate: fromDate,
            endDate: toDate,
          ),
        ),
      );

      Fluttertoast.showToast(
        msg: 'Sales report printed successfully!',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey[800],
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } else {
      Fluttertoast.showToast(
        msg: 'Sales report printing canceled!',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey[800],
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  int getProductsSoldToday() {
    var now = DateTime.now();
    var formattedDate = DateFormat('yyyy-MM-dd').format(now);

    int productsSold = 0;
    for (var item in widget.items) {
      if (item['date'] == formattedDate) {
        productsSold += item['quantity'] as int;
      }
    }
    return productsSold;
  }

  String _searchText = '';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16),
            child: Text(
              widget.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              _buildStatCard(
                widget.statistic1Title, // Use the passed title
                '₦${widget.statistic1Value.toStringAsFixed(2)}',
                Icons.trending_up,
                Colors.blue,
              ),
              SizedBox(width: 16),
              _buildStatCard(
                widget.statistic2Title, // Use the passed title
                '₦${widget.statistic2Value.toStringAsFixed(2)}',

                Icons.receipt,
                Colors.orange,
              ),
              SizedBox(width: 16),
              _buildStatCard(
                widget.statistic3Title, // Use the passed title
                '₦${widget.statistic3Value.toStringAsFixed(2)}',
                Icons.money_off, // Updated icon
                Colors.green,
              ),
              _buildStatCard(
                widget.statistic4Title, // Use the passed title
                '₦${widget.statistic4Value.toStringAsFixed(2)}',
                Icons.assignment, // Updated icon
                Color.fromARGB(255, 133, 50, 249),
              ),
            ],
          ),
          SizedBox(height: 16),
          Divider(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sales By Time Period :  ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Text('FROM: '),
                  GestureDetector(
                    onTap: () => _selectFromDate(context),
                    child: Row(
                      children: [
                        Icon(Icons.calendar_today),
                        SizedBox(width: 8),
                        Text(
                          fromDate != null
                              ? DateFormat('dd-MM-yyyy').format(fromDate!)
                              : 'Select Date',
                          style:
                              TextStyle(decoration: TextDecoration.underline),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 16),
                  Text('TO: '),
                  GestureDetector(
                    onTap: () => _selectToDate(context),
                    child: Row(
                      children: [
                        Icon(Icons.calendar_today),
                        SizedBox(width: 8),
                        Text(
                          toDate != null
                              ? DateFormat('dd-MM-yyyy').format(toDate!)
                              : 'Select Date',
                          style:
                              TextStyle(decoration: TextDecoration.underline),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Expanded(
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    margin: EdgeInsets.only(top: 1, right: 2),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          _searchText = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Search Sales By Product',
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Text(
          //   "Today's (${DateFormat('dd-MM-yyyy').format(DateTime.now())}) Transactions",
          //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          // ),
          // SizedBox(height: 16),
          // Wrap the DataTable, buttons, and related text inside a Container
          Container(
            width: double.infinity,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: widget.dataTable, // Use the custom data table widget
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.only(left: 8),
                  child: ElevatedButton(
                    onPressed: currentPage > 1
                        ? () {
                            setState(() {
                              currentPage--;
                            });
                          }
                        : null,
                    child: Text('Previous'),
                  ),
                ),
              ),
              Text('Page $currentPage of $totalPages'),
              ElevatedButton(
                onPressed: () {
                  // Your logic for the "Print Income Statement" button
                },
                child: const Text('Print Income Statement'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Your logic for the "Print Sales Report" button
                },
                child: Text('Print Sales Report'),
              ),
              Flexible(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.only(right: 8),
                  child: ElevatedButton(
                    onPressed: currentPage < totalPages
                        ? () {
                            setState(() {
                              currentPage++;
                            });
                          }
                        : null,
                    child: Text('Next'),
                  ),
                ),
              ),
            ],
          ),
const SizedBox(height: 16),
        ],
        
      ),
      
    );
  }

  Widget _buildStatCard(
      String title, dynamic value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$value',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Icon(
                  icon,
                  color: Colors.white,
                  size: 24,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
