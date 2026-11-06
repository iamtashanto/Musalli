import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:musalli/core/design_system/glass/glass_surface.dart';
import 'package:musalli/core/design_system/tokens/design_tokens.dart';

/// Reusable press-scale wrapper (`0.97` scale on press with spring release and
/// optional haptic feedback) that respects `MediaQuery.disableAnimations`.
class PressScaleContainer extends StatefulWidget {
  /// Creates a [PressScaleContainer].
  const PressScaleContainer({
    required this.child,
    this.onTap,
    this.pressedScale = 0.97,
    this.enableHaptic = true,
    this.hapticSelectionClick = false,
    this.semanticLabel,
    this.semanticButton = false,
    super.key,
  });

  /// Child widget.
  final Widget child;

  /// Callback invoked on tap. If `null`, press animation is disabled.
  final VoidCallback? onTap;

  /// Scale factor applied while pressed (`0.97` default).
  final double pressedScale;

  /// Whether to trigger haptic feedback on tap.
  final bool enableHaptic;

  /// When `true`, uses [HapticFeedback.selectionClick] instead of
  /// [HapticFeedback.lightImpact].
  final bool hapticSelectionClick;

  /// Optional accessibility label.
  final String? semanticLabel;

  /// Whether this container represents a semantic button.
  final bool semanticButton;

  @override
  State<PressScaleContainer> createState() => _PressScaleContainerState();
}

class _PressScaleContainerState extends State<PressScaleContainer> {
  bool _isPressed = false;

  Future<void> _triggerHaptic() async {
    if (!widget.enableHaptic) return;
    if (widget.hapticSelectionClick) {
      await HapticFeedback.selectionClick();
    } else {
      await HapticFeedback.lightImpact();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.onTap == null) {
      return widget.child;
    }

    final reducedMotion = context.isReducedMotion;
    final motion = context.tokens.motion;

    return Semantics(
      button: widget.semanticButton,
      label: widget.semanticLabel,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: (_) {
          if (!reducedMotion) {
            setState(() => _isPressed = true);
          }
        },
        onTapUp: (_) {
          if (_isPressed) {
            setState(() => _isPressed = false);
          }
        },
        onTapCancel: () {
          if (_isPressed) {
            setState(() => _isPressed = false);
          }
        },
        onTap: () {
          unawaited(_triggerHaptic());
          widget.onTap?.call();
        },
        child: AnimatedScale(
          scale: (!reducedMotion && _isPressed) ? widget.pressedScale : 1.0,
          duration: _isPressed ? motion.fast : motion.normal,
          curve: _isPressed ? motion.standardCurve : Curves.easeOutBack,
          child: widget.child,
        ),
      ),
    );
  }
}

/// Interactive or static card built on [GlassSurface] with press-scale
/// micro-interaction and optional Hero transition support.
class GlassCard extends StatelessWidget {
  /// Creates a [GlassCard].
  const GlassCard({
    required this.child,
    this.onTap,
    this.padding,
    this.margin,
    this.radius,
    this.borderGlow = false,
    this.enableBlur = false,
    this.heroTag,
    this.semanticLabel,
    super.key,
  });

  /// Card body widget.
  final Widget child;

  /// Optional tap callback (enables `0.97` press-scale animation and haptic).
  final VoidCallback? onTap;

  /// Inner card padding (defaults to `16pt`).
  final EdgeInsetsGeometry? padding;

  /// Outer card margin.
  final EdgeInsetsGeometry? margin;

  /// Corner radius override (defaults to `20pt`).
  final double? radius;

  /// Whether to render a gold/emerald border glow.
  final bool borderGlow;

  /// Whether to enable real-time `BackdropFilter` on this individual card.
  ///
  /// Defaults to `false` so lists of 50+ `GlassCard`s maintain a locked 60fps
  /// without per-item offscreen blur buffers, while hero cards can set `true`.
  final bool enableBlur;

  /// Optional Hero tag for shared-element container transitions (`Card -> Detail`).
  final Object? heroTag;

  /// Optional accessibility label.
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    Widget surface = GlassSurface(
      padding: padding ?? EdgeInsets.all(tokens.spacing.md),
      margin: margin,
      radius: radius ?? tokens.radii.md,
      borderGlow: borderGlow,
      enableBlur: enableBlur,
      enableShadow: enableBlur,
      child: child,
    );

