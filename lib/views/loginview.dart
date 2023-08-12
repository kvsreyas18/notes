import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../firebase_options.dart';

class Loginview extends StatefulWidget {
  const Loginview({super.key});

  @override
  State<Loginview> createState() => _LoginviewState();
}

class _LoginviewState extends State<Loginview> {
  late final TextEditingController email;
  late final TextEditingController psswd;

  bool emnot = false;
  bool psnot = false;

  User? user;
  @override
  void initState() {
    email = TextEditingController();
    psswd = TextEditingController();
    user = FirebaseAuth.instance.currentUser;
    super.initState();
  }

  @override
  void dispose() {
    email.dispose();
    psswd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void pswrong() {
      print('password wrong');
      setState(() {
        psnot = true;
      });
    }

    void logincheck() {
      setState(() {
        user = FirebaseAuth.instance.currentUser;
      });
    }

    if (user != null) {
      print(user);
    } else {
      print('No user logged in');
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: FutureBuilder(
          future: Firebase.initializeApp(
              options: DefaultFirebaseOptions.currentPlatform),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return Column(
                  children: [
                    TextField(
                        controller: email,
                        keyboardType: TextInputType.emailAddress,
                        decoration:
                            const InputDecoration(hintText: 'Enter email:')),
                    TextField(
                      controller: psswd,
                      keyboardType: TextInputType.visiblePassword,
                      decoration:
                          const InputDecoration(hintText: 'Enter password'),
                    ),
                    TextButton(
                      onPressed: () async {
                        final em = email.text;
                        final password = psswd.text;
                        try {
                          await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: em, password: password);
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            print('sfws');
                            pswrong();
                          } else if (e.code == 'wrong-password') {
                            pswrong();
                          }
                        }
                        logincheck();
                      },
                      child: const Text('Login'),
                    ),
                    Visibility(
                        visible: psnot,
                        child: const Text(
                          'Wrong password',
                          style: TextStyle(color: Colors.red),
                        )),
                  ],
                );
              default:
               return const Text('Loading..');
            }
          }),
    );
  }
}
