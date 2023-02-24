class AppEnviroment {
  final String apiLocalURL = 'http://localhost:3000/';
  final String apiURL = 'http://54.156.128.171:3000/';

  String get getApiURL {
    const flutterEnv =
        String.fromEnvironment('FLUTTER_ENV', defaultValue: 'DEV');
    if (flutterEnv == 'LOCAL') {
      return apiLocalURL;
    } else {
      return apiURL;
    }
  }
}
