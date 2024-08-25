
import 'package:flutter_common/config/constants.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static final String serverUrl =
      dotenv.maybeGet('BASE_URL') ?? "http://${Constants.serverIp}:4000/";
  static final String gqlEndpoint = '${serverUrl}graphql';
  static bool isDemoMode = dotenv.maybeGet('DEMO_MODE') == 'true';
  static String appName = dotenv.maybeGet('APP_NAME') ?? "FDSMA";
  static String companyName = dotenv.maybeGet('COMPANY_NAME') ?? "PrivateAero";
  static String firebaseMessagingVapidKey = dotenv.maybeGet('FIREBASE_MESSAGING_VAPID_KEY') ?? "";
  static int placeSearchSearchRadius = 100000;
  static double desktopNavigationBarHeight = 96;
}
