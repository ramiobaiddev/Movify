import 'package:flutter/material.dart';
import 'package:movify/core/di/service_locator.dart';
import 'package:movify/core/services/app_review_service.dart';
import 'package:movify/core/services/app_update_service.dart';
import 'package:movify/features/home/presentation/views/home_feed_view_body.dart';

class HomeFeedView extends StatefulWidget {
  const HomeFeedView({super.key});

  @override
  State<HomeFeedView> createState() => _HomeFeedViewState();
}

class _HomeFeedViewState extends State<HomeFeedView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        getIt<AppReviewService>().recordAppOpenMilestone();
        getIt<AppUpdateService>().checkForUpdate(
          onFlexibleUpdateDownloaded: () {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Update downloaded successfully!'),
                  action: SnackBarAction(
                    label: 'Restart',
                    onPressed: () =>
                        getIt<AppUpdateService>().completeFlexibleUpdate(),
                  ),
                  duration: const Duration(days: 1),
                ),
              );
            }
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: SafeArea(bottom: false, child: HomeFeedViewBody()));
}
