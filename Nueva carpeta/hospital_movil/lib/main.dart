import 'package:flutter/material.dart';
import 'app/app.dart';
import 'app/di/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Clean Architecture DI Container
  await initDependencyInjection();

  runApp(const MovilHospitalApp());
}
