import 'package:flutter/material.dart';
import 'profile.dart'; // Import the ProfilePage
import 'dbconnection.dart'; // Import the DBConnection to access the database

class TenantPage extends StatefulWidget {
  const TenantPage({Key? key}) : super(key: key);

  @override
  _TenantPageState createState() => _TenantPageState();
}

class _TenantPageState extends State<TenantPage> {
  // Controller for the search TextField
  TextEditingController _searchController = TextEditingController();

  // List to store tenants fetched from the database
  List<Map<String, dynamic>> tenants = [];

  // Filtered list based on search
  List<Map<String, dynamic>> filteredTenants = [];

  @override
  void initState() {
    super.initState();
    _fetchTenants(); // Fetch tenants from the database when the page loads
  }

  // Function to fetch tenants from the database
  Future<void> _fetchTenants() async {
    final db = await DBConnection.database;
    final List<Map<String, dynamic>> tenantData = await db.query('User');
    setState(() {
      tenants = tenantData;
      filteredTenants = tenants; // Set filtered tenants initially to all tenants
    });
  }

  // Function to filter tenants based on search
  void _filterTenants() {
    setState(() {
      // Filter tenants by name or room
      filteredTenants = tenants.where((tenant) {
        return tenant['firstname']!.toLowerCase().contains(_searchController.text.toLowerCase()) ||
            tenant['lastname']!.toLowerCase().contains(_searchController.text.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registered Tenants'),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView( // Wrap in SingleChildScrollView to allow scrolling
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Search box with icon
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0, top: 30.0), // Adjusted top padding to move it lower
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        onChanged: (text) {
                          _filterTenants(); // Call filter method on text change
                        },
                        style: TextStyle(
                          fontSize: 20, // Increased font size of search text
                        ),
                        decoration: InputDecoration(
                          hintText: 'Search by Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0), // Adjust horizontal space for the icon
                      child: const Icon(
                        Icons.search,
                        color: Colors.deepPurple, // Color of the search icon
                        size: 30, // Increased size of the search icon
                      ),
                    ),
                  ],
                ),
              ),

              // Table displaying tenant details
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Table(
                  border: TableBorder.all( // Add borders to each cell
                    color: Colors.grey.shade300,
                    width: 1.0,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  columnWidths: {
                    0: FixedColumnWidth(280), // Wider for Name
                    1: FixedColumnWidth(100), // Narrower for Room #
                  },
                  children: [
                    TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Name',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22, // Increased font size
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Room #',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22, // Increased font size
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Add rows for filtered tenants only if data exists
                    if (filteredTenants.isEmpty)
                      TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'No tenants registered.',
                              style: const TextStyle(
                                fontSize: 18, // Smaller font for message
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(''),
                          ),
                        ],
                      ),
                    // Add rows for each tenant in filteredTenants
                    for (var tenant in filteredTenants)
                      TableRow(
                        children: [
                          GestureDetector(
                            onTap: () {
                              // Navigate to ProfilePage when a tenant is tapped
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProfilePage(),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '${tenant['firstname']} ${tenant['lastname']}',
                                style: const TextStyle(
                                  fontSize: 20, // Increased font size
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              tenant['roomnum'] != null ? tenant['roomnum'].toString() : 'N/A',
                              style: const TextStyle(
                                fontSize: 20, // Increased font size
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
