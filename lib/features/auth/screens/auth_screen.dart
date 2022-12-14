import 'package:amazonclone/common/widgets/custom_button.dart';
import 'package:amazonclone/common/widgets/custom_textfield.dart';
import 'package:amazonclone/features/auth/services/auth_service.dart';
import 'package:flutter/material.dart';
import './../../../constants/global_variables.dart';

enum Auth {
  signin,
  signup,
}

Auth auth = Auth.signup; //setting up the default value

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-screen';
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final signupFormKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final signinFormKey = GlobalKey<FormState>();
  final TextEditingController passwordController2 = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    passwordController2.dispose();
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AuthService authService = AuthService();
    final String hintText;

    void signInUser() {
      authService.signInUser(
        context: context,
        email: usernameController.text,
        password: passwordController2.text,
      );
    }

    void signUpUser() {
      authService.signUpUser(
        context: context,
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
      );
    }

    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundCOlor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text('Benvenuto su',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Image.asset(
                    'assets/images/amazon_logo.png',
                    height: 100,
                    alignment: Alignment.center,
                  ),
                ),
                ListTile(
                  title: const Text(
                    'Crea account',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  leading: Radio(
                    activeColor: GlobalVariables.secondaryColor,
                    value: Auth.signup,
                    groupValue: auth,
                    onChanged: (Auth? value) {
                      setState(
                        () {
                          auth = value!;
                        },
                      );
                    },
                  ),
                ),
                /**
               * Show the form if the auth is signup
               */
                if (auth == Auth.signup)
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    color: GlobalVariables.backgroundColor,
                    child: Form(
                      key: signupFormKey,
                      child: Column(
                        children: [
                          CustomTextFiled(
                            controller: nameController,
                            hintText: 'Nome',
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextFiled(
                            controller: emailController,
                            hintText: 'eMail',
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextFiled(
                            controller: passwordController,
                            hintText: 'Password',
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomButton(
                            text: 'Registrati',
                            onTap: () {
                              signupFormKey.currentState!.validate()
                                  ? signUpUser()
                                  : null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ListTile(
                  tileColor: auth == Auth.signin
                      ? GlobalVariables.backgroundColor
                      : GlobalVariables.greyBackgroundCOlor,
                  title: const Text(
                    'Login',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  leading: Radio(
                    activeColor: GlobalVariables.secondaryColor,
                    value: Auth.signin,
                    groupValue: auth,
                    onChanged: (Auth? value) {
                      setState(
                        () {
                          auth = value!;
                        },
                      );
                    },
                  ),
                ),
                /**
               * Show the form if the auth is signin
               */
                if (auth == Auth.signin)
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    color: GlobalVariables.backgroundColor,
                    child: Form(
                      key: signinFormKey,
                      child: Column(
                        children: [
                          CustomTextFiled(
                            controller: usernameController,
                            hintText: 'eMail',
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextFiled(
                            controller: passwordController2,
                            hintText: 'Password',
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomButton(
                            text: 'Accedi',
                            onTap: () {
                              signinFormKey.currentState!.validate()
                                  ? signInUser()
                                  : null;
                            },
                          ),
                        ],
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
