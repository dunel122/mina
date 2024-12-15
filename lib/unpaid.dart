import 'package:flutter/material.dart';

class UnpaidPage extends StatefulWidget {
  const UnpaidPage({Key? key}) : super(key: key);

  @override
  _UnpaidPageState createState() => _UnpaidPageState();
}

class _UnpaidPageState extends State<UnpaidPage> {
  // Controller for the search TextField
  TextEditingController _searchController = TextEditingController();

  // Example list of tenants with unpaid status
  List<Map<String, String>> unpaidTenants = [
    {'Name': 'John Doe', 'Status': 'Unpaid'},
    {'Name': 'Jane Smith', 'Status': 'Unpaid'},
    {'Name': 'Chris Lee', 'Status': 'Unpaid'},
    // Add more tenants as needed
  ];

  // Filtered list based on search
  List<Map<String, String>> filteredUnpaidTenants = [];

  @override
  void initState() {
    super.initState();
    filteredUnpaidTenants = unpaidTenants; // Initially show all tenants
  }

  void _filterUnpaidTenants() {
    setState(() {
      // Filter tenants by name
      filteredUnpaidTenants = unpaidTenants.where((tenant) {
        return tenant['Name']!.toLowerCase().contains(_searchController.text.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Unpaid Tenants'),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Search box with icon
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0, top: 30.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        onChanged: (text) {
                          _filterUnpaidTenants(); // Call filter method on text change
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
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: const Icon(
                        Icons.search,
                        color: Colors.deepPurple,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),

              // Table displaying unpaid tenant details
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Table(
                  border: TableBorder.all(
                    color: Colors.grey.shade300,
                    width: 1.0,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  columnWidths: {
                    0: FixedColumnWidth(280), // Wider for Name
                    1: FixedColumnWidth(150), // For Status
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
                            'Status',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22, // Increased font size
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Add rows for filtered tenants
                    for (var tenant in filteredUnpaidTenants)
                      TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              tenant['Name']!,
                              style: const TextStyle(
                                fontSize: 20, // Increased font size
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              tenant['Status']!,
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
