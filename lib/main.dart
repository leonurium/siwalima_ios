import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../config/app_colors.dart';
import '../pages/dashboard_page.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          //platform: TargetPlatform.iOS,
          primaryColor: AppColors.primary,
          backgroundColor: Colors.white,
          scaffoldBackgroundColor: Colors.white,
          colorScheme: ColorScheme.light(
            primary: AppColors.primary,
            secondary: AppColors.secondary,
          ),
          appBarTheme: const AppBarTheme(            
            color: Colors.white,                     
          ),
          textTheme: GoogleFonts.poppinsTextTheme(),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(AppColors.primary),
              shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              padding: const MaterialStatePropertyAll(
                EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
              textStyle: const MaterialStatePropertyAll(
                TextStyle(fontSize: 15),
              ),
            ),
          ),
        ),
        home: const DashboardPage(),
      ),
    );
  }
}
