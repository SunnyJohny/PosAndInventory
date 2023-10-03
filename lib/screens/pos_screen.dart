import 'package:flutter/material.dart';
import 'package:my_desktop_app/components/product.dart';
import 'package:my_desktop_app/components/cart_panel.dart';
import 'package:my_desktop_app/components/side_panel.dart';
import 'package:my_desktop_app/components/user.dart';

import 'package:my_desktop_app/components/side_panel_items.dart';
import 'package:my_desktop_app/components/dashboard_widget.dart';
import 'package:my_desktop_app/data_lists.dart';
import 'package:provider/provider.dart';
import 'package:my_desktop_app/components/providers/product_cart_provider.dart';
import 'package:my_desktop_app/screens/report/inventory_screen.dart';

import 'package:my_desktop_app/components/inventory_side_panel.dart';

import 'package:my_desktop_app/components/dashboard_widget.dart';

import 'package:my_desktop_app/screens/report/dashboard.dart';

class ProductTile extends StatefulWidget {
  final Product product;
  final VoidCallback onTap;

  const ProductTile({
    required this.product,
    required this.onTap,
  });

  @override
  _ProductTileState createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  bool isHovered = false;
  void _printIncomeStatement() {
    print(expenseData);
  }

  @override
  Widget build(BuildContext context) {
   
    ProductCartProvider productCartProvider =
        Provider.of<ProductCartProvider>(context, listen: false);

    return MouseRegion(
      onEnter: (_) {
        setState(() {
          isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          isHovered = false;
        });
      },
      child: GestureDetector(
        onTap: () {
          productCartProvider.addToCart(widget.product);
        },
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
            color: widget.product.color, // Set the background color
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.product.name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('\₦${widget.product.price.toStringAsFixed(2)}'),
              if (isHovered)
                Tooltip(
                  message: 'Add to Cart',
                  child: Icon(Icons.add_shopping_cart),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class PosScreen extends StatelessWidget {
//   final screenContent = ScreenContent('Sales Report', {
//   'Sales Report': () => Text('Render Sales Report Widget here'),
//   'Add Product': () => AddProductScreen(),
//   'Analysis': () => AnalysisDashboard(),
//   'Expenses': () => SingleChildScrollView(
//     child: DashboardWidget(
//   title: 'Expense aaaaaaAccount',
//   items: expenseData,
//   printReportCallback: _printIncomeStatement,
//   statistic1Value: 1000.0, // Replace with your static value
//   statistic2Value: 200.0,  // Replace with your static value
//   statistic3Value: 300.0,  // Replace with your static value
//   statistic4Value: 400.0,  // Replace with your static value
//   statistic1Title: 'Total Revenue', // Replace with your static title
//   statistic2Title: 'Cost of Goods Sold', // Replace with your static title
//   statistic3Title: 'Operating Expenses', // Replace with your static title
//   statistic4Title: 'Total Profit', // Replace with your static title
// )

//   ),
//   'Custom Report': () => CustomSalesReport(),
// });

// To render the selected widget, call renderSelectedWidget()
// Widget selectedWidget = screenContent.renderSelectedWidget();

  void _printIncomeStatement() {
    print(expenseData);
  }

  @override
  Widget build(BuildContext context) {
    var sidePanelItems = [
      SidePanelItem(
        icon: Icons.shopping_cart,
        title: 'Products Page',
        onTap: () {
          // Navigate to the POS page
          Navigator.pushNamed(context, '/pos');
        },
      ),
      SidePanelItem(
        icon: Icons.inventory,
        title: 'Inventory',
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => InventoryScreen()),
          );
        },
      ),
      SidePanelItem(
        icon: Icons.bar_chart,
        title: 'Sales Reports',
        onTap: () {
          // Handle reports click
        },
      ),
      SidePanelItem(
        icon: Icons.receipt, // Use the receipt icon for Invoice/Receipt
        title: 'Invoice/Receipt',
        onTap: () {
          // Handle Invoice/Receipt

          Navigator.pushReplacementNamed(context, '/report');
        },
      ),
      SidePanelItem(
        icon: Icons.person,
        title: 'User Profile',
        onTap: () {
          // Handle user profile click
        },
      ),
      SidePanelItem(
        icon: Icons.settings,
        title: 'Settings',
        onTap: () {
          // Handle settings click
        },
      ),
      SidePanelItem(
        icon: Icons.logout,
        title: 'Logout',
        onTap: () {
          // Handle logout click
          // After logout, navigate back to the login page
          Navigator.pushReplacementNamed(context, '/login');
        },
      ),
    ];

    User user = User(
      userName: "John Sunday",
      userPosition: "Software Developer",
      userId: "12345",
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('POS Screen'),
      ),
      body: Row(
        children: [
          // Left side (User and SidePanel)
          Container(
            margin: EdgeInsets.only(left: 0),
            child: Expanded(
              flex: 1,
              child: Column(
                children: [
                  user,
                  // Add a thick horizontal line to separate sections
                  Container(
                    height: 2, // Adjust the thickness of the line
                    color: Colors.white, // Customize the color of the line
                  ),

                  SidePanel(items: sidePanelItems),
                ],
              ),
            ),
          ),
          // Right side (Product List and Cart)
          Expanded(
            flex: 3,
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Text(
                    'Product List',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      onChanged: (value) {
                        Provider.of<ProductCartProvider>(context, listen: false)
                            .searchProduct(value);
                      },
                      decoration: InputDecoration(
                        hintText: 'Search Product',
                        suffixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: Consumer<ProductCartProvider>(
                      builder: (context, provider, _) {
                        return Container(
                          // Wrap the product list in a Container
                          padding: EdgeInsets.all(16), // Add padding here
                          child: GridView.count(
                            crossAxisCount: 8,
                            children: provider.products.map((product) {
                              return ProductTile(
                                product: product,
                                onTap: () {
                                  provider.addToCart(product);
                                },
                              );
                            }).toList(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          CartPanel(
            cartItems: Provider.of<ProductCartProvider>(context).cartItems,
            updateTotal:
                Provider.of<ProductCartProvider>(context).updateCartTotal,
            clearCart: () {
              // Implement the logic to clear the cart
              Provider.of<ProductCartProvider>(context, listen: false)
                  .clearCart();
            },
          ),
        ],
      ),
    );
  }
}
