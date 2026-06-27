import 'package:url_launcher/url_launcher.dart';

/// Front-end helper for mock external actions such as phone and WhatsApp links.
abstract final class UtilityUrlActions {
  static Future<bool> launchExternalUri(Uri uri) async {
    try {
      return await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {
      return false;
    }
  }
}
