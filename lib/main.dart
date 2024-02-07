import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talkies/providers/app_auth_provider.dart';
import 'package:talkies/screens/splash/splash_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    //this executes if started in web
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyDAMcjDcEvU3Hsji32vTna05rpk5YhyMNY",
        projectId: "talkies-b8e63",
        messagingSenderId: "769409823973",
        appId: "1:769409823973:web:4c1f412d60977f9638500c",
      ),
    );
  }
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppAuthProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
