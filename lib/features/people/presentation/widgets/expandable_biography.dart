import 'package:flutter/material.dart';
import 'package:movify/core/design_system/design_system.dart';

/// Biography collapsed to a few lines with a Read more toggle (only shown when
/// the text actually overflows).
class ExpandableBiography extends StatefulWidget {
  const ExpandableBiography({super.key, required this.text, this.maxLines = 6});

  final String text;
  final int maxLines;

  @override
  State<ExpandableBiography> createState() => _ExpandableBiographyState();
}

class _ExpandableBiographyState extends State<ExpandableBiography> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = Theme.of(context).textTheme;
    final style = textTheme.bodySmall?.copyWith(color: colors.textPrimary);

    return LayoutBuilder(
      builder: (context, constraints) {
        final painter = TextPainter(
          text: TextSpan(text: widget.text, style: style),
          maxLines: widget.maxLines,
          textDirection: Directionality.of(context),
          textScaler: MediaQuery.textScalerOf(context),
        )..layout(maxWidth: constraints.maxWidth);
        final overflows = painter.didExceedMaxLines;
        painter.dispose();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.text,
              style: style,
              maxLines: _expanded ? null : widget.maxLines,
              overflow: _expanded ? TextOverflow.visible : TextOverflow.ellipsis,
            ),
            if (overflows)
              GestureDetector(
                onTap: () => setState(() => _expanded = !_expanded),
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: const EdgeInsets.only(top: Space.sm),
                  child: Text(
                    _expanded ? 'Show less' : 'Read more',
                    style: textTheme.labelLarge?.copyWith(
                      color: colors.textPrimary,
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
