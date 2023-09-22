// import 'package:flutter/material.dart';



//           Divider(),
//           ListTile(
//             leading: Icon(Icons.inventory),
//             title: Text('Inventory'),
//             onTap: () {
//               // Handle inventory click
//               // Navigator.push(
//               //   context,
//               //   MaterialPageRoute(builder: (context) => InventoryScreen()),
//               // );
//             },
//           ),
//           ListTile(
//             leading: Icon(Icons.shopping_cart),
//             title: Text('Products Page'),
//             onTap: () {
//               // Navigator.push(
//               //   context,
//               //   MaterialPageRoute(builder: (context) => PosScreen()),
//               // );
//             },
//           ),
//           ListTile(
//             leading: Icon(Icons.bar_chart),
//             title: Text('Reports'),
//             onTap: () {
//               // Handle reports click
//                Navigator.pushReplacementNamed(context, '/report');
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
//               // After logout, navigate back to thpagee login 
//               Navigator.pushReplacementNamed(context, '/login');
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:my_desktop_app/components/side_panel_items.dart';



class SidePanel extends StatelessWidget {
  final List<SidePanelItem> items;

  SidePanel({
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      color: Colors.grey[200],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: items.map((item) {
          return ListTile(
            leading: Icon(item.icon),
            title: Text(item.title),
            onTap: item.onTap,
          );
        }).toList(),
      ),
    );
  }
}
