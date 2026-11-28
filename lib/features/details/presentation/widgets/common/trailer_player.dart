import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/features/details/presentation/models/details_content.dart';
import 'package:movify/shared/presentation/widgets/headers/header_circle_action.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

/// Plays [video] full width over a dark scrim. The close button or a tap on
/// the scrim dismisses it; the player's own button goes full screen.
Future<void> showTrailerPlayer(BuildContext context, VideoItem video) =>
    showGeneralDialog<void>(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Close',
      barrierColor: context.colors.surfacePrimary.withValues(alpha: 0.92),
      pageBuilder: (_, _, _) => _TrailerPlayer(video: video),
    );

class _TrailerPlayer extends StatefulWidget {
  const _TrailerPlayer({required this.video});

  final VideoItem video;

  @override
  State<_TrailerPlayer> createState() => _TrailerPlayerState();
}

class _TrailerPlayerState extends State<_TrailerPlayer> {
  late final YoutubePlayerController _controller;

  // The web view is heavy to start; wait for the dialog to finish opening so
  // the transition stays smooth.
  bool _showPlayer = false;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController.fromVideoId(
      autoPlay: true,
      videoId: widget.video.youtubeKey,
      params: const YoutubePlayerParams(showFullscreenButton: true),
    );
    Future<void>.delayed(const Duration(milliseconds: 250), () {
      if (mounted) {
        setState(() => _showPlayer = true);
      }
    });
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Material(
      type: MaterialType.transparency,
      child: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: _showPlayer
                        ? YoutubePlayer(controller: _controller)
                        : ColoredBox(color: colors.surfaceGenre),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(Space.lg),
                    child: Text(
                      widget.video.name,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: colors.textPrimary,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: Space.sm,
              left: Space.lg,
              child: HeaderCircleAction(
                icon: Icons.close_rounded,
                label: 'Close',
                onTap: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
