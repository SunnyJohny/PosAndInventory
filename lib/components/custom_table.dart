import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDataTableWidget extends StatefulWidget {
  final List<Map<String, dynamic>> data;
  final int currentPage;
  final int itemsPerPage;
  final ValueChanged<int> onPageChanged;
  final DateTime? fromDate;
  final DateTime? toDate;
  final ValueChanged<DateTime?> onFromDateSelected;
  final ValueChanged<DateTime?> onToDateSelected;
  final String searchText;
  final ValueChanged<String> onSearchTextChanged;
   final int totalItems; // Define the totalItems parameter

  CustomDataTableWidget({
    required this.data,
    required this.currentPage,
    required this.itemsPerPage,
    required this.onPageChanged,
    required this.fromDate,
    required this.toDate,
    required this.onFromDateSelected,
    required this.onToDateSelected,
    required this.searchText,
    required this.onSearchTextChanged,
    required this.totalItems, // Define the totalItems parameter
  });

List<Map<String, dynamic>> getPaginatedData() {
  final startIndex = (currentPage - 1) * itemsPerPage;
  int endIndex = startIndex + itemsPerPage;
  
  if (endIndex > data.length) {
    endIndex = data.length;
  }
  
  return data.sublist(startIndex, endIndex);
}

  @override
  _CustomDataTableWidgetState createState() => _CustomDataTableWidgetState();
}

class _CustomDataTableWidgetState extends State<CustomDataTableWidget> {
  String _searchText = '';
  DateTime? fromDate;
  DateTime? toDate;

  @override
  Widget build(BuildContext context) {
    if (widget.data.isEmpty) {
      // If data is empty, display "No Data" message.
      return Center(
        child: Text(
          'No Data',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      );
    }

    List<DataColumn> dataColumns = [];
    List<List<DataCell>> cellBuilders = [];

    // Generate columns and cell builders dynamically based on the keys of the first item in data
    widget.data[0].keys.forEach((key) {
      dataColumns.add(DataColumn(
        label: Text(
          key[0].toUpperCase() +
              key.substring(1), // Capitalize the first letter
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ));
    });

    widget.getPaginatedData().forEach((item) {
      List<DataCell> cells = [];
      item.keys.forEach((key) {
        cells.add(DataCell(
          Text(item[key].toString()),
          // Apply dark green background to cells
          // Note: You can customize the background color as needed
          onTap: () {}, // Add onTap to keep the cell interactive
        ));
      });
      cellBuilders.add(cells);
    });

    return DataTable(
      columns: dataColumns,
      rows: cellBuilders.map((cells) => DataRow(cells: cells)).toList(),
    );
  }

  void _selectFromDate(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      setState(() {
        fromDate = selectedDate;
        widget.onFromDateSelected(selectedDate); // Notify the parent widget
      });
    }
  }

  void _selectToDate(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      setState(() {
        toDate = selectedDate;
        widget.onToDateSelected(selectedDate); // Notify the parent widget
      });
    }
  }
}
