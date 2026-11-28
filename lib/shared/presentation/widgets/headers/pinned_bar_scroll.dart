import 'package:flutter/material.dart';

/// A [CustomScrollView] with a bar that fades in at the top once the content's
/// own header buttons have scrolled away, and stays there.
///
/// The bar draws its own status-bar inset and is [toolbarHeight] tall below it.
class PinnedBarScroll extends StatefulWidget {
  const PinnedBarScroll({super.key, required this.slivers, required this.bar});

  static const double toolbarHeight = kToolbarHeight;

  final List<Widget> slivers;
  final Widget bar;

  @override
  State<PinnedBarScroll> createState() => _PinnedBarScrollState();
}

class _PinnedBarScrollState extends State<PinnedBarScroll> {
  final _controller = ScrollController();
  final _visible = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onScroll);
  }

  void _onScroll() {
    final threshold =
        MediaQuery.paddingOf(context).top + PinnedBarScroll.toolbarHeight;
    _visible.value = _controller.offset > threshold;
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_onScroll)
      ..dispose();
    _visible.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Stack(
    children: [
      CustomScrollView(controller: _controller, slivers: widget.slivers),
      Positioned(
        top: 0,
        left: 0,
        right: 0,
        child: ValueListenableBuilder<bool>(
          valueListenable: _visible,
          child: widget.bar,
          builder: (context, visible, bar) => IgnorePointer(
            ignoring: !visible,
            child: AnimatedOpacity(
              opacity: visible ? 1 : 0,
              duration: const Duration(milliseconds: 150),
              child: bar,
            ),
          ),
        ),
      ),
    ],
  );
}
