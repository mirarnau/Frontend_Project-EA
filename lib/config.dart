String get apiURL {
  bool isProd = const bool.fromEnvironment('dart.vm.product');
  if (isProd) {
    return 'https://ea2api.soon.it';
    // replace with your production API endpoint
  }

  return "http://localhost:3000";
  // replace with your own development API endpoint
}