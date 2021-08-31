import 'package:covid/theme/routes.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final bg = MediaQuery.of(context);
    bool isSubmitting = true;
    // TextEditingController? _emailController;
    // TextEditingController? _passwordController;
    final logo = Image.asset(
      "assets/logo.png",
      height: bg.size.height / 2.5,
    );

    // final forgotdialog = AwesomeDialog(
    //   context: context,
    //   animType: AnimType.SCALE,
    //   dialogType: DialogType.INFO,
    //   body: Center(
    //     child: Text(
    //       'Enter Email',
    //       style: TextStyle(fontStyle: FontStyle.italic),
    //     ),
    //   ),
    //   title: 'This is Ignored',
    //   desc: 'This is also Ignored',
    //   btnOkOnPress: () {},
    // )..show();
    final emailField = TextFormField(
      enabled: isSubmitting,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      style: const TextStyle(
        color: Colors.white,
      ),
      decoration: const InputDecoration(
          hintText: 'pkapulkit@gmail.com',
          labelText: 'Email',
          hintStyle: TextStyle(color: Colors.white)),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Enter Email';
        }
        return null;
      },
    );

    final passwordField = Column(
      children: [
        TextFormField(
          enabled: isSubmitting,
          controller: passwordController,
          keyboardType: TextInputType.visiblePassword,
          style: const TextStyle(
            color: Colors.white,
          ),
          decoration: const InputDecoration(
              hintText: 'password',
              labelText: 'password',
              hintStyle: TextStyle(color: Colors.white)),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Enter Password';
            }
            return null;
          },
        ),
        const Padding(
          padding: EdgeInsets.all(6),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            MaterialButton(
              onPressed: () => showDialog(
                  context: context,
                  builder: (context) => Dialog(
                        elevation: 5,
                        backgroundColor: Colors.blueGrey,
                        child: Container(
                          height: 150,
                          width: 500,
                          child: Padding(
                            padding: EdgeInsets.all(6),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Forgot Password',
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                emailField,
                                ElevatedButton(
                                    onPressed: () async {
                                      try {
                                        if (emailController.text.isNotEmpty) {
                                          FirebaseAuth.instance
                                              .sendPasswordResetEmail(
                                                  email: emailController.text);
                                          Navigator.pop(context);
                                        }
                                      } catch (e) {
                                        print(e);
                                      }
                                    },
                                    child: Text('Send Request'))
                              ],
                            ),
                          ),
                        ),
                      ),
                  //child: ForgotDialog(),
                  barrierDismissible: false),
              child: Text(
                'Forgot Password ?',
                style: Theme.of(context)
                    .textTheme
                    .caption!
                    .copyWith(color: Colors.white),
              ),
            )
          ],
        )
      ],
    );

    final fields = Padding(
      padding: const EdgeInsets.all(5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          emailField,
          passwordField,
        ],
      ),
    );

    final loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.white,
      child: MaterialButton(
        minWidth: bg.size.width / 1.2,
        padding: const EdgeInsets.fromLTRB(0, 15, 10, 15),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            try {
              UserCredential userCredential = await FirebaseAuth.instance
                  .signInWithEmailAndPassword(
                      email: emailController.text,
                      password: passwordController.text);
              Navigator.of(context).pushNamed(AppRoutes.homeRoute);
            } on FirebaseAuthException catch (e) {
              if (e.code == 'user-not-found') {
                print('No user found for that email.');
              } else if (e.code == 'wrong-password') {
                print('Wrong password provided for that user.');
              }
            }
          }
        },
        child: const Text(
          "Login",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    final anonyomusButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.white,
      child: MaterialButton(
        minWidth: bg.size.width / 1.2,
        padding: const EdgeInsets.fromLTRB(0, 15, 10, 15),
        onPressed: () async {
          UserCredential userCredential =
              await FirebaseAuth.instance.signInAnonymously();
          Navigator.of(context).pushNamed(AppRoutes.homeRoute);
        },
        child: const Text(
          "Anonymous",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    final buttons = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        loginButton,
        const Padding(
          padding: EdgeInsets.all(6),
        ),
        anonyomusButton,
        const Padding(
          padding: EdgeInsets.all(6),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Not a Member?",
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    color: Colors.white,
                    //decoration: TextDecoration.underline,
                  ),
            ),
            MaterialButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.authRegister);
              },
              child: Text(
                'Sign Up',
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                    ),
              ),
            )
          ],
        ),
      ],
    );
    final LoginText = Text(
      'Login',
      style: TextStyle(
        color: Colors.white,
        fontSize: 35,
        fontWeight: FontWeight.bold,
      ),
    );
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [logo, LoginText, fields, buttons],
          ),
        ),
      ),
    );
  }
}