    if (heroTag != null) {
      surface = Hero(
        tag: heroTag!,
        flightShuttleBuilder:
            (
              BuildContext flightContext,
              Animation<double> animation,
              HeroFlightDirection flightDirection,
              BuildContext fromHeroContext,
              BuildContext toHeroContext,
            ) {
              return Material(
                type: MaterialType.transparency,
                child: toHeroContext.widget,
              );
            },
        child: Material(type: MaterialType.transparency, child: surface),
      );
    }

    return PressScaleContainer(
      onTap: onTap,
      semanticButton: onTap != null,
      semanticLabel: semanticLabel,
      child: surface,
    );
  }
}

/// Visual variants for [GlassButton].
enum GlassButtonVariant {
  /// Solid emerald/teal gradient fill with specular border and light text.
  primary,

  /// Frosted translucent glass fill with 1px highlight border.
  secondary,

  /// Minimal borderless glass ghost button.
  ghost,
}

/// Button component with `primary`, `secondary`, and `ghost` glass styles,
/// press-scale (`0.97`) animation, and haptic impact.
class GlassButton extends StatelessWidget {
  /// Creates a [GlassButton].
  const GlassButton({
    required this.label,
    required this.onPressed,
    this.icon,
    this.variant = GlassButtonVariant.primary,
    this.isExpanded = false,
    this.semanticLabel,
    super.key,
  });

  /// Button text label.
  final String label;

  /// Tap callback.
  final VoidCallback? onPressed;

  /// Optional leading icon.
  final IconData? icon;

  /// Visual style variant.
  final GlassButtonVariant variant;

  /// When `true`, expands horizontally to fill available width.
  final bool isExpanded;

  /// Optional semantic label.
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = tokens.colors;

    final foregroundColor = switch (variant) {
      GlassButtonVariant.primary => Colors.white,
      GlassButtonVariant.secondary => colors.textPrimary,
      GlassButtonVariant.ghost => colors.primaryEmerald,
    };

    final content = Row(
      mainAxisSize: isExpanded ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        if (icon != null) ...<Widget>[
          Icon(icon, size: 18, color: foregroundColor),
          SizedBox(width: tokens.spacing.xs),
        ],
        Flexible(
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: tokens.typography.titleMedium.copyWith(
              fontSize: 15,
              color: foregroundColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );

    Widget buttonBody;
    switch (variant) {
      case GlassButtonVariant.primary:
        buttonBody = DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: tokens.radii.borderSm,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[colors.primaryEmerald, colors.tealDeep],
            ),
            border: Border.all(color: Colors.white.withValues(alpha: 0.28)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: colors.primaryEmerald.withValues(alpha: 0.32),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: tokens.spacing.lg,
              vertical: tokens.spacing.sm,
            ),
            child: content,
          ),
        );
      case GlassButtonVariant.secondary:
        buttonBody = GlassSurface(
          radius: tokens.radii.sm,
          enableBlur: false,
          padding: EdgeInsets.symmetric(
            horizontal: tokens.spacing.lg,
            vertical: tokens.spacing.sm,
          ),
          child: content,
        );
      case GlassButtonVariant.ghost:
        buttonBody = DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: tokens.radii.borderSm,
            color: colors.primaryEmerald.withValues(alpha: 0.1),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: tokens.spacing.md,
              vertical: tokens.spacing.xs + 2,
            ),
            child: content,
          ),
        );
    }

    return PressScaleContainer(
      onTap: onPressed,
      semanticButton: true,
      semanticLabel: semanticLabel ?? label,
      child: buttonBody,
    );
  }
}

/// Interactive selectable chip built on [GlassSurface].
class GlassChip extends StatelessWidget {
  /// Creates a [GlassChip].
  const GlassChip({
    required this.label,
    this.selected = false,
    this.onTap,
    this.leadingIcon,
    super.key,
  });

  /// Chip text label.
  final String label;

  /// Whether this chip is currently selected.
  final bool selected;

  /// Tap callback.
  final VoidCallback? onTap;

  /// Optional leading icon.
  final IconData? leadingIcon;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = tokens.colors;

    final fg = selected ? Colors.white : colors.textPrimary;

