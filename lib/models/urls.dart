import 'package:gdsc_lnct/models/toast.dart';
import 'package:url_launcher/url_launcher.dart';

enum Url {
  discord,
  gdsc,
  website,
  linkedin,
  insta,
  facebook,
  twitter,
  spotify,
  youtube,
  web,
}

class URL {
  String web = "http://gdsclnct.xyz";
  String facebook = 'https://www.facebook.com/lnctdev';
  String twitter = 'https://twitter.com/gdsclnct';
  String linkedin = 'https://www.linkedin.com/company/dsc-lnct';
  String insta = 'https://www.instagram.com/gdsc_lnct';
  String gdsc =
      'https://gdsc.community.dev/lakshmi-narain-college-of-technology-lnct-bhopal/';
  String discord = 'https://discord.gg/vvFsARysk6';
  String youtube = 'https://youtube.com/channel/UCr4nj7gGFSsBznyaEu2o4lw';

  void launchURL(Url name) async {
    String url;
    if (name == Url.facebook) {
      url = facebook;
    } else if (name == Url.gdsc) {
      url = gdsc;
    } else if (name == Url.linkedin) {
      url = linkedin;
    } else if (name == Url.insta) {
      url = insta;
    } else if (name == Url.twitter) {
      url = twitter;
    } else if (name == Url.discord) {
      url = discord;
    } else if (name == Url.web) {
      url = web;
    } else {
      url = youtube;
    }

    await canLaunch(url)
        ? await launch(url)
        : showToast(message: "Couldn't Launch URL");
  }
}
