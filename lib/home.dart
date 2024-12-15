import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart'; // Import the table_calendar package
import 'register.dart'; // Import the register page
import 'room.dart'; // Import the room page
import 'tenant.dart'; // Import the tenant page
import 'unpaid.dart'; // Import the unpaid page
import 'archive.dart'; // Import the archive page

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView( // Wrap everything in a SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.only(top: 60.0, left: 50.0, right: 50.0), // Adjusted top padding
          child: Column( // Change GridView to Column to include the calendar
            children: [
              // Grid of buttons
              GridView.count(
                crossAxisCount: 2, // Number of columns
                crossAxisSpacing: 20.0, // Horizontal space between items
                mainAxisSpacing: 30.0, // Vertical space between items
                childAspectRatio: 1.6, // Adjust the aspect ratio (width / height)
                shrinkWrap: true, // Prevent GridView from taking up all space
                children: [
                  // Button 1 - Register Tenant
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to the RegisterPage when the button is clicked
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const RegisterPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25), // Rounded corners
                      ),
                    ),
                    child: const Text(
                      'REGISTER TENANT',
                      textAlign: TextAlign.center, // Center-align the text
                      style: TextStyle(
                        color: Colors.white, // White text color
                        fontSize: 18, // Adjust font size if needed
                      ),
                    ),
                  ),
                  // Button 2 - Navigate to RoomPage
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to the RoomPage when the button is clicked
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const RoomPage()), // Navigate to RoomPage
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text(
                      'ROOM',
                      textAlign: TextAlign.center, // Center-align the text
                      style: TextStyle(
                        color: Colors.white, // White text color
                        fontSize: 18, // Adjust font size if needed
                      ),
                    ),
                  ),
                  // Button 3 - Navigate to TenantPage
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to the TenantPage when the button is clicked
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const TenantPage()), // Navigate to TenantPage
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text(
                      'TENANT',
                      textAlign: TextAlign.center, // Center-align the text
                      style: TextStyle(
                        color: Colors.white, // White text color
                        fontSize: 18, // Adjust font size if needed
                      ),
                    ),
                  ),
                  // Button 4 - Navigate to UnpaidPage
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to the UnpaidPage when the button is clicked
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const UnpaidPage()), // Navigate to UnpaidPage
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text(
                      'UNPAID TENANT',
                      textAlign: TextAlign.center, // Center-align the text
                      style: TextStyle(
                        color: Colors.white, // White text color
                        fontSize: 18, // Adjust font size if needed
                      ),
                    ),
                  ),
                ],
              ),
              // Space between buttons and calendar
              const SizedBox(height: 10),
              // Calendar view
              Padding(
                padding: const EdgeInsets.only(top: 20), // Adjust padding here to move the calendar
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade100, // Background color of the calendar
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TableCalendar(
                    focusedDay: DateTime.now(), // Set the current date as the focused day
                    firstDay: DateTime.utc(2020, 1, 1), // Set the first date available
                    lastDay: DateTime.utc(2030, 12, 31), // Set the last date available
                    headerStyle: const HeaderStyle(
                      titleCentered: true, // Center the header title
                    ),
                  ),
                ),
              ),
              // Archive TextButton at the bottom, aligned to the left and italicized
              Padding(
                padding: const EdgeInsets.only(top: 20), // Space between calendar and button
                child: Align(
                  alignment: Alignment.centerLeft, // Align to the left
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ArchivePage()),
                      );
                    },
                    child: const Text(
                      'Archive',
                      style: TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic, // Make text italic
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
