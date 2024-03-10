import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:unicrush/presentation/configs/configs.dart';
import 'package:unicrush/presentation/views/auth/login/login_page.dart';
import 'package:unicrush/presentation/widgets/custom_text_field.dart';

import 'signup_page_controller.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});
  final SignupPageController controller = Get.put(SignupPageController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignupPageController>(
      builder: (_) => Scaffold(
        backgroundColor: kBackground,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 50.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'SignUp',
                          style: textStyleTitle,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Enter your credentials to \ncontinue.',
                          textAlign: TextAlign.center,
                          style: textStyleSubTitle,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              CustomTextField(
                controller: controller.usernameController,
                hint: 'Enter your Username',
                keyboardType: TextInputType.emailAddress,
                label: 'Username',
              ),
              CustomTextField(
                controller: controller.emailController,
                hint: 'Enter your Email-id',
                keyboardType: TextInputType.emailAddress,
                label: 'Email',
              ),
              CustomTextField(
                controller: controller.passwordController,
                hint: 'Enter your password',
                keyboardType: TextInputType.emailAddress,
                label: 'Password',
                isPassword: true,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: controller.signUp,
                        child: const Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Text('SignUp'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: const BoxDecoration(color: Colors.grey),
                    width: Get.width / 4,
                    height: 2,
                  ),
                  const Text('Or SignUp With'),
                  Container(
                    decoration: const BoxDecoration(color: Colors.grey),
                    width: Get.width / 4,
                    height: 2,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _socialIconBtn(FontAwesomeIcons.facebook),
                  _socialIconBtn(FontAwesomeIcons.google),
                ],
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Already Have an Account? ',
                      style: textStyleSubTitle2,
                    ),
                    TextSpan(
                      text: 'Login',
                      style: const TextStyle(
                        fontSize: 18.0,
                        color: Colors.blue,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Get.to(() => LoginPage()),
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

  Widget _socialIconBtn(IconData icon) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.white,
        ),
        child: Icon(
          icon,
          size: 35,
        ),
      ),
    );
  }
}
