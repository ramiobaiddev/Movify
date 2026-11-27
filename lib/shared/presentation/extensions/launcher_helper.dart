import 'package:flutter/material.dart';
import 'package:movify/core/utils/app_logger.dart';
import 'package:url_launcher/url_launcher.dart';

extension LaunchUrlHelper on BuildContext {
  Future<void> openUrl(String urlString) async {
    final uri = Uri.parse(urlString);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      AppLogger.error('Could not launch $uri');
    }
  }
}
