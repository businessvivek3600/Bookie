import 'package:flutter/material.dart';
import 'package:my_global_tools/repo_injection.dart';
import 'package:my_global_tools/services/auth_service.dart';

import 'MyApp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initRepos();
  runApp(StreamAuthScope(child: const MyApp()));
}
