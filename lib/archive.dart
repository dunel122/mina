import 'package:flutter/material.dart';

class ArchivePage extends StatefulWidget {
  const ArchivePage({Key? key}) : super(key: key);

  @override
  _ArchivePageState createState() => _ArchivePageState();
}

class _ArchivePageState extends State<ArchivePage> {
  // Controller for the search TextField
  TextEditingController _searchController = TextEditingController();

  // Example list of archived tenants
  List<Map<String, String>> archivedTenants = [
    {'Name': 'John Doe', 'Date': '2023-01-15'},
    {'Name': 'Jane Smith', 'Date': '2023-02-20'},
    {'Name': 'Mary Johnson', 'Date': '2023-03-10'},
    {'Name': 'Chris Lee', 'Date': '2023-04-05'},
    // Add more archived tenants as needed
  ];

  // Filtered list based on search
  List<Map<String, String>> filteredArchivedTenants = [];

  @override
  void initState() {
    super.initState();
    filteredArchivedTenants = archivedTenants; // Initially show all archived tenants
  }

  void _filterArchivedTenants() {
    setState(() {
      // Filter archived tenants by name
      filteredArchivedTenants = archivedTenants.where((tenant) {
        return tenant['Name']!.toLowerCase().contains(_searchController.text.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Archived Tenants'),
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
                          _filterArchivedTenants(); // Call filter method on text change
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

              // Table displaying archived tenant details
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
                    0: FlexColumnWidth(3), // Adjust column width for Name
                    1: FlexColumnWidth(2), // Adjust column width for Date
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
                            'Date',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22, // Increased font size
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Add rows for filtered archived tenants
                    for (var tenant in filteredArchivedTenants)
                      TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              tenant['Name']!,
                              style: const TextStyle(
                                fontSize: 20, // Adjust font size
                                overflow: TextOverflow.ellipsis, // Prevent overflow
                              ),
                              maxLines: 1, // Limit text to one line
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              tenant['Date']!,
                              style: const TextStyle(
                                fontSize: 20, // Adjust font size
                                overflow: TextOverflow.ellipsis, // Prevent overflow
                              ),
                              maxLines: 1, // Limit text to one line
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
