import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../firebase_options.dart';

class Registerview extends StatefulWidget {
  const Registerview({super.key});

  @override
  State<Registerview> createState() => _RegisterviewState();
}

class _RegisterviewState extends State<Registerview> {
  late final TextEditingController email;
  late final TextEditingController psswd;

  @override
  void initState() {
    email = TextEditingController();
    psswd = TextEditingController();
    super.initState();
  }

  String em1 = '';
  String pss = '';
  String error = '';
  bool erexists = false;
  bool a = false;

  @override
  void dispose() {
    email.dispose();
    psswd.dispose();
    super.dispose();
  }

  void pressed(em, ps) {
    setState(() {
      em1 = em;
      pss = ps;
      a = true;
    });
  }

  void err(String error1) {
    setState(() {
      erexists = true;
      error = error1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Register')),
      ),
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return Column(children: [
                TextField(
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
                  decoration:
                      const InputDecoration(hintText: 'Enter email here'),
                ),
                TextField(
                  controller: psswd,
                  obscureText: true,
                  enableSuggestions: false,
                  keyboardType: TextInputType.visiblePassword,
                  autocorrect: false,
                  decoration: const InputDecoration(hintText: 'Enter password'),
                ),
                const SizedBox(height: 20),
                 Row(
                      children: [
                        const SizedBox(width: 80,),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/login');
                            },
                            child: const Text('Login')),
                            const SizedBox(width: 80),
                            ElevatedButton(
                  onPressed: () async {
                    final email1 = email.text;
                    final password = psswd.text;
                    pressed(email1, password);

                    try {
                      await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: email1, password: password);
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        err('Password is too weak');
                      } else if (e.code == 'email-already-in-use') {
                        err('Email already exists');
                      }
                    }
                  },
                  child: const Text('Register'),
                ),
                      ],
                    ),
                
                Visibility(
                    visible: a,
                    child: TextButton(onPressed: () => a, child: Text(em1))),
                Visibility(
                    visible: erexists,
                    child: Text(
                      error,
                      style: TextStyle(color: Colors.red),
                    ))
              ]);

            default:
              return const Text('Loading...');
          }
        },
      ),
    );
  }
}
