import 'package:ayletna_restaurant_app/core/core_spacing.dart';
import 'package:ayletna_restaurant_app/utilities/utility_responsive_breakpoints.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Screen-level max-width content wrapper with edge-attached page scrolling.
class WidgetsScreenLayout extends StatefulWidget {
  const WidgetsScreenLayout({
    required this.child,
    this.fullWidth = false,
    super.key,
  });

  final Widget child;
  final bool fullWidth;

  @override
  State<WidgetsScreenLayout> createState() => _WidgetsScreenLayoutState();
}

class _WidgetsScreenLayoutState extends State<WidgetsScreenLayout> {
  late final ScrollController _primaryScrollController;

  @override
  void initState() {
    super.initState();
    _primaryScrollController = ScrollController();
  }

  @override
  void dispose() {
    _primaryScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final maxW =
        widget.fullWidth
            ? width
            : UtilityResponsiveBreakpoints.maxContentWidthForWidth(width);
    final pad = CoreSpacing.lg(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final contentWidth = width.clamp(0, maxW).toDouble();
        final scrollableWidth = (contentWidth - (pad * 2)).clamp(
          0,
          contentWidth,
        );
        final sideHitWidth =
            ((width - scrollableWidth) / 2).clamp(0, width / 2).toDouble();

        return PrimaryScrollController(
          controller: _primaryScrollController,
          automaticallyInheritForPlatforms: TargetPlatform.values.toSet(),
          child: RawScrollbar(
            controller: _primaryScrollController,
            interactive: true,
            radius: Radius.circular(CoreSpacing.radiusChip),
            thickness: 6,
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(
                context,
              ).copyWith(scrollbars: false),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: maxW),
                      child: Padding(
                        padding: EdgeInsetsDirectional.symmetric(
                          horizontal: pad,
                        ),
                        child: widget.child,
                      ),
                    ),
                  ),
                  if (sideHitWidth > 0) ...[
                    PositionedDirectional(
                      top: 0,
                      bottom: 0,
                      start: 0,
                      width: sideHitWidth,
                      child: _EdgeScrollZone(
                        controller: _primaryScrollController,
                      ),
                    ),
                    PositionedDirectional(
                      top: 0,
                      bottom: 0,
                      end: 0,
                      width: sideHitWidth,
                      child: _EdgeScrollZone(
                        controller: _primaryScrollController,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _EdgeScrollZone extends StatelessWidget {
  const _EdgeScrollZone({required this.controller});

  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerSignal: (event) {
        if (event is PointerScrollEvent) {
          _scrollBy(event.scrollDelta.dy);
        }
      },
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onVerticalDragUpdate: (details) {
          _scrollBy(-details.delta.dy);
        },
      ),
    );
  }

  void _scrollBy(double delta) {
    if (!controller.hasClients) return;

    final position = controller.position;
    final target = (position.pixels + delta).clamp(
      position.minScrollExtent,
      position.maxScrollExtent,
    );
    controller.jumpTo(target);
  }
}
