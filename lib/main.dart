import 'package:evenzio_new/provider/loginProvider.dart';
import 'package:evenzio_new/provider/mainprovider.dart';
import 'package:evenzio_new/user/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';



import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'Admin/adminhome.dart';
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call initializeApp before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());


}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=> MainProvider()),
        ChangeNotifierProvider(create: (context)=> LoginProvider())

      ],
      child: MaterialApp(debugShowCheckedModeBanner: false,
        title: 'Evenzio',
        theme: ThemeData(
          // textTheme: GoogleFonts.sacramentoTextTheme(
          //   Theme.of(context).textTheme,
          // ),


          colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
          useMaterial3: true,
        ),
        home: Splash(),
        // home: home(),
        // home: AdminHome(),







      ),
    );
  }
}

