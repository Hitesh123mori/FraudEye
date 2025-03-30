

import 'package:url_launcher/url_launcher.dart';

class HelperFunctions{


  /// for launch url
  static void launchURL(String url) {
    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      url = 'https://$url';
    }
    launchUrl(Uri.parse(url));
  }



}