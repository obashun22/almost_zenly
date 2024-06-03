import 'package:almost_zenly/components/auth_modal/components/animated_error_message.dart';
import 'package:almost_zenly/components/auth_modal/components/auth_modal_image.dart';
import 'package:almost_zenly/components/auth_modal/components/auth_text_form_field.dart';
import 'package:almost_zenly/components/auth_modal/components/submit_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    super.key,
  });

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
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

  // ------------ Validate Confirm Password ------------
  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter some text";
    }
    if (value != _passwordController.text) {
      return "Passwords do not match";
    }
    return null;
  }

  // ------------ SignUp ------------
  Future<UserCredential?> signUp({
    required String email,
    required String password,
  }) async {
    _setIsLoading(true);
    try {
      return FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        _setErrorMessage('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        _setErrorMessage('The account already exists for that email.');
      } else {
        _setErrorMessage(e.message ?? '');
      }
    } finally {
      _setIsLoading(false);
    }
    return null;
  }

  // ------------ Create App User ------------
  Future<void> createAppUser(String userId) async {
    final Position position = await Geolocator.getCurrentPosition();
    final GeoPoint location = GeoPoint(position.latitude, position.longitude);
    await FirebaseFirestore.instance.collection('app_users').doc(userId).set({
      'name': 'your name please!',
      'profile': 'your profile please!',
      'imageType': 'lion',
      'location': location,
    });
  }

  // ------------ Submit ------------
  Future<void> _submit(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final UserCredential? user = await signUp(
        email: _emailController.text,
        password: _passwordController.text,
      );
      if (!mounted) return;
      if (user != null) {
        await createAppUser(user.user!.uid);
        Future.delayed(
          const Duration(milliseconds: 500),
          Navigator.of(context).pop,
        );
      }
    }
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
            "Sign Up",
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
          AuthTextFormField(
            obscureText: true,
            validator: validateConfirmPassword,
            labelText: "Confirm Password",
            onChanged: (value) => _clearErrorMessage(),
          ),
          const SizedBox(height: 16),
          SubmitButton(
              labelName: "新規登録",
              onTap: () => _submit(context),
              isLoading: isLoading)
        ]));
  }
}
