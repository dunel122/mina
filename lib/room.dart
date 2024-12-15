import 'package:flutter/material.dart';
import 'roomdet.dart'; // Import the RoomDetailsPage

class RoomPage extends StatelessWidget {
  const RoomPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rooms of Tenants'),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView.builder(
        itemCount: 6, // Number of rooms
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, index) {
          // Example tenant names for each room
          List<Map<String, String>> tenants = [
            {'name': 'John Doe', 'phone': '123-456-7890'},
            {'name': 'Jane Smith', 'phone': '987-654-3210'},
            {'name': 'Mary Johnson', 'phone': '555-123-4567'},
            {'name': 'Chris Lee', 'phone': '444-765-4321'},
          ];

          return GestureDetector(
            onTap: () {
              // Navigate to RoomDetailsPage when a room is tapped
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RoomDetailsPage(
                    roomNumber: index + 1, // Room number (1 to 6)
                    tenants: tenants, // Pass the tenants of the room
                  ),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 20), // Spacing between containers
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Room ${index + 1}',
                    style: const TextStyle(
                      fontSize: 22, // Increased font size for room number
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // List of tenants with increased font size
                  for (var tenant in tenants)
                    Text(
                      tenant['name'] ?? '', // Display tenant name
                      style: TextStyle(
                        fontSize: 18, // Increased font size for tenant names
                        color: Colors.grey.shade600,
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
