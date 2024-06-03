import 'package:flutter/material.dart';
import 'package:almost_zenly/screens/profile_screen/profile_screen.dart';

class ProfileButton extends StatelessWidget {
  const ProfileButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const ProfileScreen(),
        ),
      ),
      child: const Icon(Icons.person),
    );
  }
}
