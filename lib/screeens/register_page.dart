import 'package:chating_app/components/custom_button.dart';
import 'package:chating_app/components/custom_textfield.dart';
import 'package:chating_app/service/auth_service.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  void Function()? onTap;
  RegisterPage({super.key, required this.onTap});

  TextEditingController _emailController = TextEditingController();
  TextEditingController _pwController = TextEditingController();
  TextEditingController _confirmPwController = TextEditingController();

  AuthService _authService = AuthService();
  void register(BuildContext context) async {
    if (_pwController.text != _confirmPwController.text) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Passwords do not match')));
    } else {
      try {
        await _authService.signUp(_emailController.text, _pwController.text);
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          Icon(
            Icons.message,
            size: 60,
            color: Theme.of(context).colorScheme.primary,
          ),

          SizedBox(height: 60),
          Text(
            'Let\'s create an account for you!',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 25),
          CustomTextfield(
            controller: _emailController,
            hintText: 'Email',
            obscureText: false,
          ),
          SizedBox(height: 10),

          CustomTextfield(
            controller: _pwController,
            hintText: 'Password',
            obscureText: true,
          ),

          SizedBox(height: 10),

          CustomTextfield(
            controller: _confirmPwController,
            hintText: 'Confirm Password',
            obscureText: true,
          ),

          SizedBox(height: 30),

          CustomButton(onTap: () => register(context), text: 'Register'),

          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('Already a member?'),
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    ' Login now',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
