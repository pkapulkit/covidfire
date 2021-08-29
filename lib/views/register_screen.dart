import 'package:covid/theme/routes.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final bg = MediaQuery.of(context);
    bool isSubmitting = true;
    // TextEditingController? _nameController;
    // TextEditingController? _emailController;
    // TextEditingController? _passwordController;
    final logo = Image.asset(
      "assets/logo.png",
      height: bg.size.height / 2.5,
    );
    final nameField = TextFormField(
      enabled: isSubmitting,
      controller: nameController,
      keyboardType: TextInputType.name,
      style: const TextStyle(
        color: Colors.white,
      ),
      decoration: const InputDecoration(
          hintText: 'Pulkit Agarwal',
          labelText: 'Name',
          hintStyle: TextStyle(color: Colors.white)),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Enter Name';
        }
        return null;
      },
    );
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
          return 'Enter Mail';
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
        // Padding(
        //   padding: EdgeInsets.all(6),
        // ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.end,
        //   children: [
        //     MaterialButton(
        //       onPressed: () {},
        //       child: Text(
        //         'forgot Password',
        //         style: Theme.of(context)
        //             .textTheme
        //             .caption!
        //             .copyWith(color: Colors.white),
        //       ),
        //     )
        //   ],
        // )
      ],
    );

    final fields = Padding(
      padding: const EdgeInsets.all(5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          nameField,
          emailField,
          passwordField,
          const SizedBox(
            height: 10,
          )
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
              UserCredential userCredential =
                  await FirebaseAuth.instance.createUserWithEmailAndPassword(
                email: emailController.text,
                password: passwordController.text,
              );
              await userCredential.user!.updateDisplayName(nameController.text);
              await userCredential.user!.reload();
            } on FirebaseAuthException catch (e) {
              if (e.code == 'weak-password') {
                print('The password provided is too weak.');
              } else if (e.code == 'email-already-in-use') {
                print('The account already exists for that email.');
              }
            } catch (e) {
              nameController.text = '';
              emailController.text = '';
              passwordController.text = '';
              print(e);
            }
          }
        },
        child: const Text(
          "Register",
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Already Register?",
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    color: Colors.white,
                    //decoration: TextDecoration.underline,
                  ),
            ),
            MaterialButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.authLogin);
              },
              child: Text(
                'Login',
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
    final RegisterText = Text(
      'Register',
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
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [logo, RegisterText, fields, buttons],
          ),
        ),
      ),
    );
  }
}
