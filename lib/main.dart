import 'package:crewmeister_frontend_coding_challenge/di_config.dart';
import 'package:crewmeister_frontend_coding_challenge/features/absence_manager/presentation/pages/absences_page.dart';
import 'package:flutter/material.dart';

void main() {
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crewmeister frontend coding challenge',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: const AbsencesPage(),
    );
  }
}