    return PressScaleContainer(
      onTap: onTap,
      hapticSelectionClick: true,
      semanticButton: onTap != null,
      semanticLabel: label,
      child: AnimatedContainer(
        duration: tokens.motion.fast,
        curve: tokens.motion.standardCurve,
        padding: EdgeInsets.symmetric(
          horizontal: tokens.spacing.md,
          vertical: tokens.spacing.xs,
        ),
        decoration: BoxDecoration(
          borderRadius: tokens.radii.borderFull,
          color: selected
              ? colors.primaryEmerald
              : colors.surfaceGlassTint.withValues(alpha: 0.22),
          border: Border.all(
            color: selected ? colors.emeraldLight : colors.borderSubtle,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (leadingIcon != null) ...<Widget>[
              Icon(leadingIcon, size: 15, color: fg),
              SizedBox(width: tokens.spacing.xxs + 2),
            ],
            Flexible(
              child: Text(
                label,
                style: tokens.typography.label.copyWith(color: fg),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Segmented control with a sliding pill indicator and selection haptic tick.
class GlassSegmentedControl<T> extends StatelessWidget {
  /// Creates a [GlassSegmentedControl].
  const GlassSegmentedControl({
    required this.segments,
    required this.selectedValue,
    required this.onValueChanged,
    super.key,
  });

  /// Ordered map of segment values to display labels.
  final Map<T, String> segments;

  /// Currently selected value.
  final T selectedValue;

  /// Callback invoked when the user selects a segment.
  final ValueChanged<T> onValueChanged;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = tokens.colors;
    final entries = segments.entries.toList(growable: false);

    return GlassSurface(
      radius: tokens.radii.full,
      enableBlur: false,
      padding: EdgeInsets.all(tokens.spacing.xxs),
      child: Row(
        children: entries
            .map((MapEntry<T, String> entry) {
              final isSelected = entry.key == selectedValue;
              return Expanded(
                child: PressScaleContainer(
                  onTap: () => onValueChanged(entry.key),
                  hapticSelectionClick: true,
                  semanticButton: true,
                  semanticLabel: entry.value,
                  child: AnimatedContainer(
                    duration: tokens.motion.normal,
                    curve: tokens.motion.emphasizedCurve,
                    padding: EdgeInsets.symmetric(
                      vertical: tokens.spacing.xs,
                      horizontal: tokens.spacing.xs,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: tokens.radii.borderFull,
                      color: isSelected
                          ? colors.primaryEmerald
                          : Colors.transparent,
                    ),
                    child: Text(
                      entry.value,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: tokens.typography.label.copyWith(
                        color: isSelected ? Colors.white : colors.textSecondary,
                        fontWeight: isSelected
                            ? FontWeight.w700
                            : FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              );
            })
            .toList(growable: false),
      ),
    );
  }
}

/// Frosted search input bar with clear button and Bangla placeholder support.
class GlassSearchBar extends StatelessWidget {
  /// Creates a [GlassSearchBar].
  const GlassSearchBar({
    required this.hintText,
    this.controller,
    this.onChanged,
    this.onClear,
    super.key,
  });

  /// Placeholder hint text.
  final String hintText;

  /// Optional text controller.
  final TextEditingController? controller;

  /// Text change callback.
  final ValueChanged<String>? onChanged;

  /// Clear button callback.
  final VoidCallback? onClear;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = tokens.colors;

    return GlassSurface(
      radius: tokens.radii.full,
      enableBlur: false,
      padding: EdgeInsets.symmetric(
        horizontal: tokens.spacing.md,
        vertical: tokens.spacing.xxs,
      ),
      child: Row(
        children: <Widget>[
          Icon(Icons.search_rounded, size: 20, color: colors.primaryEmerald),
          SizedBox(width: tokens.spacing.sm),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              style: tokens.typography.bodyMedium.copyWith(
                color: colors.textPrimary,
              ),
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: tokens.typography.bodyMedium.copyWith(
                  color: colors.textMuted,
                ),
              ),
            ),
          ),
          if (onClear != null)
            IconButton(
              onPressed: onClear,
              icon: Icon(
                Icons.close_rounded,
                size: 18,
                color: colors.textMuted,
              ),
              visualDensity: VisualDensity.compact,
              tooltip: 'Clear',
            ),
        ],
      ),
    );
  }
}

/// Structured list item tile built on [GlassCard] with leading icon badge,
/// title, subtitle, and trailing widget.
class GlassListTile extends StatelessWidget {
  /// Creates a [GlassListTile].
  const GlassListTile({
    required this.title,
    this.subtitle,
    this.leadingIcon,
    this.trailing,
    this.onTap,
    this.heroTag,
    super.key,
  });

  /// Primary title text.
  final String title;

  /// Optional subtitle text.
  final String? subtitle;

  /// Optional leading icon.
  final IconData? leadingIcon;

  /// Optional trailing widget (defaults to chevron when [onTap] is provided).
  final Widget? trailing;

  /// Tap callback.
  final VoidCallback? onTap;

  /// Optional Hero tag for shared-element transitions.
  final Object? heroTag;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = tokens.colors;

    return GlassCard(
      onTap: onTap,
      heroTag: heroTag,
      padding: EdgeInsets.symmetric(
        horizontal: tokens.spacing.md,
        vertical: tokens.spacing.sm + 2,
      ),
      child: Row(
        children: <Widget>[
          if (leadingIcon != null) ...<Widget>[
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: colors.primaryEmerald.withValues(alpha: 0.15),
                borderRadius: tokens.radii.borderSm,
              ),
              child: Icon(leadingIcon, color: colors.primaryEmerald, size: 22),
            ),
            SizedBox(width: tokens.spacing.md),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(title, style: tokens.typography.titleMedium),
                if (subtitle != null) ...<Widget>[
                  SizedBox(height: tokens.spacing.xxs),
                  Text(subtitle!, style: tokens.typography.bodyMedium),
                ],
              ],
            ),
          ),
          if (trailing != null) ...<Widget>[
            SizedBox(width: tokens.spacing.sm),
            trailing!,
          ] else if (onTap != null) ...<Widget>[
            SizedBox(width: tokens.spacing.sm),
            Icon(Icons.chevron_right_rounded, color: colors.textMuted),
          ],
        ],
      ),
    );
  }
}

/// Modal bottom sheet container built on [GlassSurface] with a top drag handle.
class GlassBottomSheet extends StatelessWidget {
  /// Creates a [GlassBottomSheet].
  const GlassBottomSheet({required this.title, required this.child, super.key});

