import 'package:flutter/material.dart';
import 'package:my_desktop_app/components/providers/product_cart_provider.dart';

import 'package:provider/provider.dart';
import 'package:my_desktop_app/screens/home_screen.dart' as HomeScreen;
import 'package:my_desktop_app/screens/pos_screen.dart';
import 'package:my_desktop_app/screens/login_screen.dart';
import 'package:my_desktop_app/screens/report_screen.dart';
import 'package:my_desktop_app/screens/profit_and_loss_screen.dart';
import 'package:my_desktop_app/screens/report/expense_dashboard.dart';

import 'package:my_desktop_app/data_lists.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ProductCartProvider>(
          create: (_) => ProductCartProvider(),
        ),
        // Add more provider instances here as needed
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   
    return MaterialApp(
      title: 'My Desktop App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/pos': (context) => PosScreen(),
        '/login': (context) => LoginPage(),
        '/report': (context) => ReportScreen(),
        '/profitandloss': (context) => ProfitAndLossReportScreen(),
        '/expenses': (context) => ExpenseDashboard(),

      },
    );
  }
}
