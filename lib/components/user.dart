import 'package:flutter/material.dart';

class User extends StatelessWidget {
  // User information
  String userName;
  String userPosition;
  String userId;

  User({
    required this.userName,
    required this.userPosition,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      color: Colors.grey[200],
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                // Replaced the image with a person icon
                CircleAvatar(
                  radius: 40,
                  child: Icon(Icons.person, size: 80), // Person icon
                ),
                SizedBox(height: 16),
                Text(
                  userName,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  userPosition,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                SizedBox(height: 8),
                Text(
                  "User ID: $userId",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
