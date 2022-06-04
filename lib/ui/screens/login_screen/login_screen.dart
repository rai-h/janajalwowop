import 'package:flutter/material.dart';
import 'package:janajaldoot/sevices/auth.services.dart';
import 'package:janajaldoot/ui/helping_widget/custom_textfield.dart';
import 'package:janajaldoot/ui/helping_widget/round_button.dart';
import 'package:janajaldoot/ui/screens/main_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String emailError = '';
  String passwordError = '';
  String otpErrorText = '';

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Positioned(
            bottom: -(size.width * 0.2),
            right: -(size.width * 0.2),
            child: Opacity(
                opacity: 0.2,
                child: Image.asset(
                  'assets/images/janajal_logo.png',
                  fit: BoxFit.fill,
                  width: size.width * 0.7,
                )),
          ),
          Align(
            alignment: Alignment.center,
            child: Opacity(
                opacity: 0.1,
                child: Image.asset(
                  'assets/images/wow.png',
                  fit: BoxFit.fill,
                  width: size.width * 0.7,
                )),
          ),
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20),
              height: size.height,
              width: size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.width * 0.1,
                  ),
                  Image.asset(
                    'assets/images/jjwowlogo.png',
                    width: 200,
                  ),
                  SizedBox(
                    height: size.width * 0.12,
                  ),
                  CustomTextField(
                    errorText: emailError,
                    text: 'Username',
                    controller: emailController,
                  ),
                  SizedBox(
                    height: size.width * 0.1,
                  ),
                  CustomTextField(
                    errorText: passwordError,
                    isObscure: true,
                    text: 'Password',
                    controller: passController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(),
                    ],
                  ),
                  SizedBox(
                    height: size.width * 0.1,
                  ),
                  RoundButton(
                      onPress: () {
                        AuthServices.authenticateUser(
                            context,
                            emailController.text.toString().trim(),
                            passController.text.toString().trim());
                      },
                      color: Colors.blue.shade900,
                      text: 'Login'),
                  SizedBox(
                    height: size.width * 0.05,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
