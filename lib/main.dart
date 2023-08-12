import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notes/views/Registerview.dart';

import 'package:notes/views/loginview.dart';

import 'firebase_options.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: 'Flutter',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
    ),
    initialRoute: '/register',
    routes: {
      '/': (context) => const HomePage(),
      '/login': (context) => const Loginview(),
      '/register': (context) => const Registerview()
    },
    // home: const Registerview(),
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Column(
          children: [
            Image.asset(
              'assets/blackscr.jpg',
              height: 932,
              fit: BoxFit.cover,
            ),
            // FutureBuilder(
            //   future: Firebase.initializeApp(
            //     options: DefaultFirebaseOptions.currentPlatform,
            //   ),
            //   builder: (context, snapshot) {
            //     User? user = FirebaseAuth.instance.currentUser;
            //     switch (snapshot.connectionState) {
            //       case ConnectionState.done:
            //         if (user?.emailVerified ?? false) {
            //           return const Text('Email is verified');
            //         } else {
            //           return const Text('Email is not verified');
            //         }
            //       default:
            //         return const Text('Loading...');
            //     }
            //   },
            // )
          ],
        )
      ],
    ));
  }
}
