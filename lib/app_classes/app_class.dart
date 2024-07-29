import 'package:community_islamic_app/model/prayer_times_static_model.dart';
import 'package:url_launcher/url_launcher.dart';

class AppClass {
  Future<void> launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }
}
