// 1. Provider pour centraliser l'URL de base
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final baseUrlProvider = Provider<String>((ref) {
  // 10.0.2.2 est l'adresse IP pour accéder à l'hôte depuis l'émulateur Android
  if (kIsWeb) return 'http://localhost:8080';
  if (Platform.isAndroid) return 'http://10.0.2.2:8080';
  return 'http://127.0.0.1:8080';
});