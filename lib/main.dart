import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app.dart';
import 'services/meal_store.dart';
import 'services/gemini_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Future.wait([
    MealStore.instance.load(),
    GeminiService.load(),
  ]);
  runApp(const MacroSnapApp());
}
