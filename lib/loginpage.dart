import 'package:flutter/material.dart';
import 'package:echno_attendance/reusable widgets/login_field.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(
        body: Container(
          width: double.infinity,
          height: size.height,
          child: Stack(
            children: <Widget>[
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/logo/2.png',
                      height: 100,
                      width: 100,
                    ),
                    Image.asset(
                      'assets/logo/3.png',
                      height: 75,
                      width: 75,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Login",
                      style: TextStyle(
                        fontFamily: 'TT Chocolates',
                        fontSize: 40,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      "Sign in to continue.",
                      style: TextStyle(
                        fontFamily: 'TT Chocolates',
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    const LoginField(hint: 'Employee Number'),
                    const SizedBox(
                      height: 30,
                    ),
                    const LoginField(hint: 'Password'),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Image.asset('assets/logo/footer.png'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
