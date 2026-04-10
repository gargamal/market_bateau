import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:select_bateau/core/utils/constants.dart';

final dioProvider = Provider<Dio>((ref) {
  return Dio(BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: const Duration(seconds: 5),
  ));
});