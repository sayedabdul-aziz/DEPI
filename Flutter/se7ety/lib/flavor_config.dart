abstract class FlavorConfig {
  String get baseUrl;
  String get name;
}

class ProductionConfig implements FlavorConfig {
  @override
  String get baseUrl => 'https://jsonplaceholder.typicode.com';

  @override
  String get name => 'Production';
}

class StagingConfig implements FlavorConfig {
  @override
  String get baseUrl => 'https://jsonplaceholder.typicode.com';

  @override
  String get name => 'Staging';
}


enum FlavorEnvironment {
  production,
  staging,
}
