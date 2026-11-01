import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constants/colors.dart';
import 'screens/login_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const HitBakoApp());
}

class HitBakoApp extends StatelessWidget {
  const HitBakoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HIT BAKO',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.backgroundNavy,
        primaryColor: AppColors.cyanAccent,
        textTheme: GoogleFonts.notoSansSinhalaTextTheme(
          ThemeData(brightness: Brightness.dark).textTheme,
        ),
        colorScheme: const ColorScheme.dark(
          primary: AppColors.cyanAccent,
          secondary: AppColors.goldYellow,
          surface: AppColors.surfaceNavy,
          background: AppColors.backgroundNavy,
        ),
      ),
      // Starts with LoginScreen for first login flow
      home: const LoginScreen(),
    );
  }
}
