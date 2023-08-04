import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  List<String> categories = [
    'UI/UX',
    'Coding',
    'Basic UI',
    'Computing',
    'AI',
  ];

  int selectedCategory = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(0),
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 32),
              const Text(
                'WELCOME TO EDU',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.deepPurple,
                ),
              ),
              Image.asset(
                'assets/images/login_or_singup_page_pic.png',
                height: Get.height * 0.6,
              ),
              // SizedBox(),
              MaterialButton(
                elevation: .0,
                color: Colors.deepPurple,
                height: 50,
                minWidth: Get.width * 0.75,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  );
                },
                child: const Text(
                  'LOGIN',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              MaterialButton(
                elevation: .0,
                color: Colors.deepPurple[50],
                height: 50,
                minWidth: Get.width * 0.75,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SingupPage(),
                    ),
                  );
                },
                child: Text(
                  'SIGNUP',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple[400],
                    fontSize: 18,
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

Widget loginMethodWidget(IconData icon) => MaterialButton(
      minWidth: 45,
      height: 45,
      padding: const EdgeInsets.all(4),
      elevation: .0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
        side: const BorderSide(
          color: Color.fromARGB(255, 232, 232, 232),
          width: 2,
        ),
      ),
      onPressed: () {},
      child: Icon(
        icon,
        color: Colors.deepPurple,
      ),
    );

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  List<String> categories = [
    'UI/UX',
    'Coding',
    'Basic UI',
    'Computing',
    'AI',
  ];

  int selectedCategory = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(0),
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 16),
              const Text(
                'LOGIN',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.deepPurple,
                ),
              ),
              Image.asset(
                'assets/images/login_or_singup_page_pic.png',
                height: Get.height * 0.6,
              ),
              textField('Email', Icons.person),
              textField('Password', Icons.lock, Icons.remove_red_eye),
              MaterialButton(
                elevation: .0,
                color: Colors.deepPurple,
                height: 50,
                minWidth: Get.width * 0.75,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                onPressed: () {},
                child: const Text(
                  'LOGIN',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {},
                child: const Text(
                  "Don't have an account ? Signup",
                  style: TextStyle(
                    color: Colors.deepPurple,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding textField(String hint, IconData prefixIcon, [IconData? suffixIcon]) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: SizedBox(
        width: Get.width * 0.75,
        height: 50,
        child: TextField(
          decoration: InputDecoration(
            fillColor: Colors.deepPurple[50],
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
            hintText: hint,
            hintStyle: const TextStyle(
              color: Colors.deepPurple,
            ),
            prefixIcon: Icon(
              prefixIcon,
              color: Colors.deepPurple,
            ),
            suffixIcon: suffixIcon != null
                ? Icon(
                    suffixIcon,
                    color: Colors.deepPurple,
                  )
                : null,
          ),
        ),
      ),
    );
  }
}

class SingupPage extends StatefulWidget {
  const SingupPage({super.key});

  @override
  State<SingupPage> createState() => _SingupPageState();
}

class _SingupPageState extends State<SingupPage> {
  List<String> categories = [
    'UI/UX',
    'Coding',
    'Basic UI',
    'Computing',
    'AI',
  ];

  int selectedCategory = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(0),
        child: Center(
          child: Column(
            children: [
              const Text(
                'SIGNUP',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.deepPurple,
                ),
              ),
              Image.asset(
                'assets/images/login_or_singup_page_pic.png',
                height: Get.height * 0.6,
              ),
              MaterialButton(
                elevation: .0,
                color: Colors.deepPurple,
                height: 50,
                minWidth: Get.width * 0.75,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                onPressed: () {},
                child: const Text(
                  'LOGIN',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {},
                child: const Text(
                  "Don't have an account ? Signup",
                  style: TextStyle(
                    color: Colors.deepPurple,
                  ),
                ),
              ),
              SizedBox(
                width: Get.width * 0.75,
                child: const Row(
                  children: [
                    Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('OR'),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.fromLTRB(Get.width * 0.2, 8, Get.width * 0.2, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    loginMethodWidget(Ionicons.logo_facebook),
                    loginMethodWidget(Ionicons.logo_twitter),
                    loginMethodWidget(Ionicons.logo_google),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
