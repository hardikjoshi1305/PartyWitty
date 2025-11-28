import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'injection_container.dart' as di;
import 'core/constants/app_colors.dart';
import 'features/event_listing/presentation/pages/event_listing_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PartyWitty',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryPurple,
          primary: AppColors.primaryPurple,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.backgroundWhite,
        // Set Lexend as the default font family
        textTheme: GoogleFonts.lexendTextTheme(),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.backgroundWhite,
          elevation: 0,
          iconTheme: IconThemeData(color: AppColors.iconPrimary),
        ),
      ),
      home: const EventListingPage(),
    );
  }
}
