import 'env_service.dart';

class FlavorConfig {
  static Environment getFlavorFromArgs(List<String> args) {
    if (args.contains('--dev')) {
      return Environment.dev;
    } else if (args.contains('--stag')) {
      return Environment.stag;
    } else if (args.contains('--prod')) {
      return Environment.prod;
    }

    return Environment.dev;
  }

  static Environment getFlavorFromEnv() {
    const flavor = String.fromEnvironment('FLAVOR', defaultValue: 'dev');
    switch (flavor.toLowerCase()) {
      case 'dev':
        return Environment.dev;
      case 'stag':
        return Environment.stag;
      case 'prod':
        return Environment.prod;
      default:
        return Environment.dev;
    }
  }

  static Future<void> init(List<String> args) async {
    Environment flavor;

    if (args.contains('--dev') ||
        args.contains('--stag') ||
        args.contains('--prod')) {
      flavor = getFlavorFromArgs(args);
    } else {
      flavor = getFlavorFromEnv();
    }

    await EnvService.init(flavor);
  }
}


