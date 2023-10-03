import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class CustomDataTableWidget extends StatefulWidget {
  final List<Map<String, dynamic>> data;
  final int currentPage;
  final int itemsPerPage;
  final ValueChanged<int> onPageChanged;
  final int totalItems;
  final Function(String, DateTime?, DateTime?) onUpdateFilter; // Add this line

  CustomDataTableWidget({
    required this.data,
    required this.currentPage,
    required this.itemsPerPage,
    required this.onPageChanged,
    required this.totalItems,
    required this.onUpdateFilter, // Add this line
  });

  List<Map<String, dynamic>> getPaginatedData() {
    final startIndex = (currentPage - 1) * itemsPerPage;
    final endIndex = startIndex + itemsPerPage;
    return data.sublist(startIndex, endIndex.clamp(0, data.length));
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
          key[0].toUpperCase() + key.substring(1), // Capitalize the first letter
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

    return Column(
      children: [
        // Row(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     Text(
        //       'Sales By Time Period :  ',
        //       style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        //     ),
        //     SizedBox(height: 16),
        //     Row(
        //       children: [
        //         Text('FROM: '),
        //         GestureDetector(
        //           onTap: () => _selectFromDate(context),
        //           child: Row(
        //             children: [
        //               Icon(Icons.calendar_today),
        //               SizedBox(width: 8),
        //               Text(
        //                 fromDate != null
        //                     ? DateFormat('dd-MM-yyyy').format(fromDate!)
        //                     : 'Select Date',
        //                 style: TextStyle(decoration: TextDecoration.underline),
        //               ),
        //             ],
        //           ),
        //         ),
        //         SizedBox(width: 16),
        //         Text('TO: '),
        //         GestureDetector(
        //           onTap: () => _selectToDate(context),
        //           child: Row(
        //             children: [
        //               Icon(Icons.calendar_today),
        //               SizedBox(width: 8),
        //               Text(
        //                 toDate != null
        //                     ? DateFormat('dd-MM-yyyy').format(toDate!)
        //                     : 'Select Date',
        //                 style: TextStyle(decoration: TextDecoration.underline),
        //               ),
        //             ],
        //           ),
        //         ),
        //       ],
        //     ),
        //     SizedBox(height: 8),
        //     Expanded(
        //       child: Align(
        //         alignment: Alignment.topRight,
        //         child: Container(
        //           width: MediaQuery.of(context).size.width * 0.2,
        //           margin: EdgeInsets.only(top: 1, right: 2),
        //           child: TextField(
        //             onChanged: (value) {
        //               setState(() {
        //                 _searchText = value;
        //                 widget.onUpdateFilter(_searchText, fromDate, toDate);
        //               });
        //             },
        //             decoration: InputDecoration(
        //               hintText: 'Search Sales By Product',
        //               prefixIcon: Icon(Icons.search),
        //             ),
        //           ),
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
        DataTable(
          columns: dataColumns,
          rows: cellBuilders.map((cells) => DataRow(cells: cells)).toList(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                if (widget.currentPage > 1) {
                  widget.onPageChanged(widget.currentPage - 1);
                }
              },
            ),
            Text('Page ${widget.currentPage} of ${(widget.totalItems / widget.itemsPerPage).ceil()}'),
            IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: () {
                if (widget.currentPage < (widget.totalItems / widget.itemsPerPage).ceil()) {
                  widget.onPageChanged(widget.currentPage + 1);
                }
              },
            ),
          ],
        ),
      ],
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
        widget.onUpdateFilter(_searchText, fromDate, toDate);
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
        widget.onUpdateFilter(_searchText, fromDate, toDate);
      });
    }
  }
}
