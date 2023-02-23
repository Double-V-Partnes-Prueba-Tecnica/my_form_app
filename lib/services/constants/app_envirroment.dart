class AppEnviroment {
  final String apiLocalURL = 'http://192.168.0.100:3000/';
  final String apiURL = 'http://localhost:3000/';

  String get getApiURL {
    const flutterEnv =
        String.fromEnvironment('FLUTTER_ENV', defaultValue: 'LOCAL');
    if (flutterEnv == 'LOCAL') {
      return apiLocalURL;
    } else {
      return apiURL;
    }
  }
}
