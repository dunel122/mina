import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'dbconnection.dart';  // Import the DBConnection class
import 'home.dart'; // Assuming HomePage is another page in your app

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final _lastNameController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _middleNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _roomController = TextEditingController();
  final _birthdayController = TextEditingController();

  final _guardianLastNameController = TextEditingController();
  final _guardianFirstNameController = TextEditingController();
  final _guardianMiddleNameController = TextEditingController();
  final _guardianPhone1Controller = TextEditingController();
  final _guardianPhone2Controller = TextEditingController();
  final _guardianPhone3Controller = TextEditingController();

  String? _selectedSex;
  DateTime _selectedBirthday = DateTime.now();
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Tenant'),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
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
                            controller: _lastNameController,
                            decoration: InputDecoration(
                              labelText: 'Last Name',
                              border: UnderlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter last name';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: TextFormField(
                            controller: _firstNameController,
                            decoration: InputDecoration(
                              labelText: 'First Name',
                              border: UnderlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter first name';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _middleNameController,
                            decoration: InputDecoration(
                              labelText: 'Middle Name',
                              border: UnderlineInputBorder(),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: _selectedSex,
                            items: ['Male', 'Female'].map((String sex) {
                              return DropdownMenuItem<String>(
                                value: sex,
                                child: Text(sex),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedSex = value;
                              });
                            },
                            decoration: InputDecoration(
                              labelText: 'Sex',
                              border: UnderlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select sex';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _phoneController,
                            decoration: InputDecoration(
                              labelText: 'Phone',
                              border: UnderlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter phone number';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: TextFormField(
                            controller: _birthdayController,
                            decoration: InputDecoration(
                              labelText: 'Birthday',
                              border: UnderlineInputBorder(),
                            ),
                            readOnly: true,
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: _selectedBirthday,
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now(),
                              );
                              if (pickedDate != null && pickedDate != _selectedBirthday) {
                                setState(() {
                                  _selectedBirthday = pickedDate;
                                  _birthdayController.text =
                                  "${_selectedBirthday.toLocal()}".split(' ')[0]; // Format date
                                });
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _roomController,
                            decoration: InputDecoration(
                              labelText: 'Room#',
                              border: UnderlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter room number';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Date',
                              border: UnderlineInputBorder(),
                            ),
                            readOnly: true,
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: _selectedDate,
                                firstDate: DateTime(2020),
                                lastDate: DateTime(2030),
                              );
                              if (pickedDate != null && pickedDate != _selectedDate) {
                                setState(() {
                                  _selectedDate = pickedDate;
                                });
                              }
                            },
                            controller: TextEditingController(
                              text: "${_selectedDate.toLocal()}".split(' ')[0],
                            ),
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
                            controller: _guardianLastNameController,
                            decoration: InputDecoration(
                              labelText: 'Last Name',
                              border: UnderlineInputBorder(),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: TextFormField(
                            controller: _guardianFirstNameController,
                            decoration: InputDecoration(
                              labelText: 'First Name',
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
                            controller: _guardianMiddleNameController,
                            decoration: InputDecoration(
                              labelText: 'Middle Name',
                              border: UnderlineInputBorder(),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: _selectedSex,
                            items: ['Male', 'Female'].map((String sex) {
                              return DropdownMenuItem<String>(
                                value: sex,
                                child: Text(sex),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedSex = value;
                              });
                            },
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
                            controller: _guardianPhone1Controller,
                            decoration: InputDecoration(
                              labelText: 'Phone# 1',
                              border: UnderlineInputBorder(),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: TextFormField(
                            controller: _guardianPhone2Controller,
                            decoration: InputDecoration(
                              labelText: 'Phone# 2',
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
                            controller: _guardianPhone3Controller,
                            decoration: InputDecoration(
                              labelText: 'Phone# 3',
                              border: UnderlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      // Access the database correctly
                      Database db = await DBConnection.database;

                      // Insert user data
                      await db.insert('User', {
                        'firstname': _firstNameController.text,
                        'lastname': _lastNameController.text,
                        'midname': _middleNameController.text,
                        'sex': _selectedSex,
                        'phone': _phoneController.text,
                        'birth': _birthdayController.text,
                        'date': _selectedDate.toString(),
                        'roomnum': int.parse(_roomController.text),
                      });

                      // Insert guardian data
                      await db.insert('Guardian', {
                        'uid': 1,  // Adjust based on actual logic
                        'l_name': _guardianLastNameController.text,
                        'f_name': _guardianFirstNameController.text,
                        'm_name': _guardianMiddleNameController.text,
                        'sex': _selectedSex,
                        'phone1': _guardianPhone1Controller.text,
                        'phone2': _guardianPhone2Controller.text,
                        'phone3': _guardianPhone3Controller.text,
                      });

                      // Success - Show a message and navigate
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('User Registered Successfully!')),
                      );

                      // Redirect to HomePage or another page
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    } catch (e) {
                      // Error handling
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error: $e')),
                      );
                    }
                  }
                },
                child: const Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
