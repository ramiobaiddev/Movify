import 'package:flutter/material.dart';
import 'package:movify/shared/presentation/widgets/size_config.dart';

class Constants {
  static const String defaultProfileImage =
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTq2k2sI1nZyFTtoaKSXxeVzmAwIPchF4tjwg&s';
  static SliverGridDelegateWithFixedCrossAxisCount sliverGridDelegate(
    double width,
  ) => SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: width > SizeConfig.mobile ? 4 : 3,
    childAspectRatio: width > SizeConfig.mobile ? 0.6 : 0.5,
    crossAxisSpacing: 10,
    mainAxisSpacing: 20,
  );
  static const String bundleIdentifier = 'com.example.movify';
  static const int pageCacheCount = 3;
  static const String appLinlk =
      'https://play.google.com/store/apps/details?id=com.rami.movify';
  static const String supportEmail = 'ramiobaid545421@gmail.com';
  static const String developerWebsite =
      'https://ramiobaidportfolio.vercel.app/';
  static const String developerLinkedIn =
      'https://www.linkedin.com/in/rami-obaid-9bba8a421/';
  static const String developerTwitter = 'https://x.com/RamiObaid545421';
  static const String developerInstagram =
      'https://www.instagram.com/ramiobaiddev/';
  static const String privacyPolicyUrl =
      'https://sites.google.com/view/movifyprivacypolicy/home';
  static const String termsOfUseUrl =
      'https://sites.google.com/view/movifytermsandconditions/home';
}
