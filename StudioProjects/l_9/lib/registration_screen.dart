import 'package:flutter/material.dart';
import 'db_helper.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            const Center(
              child: Icon(
                Icons.person, // Change this to your preferred icon
                size: 100, // Change this to your preferred size
              ),
            ),
            const SizedBox(height: 50),
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(8), // Padding of 8
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10), // Rounded borders
                ),
                labelText: 'Username',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your username';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(8), // Padding of 8
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10), // Rounded borders
                ),
                labelText: 'Password',
              ),
              obscureText: true,
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _phoneController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(8), // Padding of 8
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10), // Rounded borders
                ),
                labelText: 'Phone',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your phone number';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(8), // Padding of 8
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10), // Rounded borders
                ),
                labelText: 'Email',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _addressController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(8), // Padding of 8
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10), // Rounded borders
                ),
                labelText: 'Address',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your address';
                }
                return null;
              },
            ),
            const SizedBox(height: 50),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // Create a User object from the input data
                    User user = User(
                      id: null,
                      username: _usernameController.text,
                      password: _passwordController.text,
                      phone: _phoneController.text,
                      email: _emailController.text,
                      address: _addressController.text,
                    );

                    // Save the user data to the database
                    DBHelper dbHelper = DBHelper();
                    await dbHelper.saveUser(user);

                    // Show a success message
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('User data saved')),
                    );

                    await dbHelper.test_read('user.db');
                  }
                },
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}