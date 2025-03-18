import 'package:flow_funds/pages/auth_page.dart';
import 'package:flow_funds/providers/category_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:localstorage/localstorage.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initLocalStorage();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CategoryProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FlowFunds',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Color(0xFF48C9B3),
            // primary: Color(0xFF0CC0DF),
            // secondary: Color.fromRGBO(169, 204, 227, 1),
            // secondary: Color(0xFFA9CCE3),
            // tertiary: Color.fromRGBO(245, 245, 220, 1),
            // tertiary: Color(0xFFF5F5DC),
            // textColor with bg primary: Color(0xFF2C3E50)
            // textColor heading: Color(0xFF292828)
          ),
          fontFamily: GoogleFonts.openSans().fontFamily,
        ),
        home: AuthPage(),
      ),
    );
  }
}
