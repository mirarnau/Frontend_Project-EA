import 'package:flutter/foundation.dart';

String get apiURL {
  bool isProd = const bool.fromEnvironment('dart.vm.product');
  if (isProd) {
    return 'https://ea2api.soon.it';
  } else {
    if (kIsWeb) {
      return "http://localhost:3000";
    } else {
      return "http://10.0.2.2:3000";
    }
  }
}
