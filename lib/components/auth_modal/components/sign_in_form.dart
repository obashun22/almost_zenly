import 'package:almost_zenly/components/auth_modal/components/animated_error_message.dart';
import 'package:almost_zenly/components/auth_modal/components/auth_modal_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:almost_zenly/components/auth_modal/components/auth_text_form_field.dart';
import 'package:almost_zenly/components/auth_modal/components/submit_button.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({
    super.key,
  });

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String errorMessage = '';
  bool isLoading = false;

  void _setIsLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  void _setErrorMessage(String message) {
    setState(() {
      errorMessage = message;
    });
  }

  void _clearErrorMessage() {
    setState(() {
      errorMessage = '';
    });
  }

  // ------------ Validate Email ------------
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter some text";
    }
    return null;
  }

  // ------------ Validate Password ------------
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter some text";
    }
    return null;
  }

  // ------------ Submit ------------
  Future<void> _submit(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final UserCredential? user = await signIn(
        email: _emailController.text,
        password: _passwordController.text,
      );
      if (!mounted) return;
      if (user != null) {
        Future.delayed(
          const Duration(milliseconds: 500),
          Navigator.of(context).pop,
        );
      }
    }
  }

  // ------------ SignIn ------------
  Future<UserCredential?> signIn({
    required String email,
    required String password,
  }) async {
    _setIsLoading(true);
    try {
      return await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        _setErrorMessage('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        _setErrorMessage('Wrong password provided for that user.');
      } else {
        _setErrorMessage('An error occurred, please try again later.');
      }
    } finally {
      _setIsLoading(false);
    }
    return null;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(children: [
          const Text(
            "Sign In",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const AuthModalImage(),
          const SizedBox(height: 16),
          AnimatedErrorMessage(message: errorMessage),
          const SizedBox(height: 16),
          AuthTextFormField(
            controller: _emailController,
            validator: validateEmail,
            labelText: "Email",
            onChanged: (value) => _clearErrorMessage(),
          ),
          const SizedBox(height: 16),
          AuthTextFormField(
            controller: _passwordController,
            obscureText: true,
            validator: validatePassword,
            labelText: "Password",
            onChanged: (value) => _clearErrorMessage(),
          ),
          const SizedBox(height: 16),
          SubmitButton(
              labelName: "サインイン",
              onTap: () => _submit(context),
              isLoading: isLoading)
        ]));
  }
}
