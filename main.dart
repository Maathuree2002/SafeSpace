import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Login(title: 'SafeSpace'), // Use the Login widget instead of myHomePage
    );
  }
}

class Login extends StatefulWidget {
  const Login({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView( //Wrap with SingleChildScrollView
        child : Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: "Email"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: "Password"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }

                    List<String> errors = [];

                    // Password requirements
                    if (value.length < 8) {
                      errors.add('Password must be at least 8 characters');
                    }

                    // Check for at least one uppercase letter
                    if (!value.contains(RegExp(r'[A-Z]'))) {
                      errors.add('Password must contain at least one uppercase letter');
                    }

                    // Check for at least one lowercase letter
                    if (!value.contains(RegExp(r'[a-z]'))) {
                      errors.add('Password must contain at least one lowercase letter');
                    }

                    // Check for at least one digit
                    if (!value.contains(RegExp(r'[0-9]'))) {
                      errors.add('Password must contain at least one digit');
                    }

                    // Check for at least one special character (#)
                    if (!value.contains('#')) {
                      errors.add('Password must contain the special character "#"');
                    }

                    // Return the accumulated errors or null if the password meets the requirements
                    return errors.isNotEmpty ? errors.join('\n') : null;
                  },
                ),
              ),
      
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16.0),
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Process the login logic using emailController.text and passwordController.text
                        String email = emailController.text;
                        String password = passwordController.text;

                        // Example: Print the email and password
                        print('Email: $email, Password: $password');

                        // You can implement your authentication logic here
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Please fill input')),
                        );
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
 }
}