  /// Sheet header title.
  final String title;

  /// Sheet body widget.
  final Widget child;

  /// Shows a modal [GlassBottomSheet] with a blurred backdrop.
  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    required Widget child,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext ctx) =>
          GlassBottomSheet(title: title, child: child),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = tokens.colors;

    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.all(tokens.spacing.sm),
        child: GlassSurface(
          radius: tokens.radii.lg,
          borderGlow: true,
          padding: EdgeInsets.all(tokens.spacing.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: colors.textMuted.withValues(alpha: 0.4),
                    borderRadius: tokens.radii.borderFull,
                  ),
                ),
              ),
              SizedBox(height: tokens.spacing.md),
              Text(
                title,
                textAlign: TextAlign.center,
                style: tokens.typography.titleLarge,
              ),
              SizedBox(height: tokens.spacing.md),
              Flexible(child: SingleChildScrollView(child: child)),
            ],
          ),
        ),
      ),
    );
  }
}

/// Modal dialog built on [GlassSurface] with primary and secondary actions.
class GlassDialog extends StatelessWidget {
  /// Creates a [GlassDialog].
  const GlassDialog({
    required this.title,
    required this.message,
    required this.confirmLabel,
    this.cancelLabel,
    this.onConfirm,
    this.onCancel,
    super.key,
  });

  /// Dialog title.
  final String title;

  /// Dialog body message.
  final String message;

  /// Primary confirmation button label.
  final String confirmLabel;

  /// Optional cancel button label.
  final String? cancelLabel;

  /// Primary confirm callback.
  final VoidCallback? onConfirm;

  /// Cancel callback.
  final VoidCallback? onCancel;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: EdgeInsets.all(tokens.spacing.lg),
      child: GlassSurface(
        radius: tokens.radii.lg,
        borderGlow: true,
        padding: EdgeInsets.all(tokens.spacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              title,
              textAlign: TextAlign.center,
              style: tokens.typography.titleLarge,
            ),
            SizedBox(height: tokens.spacing.sm),
            Text(
              message,
              textAlign: TextAlign.center,
              style: tokens.typography.bodyMedium,
            ),
            SizedBox(height: tokens.spacing.lg),
            Row(
              children: <Widget>[
                if (cancelLabel != null) ...<Widget>[
                  Expanded(
                    child: GlassButton(
                      label: cancelLabel!,
                      variant: GlassButtonVariant.secondary,
                      onPressed: onCancel ?? () => Navigator.of(context).pop(),
                    ),
                  ),
                  SizedBox(width: tokens.spacing.sm),
                ],
                Expanded(
                  child: GlassButton(
                    label: confirmLabel,
                    onPressed: onConfirm ?? () => Navigator.of(context).pop(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
