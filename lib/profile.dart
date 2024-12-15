import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isUnpaidChecked = false; // State to manage checkbox value
  double balance = 0.0; // Initial balance
  TextEditingController balanceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    balanceController.text = balance.toStringAsFixed(2); // Initialize controller with balance
  }

  // Function to show the dialog to input amount to add to the balance
  void _showAddBalanceDialog() {
    final TextEditingController amountController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Balance'),
          content: TextField(
            controller: amountController,
            keyboardType: TextInputType.number, // Only allow numbers
            decoration: const InputDecoration(
              labelText: 'Amount',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final double? amount = double.tryParse(amountController.text);
                if (amount != null) {
                  setState(() {
                    balance += amount; // Add the entered amount to the balance
                    balanceController.text = balance.toStringAsFixed(2); // Update the balance display
                  });
                  Navigator.of(context).pop(); // Close dialog
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Invalid amount')),
                  );
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  // Function to show the dialog for payment input
  void _showPaymentDialog() {
    final TextEditingController paymentController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter Payment Amount'),
          content: TextField(
            controller: paymentController,
            keyboardType: TextInputType.number, // Only allow numbers
            decoration: const InputDecoration(
              labelText: 'Payment Amount',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final double? paymentAmount = double.tryParse(paymentController.text);
                if (paymentAmount != null && paymentAmount <= balance) {
                  setState(() {
                    balance -= paymentAmount; // Subtract the payment from balance
                    balanceController.text = balance.toStringAsFixed(2); // Update the balance display
                  });
                  Navigator.of(context).pop(); // Close dialog
                } else if (paymentAmount == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Invalid amount')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Insufficient balance')),
                  );
                }
              },
              child: const Text('Confirm Payment'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tenant Profile'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Delete button pressed')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  Icons.person,
                  color: Colors.grey,
                  size: 80,
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TextFormField(
                    controller: balanceController, // Bind the controller to display balance
                    decoration: InputDecoration(
                      labelText: 'Balance',
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: _showAddBalanceDialog,
                      ),
                    ),
                    readOnly: true, // Make this field read-only
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _showPaymentDialog, // Call the payment dialog
                  child: const Text('Payment'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Transactions button pressed')),
                    );
                  },
                  child: const Text('Transactions'),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Last Name',
                            border: UnderlineInputBorder(),
                          ),
                          initialValue: '',
                          enabled: false, // Make this field non-editable
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'First Name',
                            border: UnderlineInputBorder(),
                          ),
                          initialValue: '',
                          enabled: false,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Middle Name',
                            border: UnderlineInputBorder(),
                          ),
                          initialValue: '',
                          enabled: false,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: null,
                          items: ['Male', 'Female'].map((String sex) {
                            return DropdownMenuItem<String>(
                              value: sex,
                              child: Text(sex),
                            );
                          }).toList(),
                          onChanged: null, // Disable the dropdown
                          decoration: InputDecoration(
                            labelText: 'Sex',
                            border: UnderlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Phone',
                            border: UnderlineInputBorder(),
                          ),
                          initialValue: '',
                          enabled: false,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Birthday',
                            border: UnderlineInputBorder(),
                          ),
                          initialValue: '',
                          enabled: false,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Room#',
                            border: UnderlineInputBorder(),
                          ),
                          initialValue: '',
                          enabled: false,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Date',
                            border: UnderlineInputBorder(),
                          ),
                          initialValue: '',
                          enabled: false,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'PARENT OR GUARDIAN',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Last Name',
                            border: UnderlineInputBorder(),
                          ),
                          initialValue: '',
                          enabled: false,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'First Name',
                            border: UnderlineInputBorder(),
                          ),
                          initialValue: '',
                          enabled: false,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Middle Name',
                            border: UnderlineInputBorder(),
                          ),
                          initialValue: '',
                          enabled: false,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: null,
                          items: ['Male', 'Female'].map((String sex) {
                            return DropdownMenuItem<String>(
                              value: sex,
                              child: Text(sex),
                            );
                          }).toList(),
                          onChanged: null,
                          decoration: InputDecoration(
                            labelText: 'Sex',
                            border: UnderlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Phone 1',
                            border: UnderlineInputBorder(),
                          ),
                          initialValue: '',
                          enabled: false,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Phone 2',
                            border: UnderlineInputBorder(),
                          ),
                          initialValue: '',
                          enabled: false,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Mark unpaid',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Transform.scale(
                    scale: 1.5,
                    child: Checkbox(
                      value: isUnpaidChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isUnpaidChecked = value ?? false;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
