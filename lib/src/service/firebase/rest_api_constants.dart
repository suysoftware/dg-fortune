
import 'package:flutter_dotenv/flutter_dotenv.dart';

class RestApiConstants {
  static String API_LINK_SEND_MANIFEST_MESSAGE = dotenv.env['SEND_MANIFEST_MESSAGE'].toString();

  /*
  static String API_LINK_AUTH_SIGNIN = dotenv.env['TB_AUTH_SIGNIN_API_URL'].toString();
  static String API_LINK_AUTH_CREATE_CUSTOM_TOKEN = dotenv.env['TB_AUTH_CREATE_CUSTOM_TOKEN'].toString();
  static String API_LINK_AUTH_CREATE_PORTAL_URL = dotenv.env['TB_AUTH_CREATE_PORTAL_URL_API_URL'].toString();
  static String API_LINK_USAGE_STATS = dotenv.env['TB_USAGE_STATS_API_URL'].toString();
  static String API_LINK_ART = dotenv.env['TB_ART_API_URL'].toString();
  static String API_LINK_ASSISTANT = dotenv.env['TB_ASSISTANT_API_URL'].toString();
  static String API_LINK_DICTATION = dotenv.env['TB_DICTATION_API_URL'].toString();
  static String API_LINK_DICTA_TRANSLATION = dotenv.env['TB_DICTA_TRANSLATION_API_URL'].toString();
  static String API_LINK_TEXT_EDITOR = dotenv.env['TB_TEXT_EDITOR_API_URL'].toString();
  static String API_LINK_TRANSLATION = dotenv.env['TB_TRANSLATION_API_URL'].toString();
  static String API_LINK_AUTH_SHORTCUT_CONFIGURATION = dotenv.env['TB_AUTH_SHORTCUT_CONFIGURATION_API_URL'].toString();*/
}
