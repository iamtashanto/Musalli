import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:musalli/core/design_system/glass/glass_surface.dart';
import 'package:musalli/core/design_system/tokens/design_tokens.dart';

/// Descriptor for a single item in [GlassBottomNavBar].
@immutable
class GlassNavBarItem {
  /// Creates a [GlassNavBarItem].
  const GlassNavBarItem({
    required this.label,
    required this.icon,
    required this.activeIcon,
  });

  /// Tab label text.
  final String label;

  /// Unselected icon.
  final IconData icon;

  /// Selected icon.
  final IconData activeIcon;
}

/// Floating pill bottom navigation bar built on [GlassSurface] with a
/// spring-animated sliding active indicator, haptic selection feedback, and
/// 200% text-scale resilience.
class GlassBottomNavBar extends StatelessWidget {
  /// Creates a [GlassBottomNavBar].
  const GlassBottomNavBar({
    required this.items,
    required this.currentIndex,
    required this.onTap,
    this.isVisible = true,
    super.key,
  });

  /// Ordered navigation items (typically 5 tabs).
  final List<GlassNavBarItem> items;

  /// Currently active tab index.
  final int currentIndex;

  /// Callback invoked when a tab is tapped (including re-tapping the active tab).
  final ValueChanged<int> onTap;

  /// Controls auto-hide slide/fade visibility when scrolling down/up.
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = tokens.colors;
    final reducedMotion = context.isReducedMotion;
    final itemCount = math.max(1, items.length);

    // Compute fractional alignment (-1.0 to 1.0) for the sliding active pill.
    final alignmentX = itemCount > 1
        ? -1.0 + (2.0 * currentIndex / (itemCount - 1))
        : 0.0;

