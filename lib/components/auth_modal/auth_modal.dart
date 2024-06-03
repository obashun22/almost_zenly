import "package:almost_zenly/components/auth_modal/components/close_modal_button.dart";
import "package:almost_zenly/components/auth_modal/components/sign_in_form.dart";
import "package:almost_zenly/components/auth_modal/components/sign_up_form.dart";
import "package:flutter/material.dart";

enum AuthModalType {
  signIn,
  signUp,
}

class AuthModal extends StatefulWidget {
  const AuthModal({super.key});

  @override
  State<AuthModal> createState() => _AuthModalState();
}

class _AuthModalState extends State<AuthModal> {
  AuthModalType modalType = AuthModalType.signIn;
  String buttonLabel = "新規作成へ";

  void switchModalType() {
    setState(() {
      modalType = modalType == AuthModalType.signIn
          ? AuthModalType.signUp
          : AuthModalType.signIn;
      buttonLabel = modalType == AuthModalType.signIn ? "新規作成へ" : "サインインへ";
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => unFocus(context),
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.9,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: const CloseModalButton(),
                ),
                modalType == AuthModalType.signIn ? SignInForm() : SignUpForm(),
                TextButton(
                    onPressed: switchModalType, child: Text(buttonLabel)),
                const SizedBox(height: 300),
              ],
            ),
          ),
        ));
  }

  void unFocus(BuildContext context) {
    final FocusScopeNode currentScope = FocusScope.of(context);
    if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
      FocusManager.instance.primaryFocus!.unfocus();
    }
  }
}
