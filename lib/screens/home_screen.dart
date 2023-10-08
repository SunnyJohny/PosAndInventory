import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_desktop_app/components/side_panel_items.dart';
import 'package:my_desktop_app/components/side_panel.dart';

class HomePage extends StatelessWidget {
// Now, you can use the `sidePanel` widget in your UI.

  @override
  Widget build(BuildContext context) {
    var sidePanelItems = [
      SidePanelItem(
        icon: Icons.inventory,
        title: 'Inventory',
        onTap: () {
          // Handle inventory click
        },
      ),
      SidePanelItem(
        icon: Icons.shopping_cart,
        title: 'Products Page',
        onTap: () {
          // Navigate to the POS page
          Navigator.pushNamed(context, '/pos');
        },
      ),
      SidePanelItem(
        icon: Icons.bar_chart,
        title: 'Reports',
        onTap: () {
          // Handle reports click
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

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: CircleAvatar(
              backgroundImage:
                  NetworkImage('https://example.com/path/to/image.jpg'),
            ),
          ),
        ],
      ),
      body: Row(
        children: [
          SidePanel(items: sidePanelItems), // Panel on the left side
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome, John Doe',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Employee ID: 123456',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Position: Manager',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  Text(
                    DateFormat('MMMM dd, yyyy').format(DateTime.now()),
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  Text(
                    DateFormat('hh:mm a').format(DateTime.now()),
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class SidePanel extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 200,
//       color: Colors.grey[200],
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           ListTile(
//             leading: Icon(Icons.inventory),
//             title: Text('Inventory'),
//             onTap: () {
//               // Handle inventory click
//             },
//           ),
//           ListTile(
//             leading: Icon(Icons.shopping_cart),
//             title: Text('Products Page'),
//             onTap: () {
//               // Navigate to the POS page
//               Navigator.pushNamed(context, '/pos');
//             },
//           ),
//           ListTile(
//             leading: Icon(Icons.bar_chart),
//             title: Text('Reports'),
//             onTap: () {
//               // Handle reports click
//             },
//           ),
//           ListTile(
//             leading: Icon(Icons.person),
//             title: Text('User Profile'),
//             onTap: () {
//               // Handle user profile click
//             },
//           ),
//           ListTile(
//             leading: Icon(Icons.settings),
//             title: Text('Settings'),
//             onTap: () {
//               // Handle settings click
//             },
//           ),
//           ListTile(
//             leading: Icon(Icons.logout),
//             title: Text('Logout'),
//             onTap: () {
//               // Handle logout click
//               // After logout, navigate back to the login page
//               Navigator.pushReplacementNamed(context, '/login');
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