    return AnimatedSlide(
      offset: isVisible ? Offset.zero : const Offset(0, 1.35),
      duration: reducedMotion ? Duration.zero : tokens.motion.normal,
      curve: tokens.motion.emphasizedCurve,
      child: AnimatedOpacity(
        opacity: isVisible ? 1.0 : 0.0,
        duration: reducedMotion ? Duration.zero : tokens.motion.fast,
        child: SafeArea(
          top: false,
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              tokens.spacing.md,
              0,
              tokens.spacing.md,
              tokens.spacing.sm,
            ),
            child: GlassSurface(
              radius: tokens.radii.full,
              borderGlow: true,
              padding: EdgeInsets.all(tokens.spacing.xxs + 2),
              child: ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 58),
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    final tabWidth = constraints.maxWidth / itemCount;
                    return Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Positioned.fill(
                          child: AnimatedAlign(
                            alignment: Alignment(alignmentX, 0),
                            duration: reducedMotion
                                ? Duration.zero
                                : tokens.motion.emphasized,
                            curve: reducedMotion
                                ? Curves.linear
                                : Curves.easeOutBack,
                            child: Container(
                              width: tabWidth,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: tokens.radii.borderFull,
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: <Color>[
                                    colors.primaryEmerald.withValues(alpha: 0.9),
                                    colors.tealDeep.withValues(alpha: 0.9),
                                  ],
                                ),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: colors.primaryEmerald
                                        .withValues(alpha: 0.35),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: List<Widget>.generate(items.length, (int i) {
                            final item = items[i];
                            final selected = i == currentIndex;
                            final fg =
                                selected ? Colors.white : colors.textSecondary;

                            return Expanded(
                              child: Semantics(
                                selected: selected,
                                button: true,
                                label: item.label,
                                child: GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () async {
                                    await HapticFeedback.selectionClick();
                                    onTap(i);
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: tokens.spacing.xs,
                                      horizontal: 2,
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Icon(
                                          selected ? item.activeIcon : item.icon,
                                          size: 21,
                                          color: fg,
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          item.label,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          textScaler: MediaQuery.textScalerOf(
                                            context,
                                          ).clamp(maxScaleFactor: 1.3),
                                          style: tokens.typography.label.copyWith(
                                            fontSize: 11,
                                            color: fg,
                                            fontWeight: selected
                                                ? FontWeight.w700
                                                : FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Large collapsing `SliverAppBar` built on [GlassSurface] that shrinks a
/// prominent Bangla title into a frosted top bar as content scrolls beneath it.
class GlassSliverAppBar extends StatelessWidget {
  /// Creates a [GlassSliverAppBar].
  const GlassSliverAppBar({
    required this.title,
    this.subtitle,
    this.actions,
    this.leading,
    this.expandedHeight = 136,
    super.key,
  });

  /// Primary screen title.
  final String title;

  /// Optional subtitle badge or caption in the expanded header.
  final String? subtitle;

  /// Optional trailing action buttons.
  final List<Widget>? actions;

  /// Optional leading widget.
  final Widget? leading;

  /// Expanded height before collapsing.
  final double expandedHeight;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = tokens.colors;
    final textScale = MediaQuery.textScalerOf(context).scale(1);
    final adjustedExpandedHeight =
        expandedHeight + ((textScale - 1.0).clamp(0.0, 1.0) * 44.0);

    return SliverPersistentHeader(
      pinned: true,
      delegate: _GlassSliverAppBarDelegate(
        title: title,
        subtitle: subtitle,
        actions: actions,
        leading: leading,
        minExtentHeight: 68 + MediaQuery.paddingOf(context).top,
        maxExtentHeight:
            adjustedExpandedHeight + MediaQuery.paddingOf(context).top,
        tokens: tokens,
        colors: colors,
      ),
    );
  }
}

class _GlassSliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  const _GlassSliverAppBarDelegate({
    required this.title,
    required this.subtitle,
    required this.actions,
    required this.leading,
    required this.minExtentHeight,
    required this.maxExtentHeight,
    required this.tokens,
    required this.colors,
  });

  final String title;
  final String? subtitle;
  final List<Widget>? actions;
  final Widget? leading;
  final double minExtentHeight;
  final double maxExtentHeight;
  final MusalliDesignTokens tokens;
  final MusalliColorTokens colors;

  @override
  double get minExtent => minExtentHeight;

  @override
  double get maxExtent => math.max(minExtentHeight, maxExtentHeight);

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final range = math.max(1.0, maxExtent - minExtent);
    final progress = (shrinkOffset / range).clamp(0.0, 1.0);
    final topPadding = MediaQuery.paddingOf(context).top;

    return GlassSurface(
      radius: 0,
      borderRadius: BorderRadius.zero,
      enableShadow: progress > 0.15,
      opacity: 0.25 + (0.55 * progress),
      padding: EdgeInsets.fromLTRB(
        tokens.spacing.md,
        topPadding + tokens.spacing.xs,
        tokens.spacing.md,
        tokens.spacing.xs,
      ),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          // Top compact row (leading + collapsed title + actions)
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: 48,
              child: Row(
                children: <Widget>[
                  if (leading != null) ...<Widget>[
                    leading!,
                    SizedBox(width: tokens.spacing.xs),
                  ],
                  Expanded(
                    child: Opacity(
                      opacity: progress,
                      child: Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: tokens.typography.titleMedium.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  ...?actions,
                ],
              ),
            ),
          ),
          // Expanded large title & subtitle
          if (progress < 0.95)
            Positioned(
              left: 0,
              right: 0,
              bottom: 4,
              child: Opacity(
                opacity: (1.0 - (progress * 1.15)).clamp(0.0, 1.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    if (subtitle != null)
                      Text(
                        subtitle!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: tokens.typography.label.copyWith(
                          color: colors.primaryEmerald,
                        ),
                      ),
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: tokens.typography.display.copyWith(
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _GlassSliverAppBarDelegate oldDelegate) {
    return oldDelegate.title != title ||
        oldDelegate.subtitle != subtitle ||
        oldDelegate.minExtentHeight != minExtentHeight ||
        oldDelegate.maxExtentHeight != maxExtentHeight ||
        oldDelegate.tokens != tokens;
  }
}

/// Custom pull-to-refresh control featuring an animated Islamic crescent moon
/// and star indicator.
class CrescentRefreshWrapper extends StatefulWidget {
  /// Creates a [CrescentRefreshWrapper].
  const CrescentRefreshWrapper({
    required this.onRefresh,
    required this.child,
    super.key,
  });

  /// Async refresh callback.
  final Future<void> Function() onRefresh;

  /// Scrollable child widget.
  final Widget child;

  @override
  State<CrescentRefreshWrapper> createState() => _CrescentRefreshWrapperState();
}

class _CrescentRefreshWrapperState extends State<CrescentRefreshWrapper> {
  bool _isRefreshing = false;

  Future<void> _handleRefresh() async {
    setState(() => _isRefreshing = true);
    await HapticFeedback.lightImpact();
    try {
      await widget.onRefresh();
    } finally {
      if (mounted) {
        setState(() => _isRefreshing = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.tokens.colors;
    return Stack(
      children: <Widget>[
        RefreshIndicator(
          color: colors.goldAccent,
          backgroundColor: colors.surfaceLowRamFallback,
          onRefresh: _handleRefresh,
          child: widget.child,
        ),
        if (_isRefreshing)
          Positioned(
            top: 12,
            right: 16,
            child: IgnorePointer(
              child: CrescentMoonIndicator(color: colors.goldAccent),
            ),
          ),
      ],
    );
  }
}

/// Custom-painted crescent moon & star emblem used in pull-to-refresh and
/// spiritual header accents.
class CrescentMoonIndicator extends StatelessWidget {
  /// Creates a [CrescentMoonIndicator].
  const CrescentMoonIndicator({
    this.size = 28,
    this.color = const Color(0xFFFBBF24),
    super.key,
  });

  /// Logical diameter.
  final double size;

  /// Fill color of the crescent moon.
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _CrescentMoonPainter(color: color),
      ),
    );
  }
}

class _CrescentMoonPainter extends CustomPainter {
  const _CrescentMoonPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final outerRadius = size.width * 0.42;
    final innerCenter = center.translate(outerRadius * 0.35, -outerRadius * 0.15);

    final outerPath = Path()
      ..addOval(Rect.fromCircle(center: center, radius: outerRadius));
    final innerPath = Path()
      ..addOval(Rect.fromCircle(center: innerCenter, radius: outerRadius * 0.82));

    final crescent = Path.combine(
      PathOperation.difference,
      outerPath,
      innerPath,
    );

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    canvas
      ..drawPath(crescent, paint)
      ..drawCircle(
        center.translate(outerRadius * 0.42, -outerRadius * 0.32),
        size.width * 0.07,
        paint,
      );
  }

  @override
  bool shouldRepaint(covariant _CrescentMoonPainter oldDelegate) =>
      oldDelegate.color != color;
}

/// Smoothly animates integer counter transitions (for waqt countdowns,
/// tasbih counts, and prayer streaks) while formatting digits in Bangla or ASCII.
class AnimatedNumberCounter extends StatelessWidget {
  /// Creates an [AnimatedNumberCounter].
  const AnimatedNumberCounter({
    required this.value,
    required this.formatter,
    this.style,
    super.key,
  });

  /// Target integer value.
  final int value;

  /// Formatter converting the integer value into display text (e.g. Bangla digits).
  final String Function(int value) formatter;

  /// Optional text style.
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final reducedMotion = context.isReducedMotion;

    if (reducedMotion) {
      return Text(
        formatter(value),
        style: style ?? tokens.typography.titleLarge,
      );
    }

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(end: value.toDouble()),
      duration: tokens.motion.normal,
      curve: tokens.motion.standardCurve,
      builder: (BuildContext context, double animatedValue, Widget? _) {
        return Text(
          formatter(animatedValue.round()),
          style: style ?? tokens.typography.titleLarge,
        );
      },
    );
  }
}
