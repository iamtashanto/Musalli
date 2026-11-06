import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musalli/core/design_system/components/content_components.dart';
import 'package:musalli/core/design_system/components/glass_components.dart';
import 'package:musalli/core/design_system/components/glass_navigation.dart';
import 'package:musalli/core/design_system/tokens/design_tokens.dart';
import 'package:musalli/features/content/presentation/providers/content_providers.dart';
import 'package:musalli/shared/content/content.dart';

/// Interactive vertical timeline screen for 58 Islamic History events across 10 eras.
class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({super.key});

  @override
  ConsumerState<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen> {
  String _selectedEraId = 'all';

  void _onSelectEra(String eraId) {
    unawaited(HapticFeedback.selectionClick());
    setState(() => _selectedEraId = eraId);
  }

  void _onOpenEventDetail(BuildContext context, ContentHistoryEvent event) {
    unawaited(HapticFeedback.lightImpact());
    final tokens = context.tokens;
    final colors = tokens.colors;
    final typography = tokens.typography;

    unawaited(
      showModalBottomSheet<void>(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (ctx) {
          return Container(
            padding: EdgeInsets.all(tokens.spacing.lg),
            decoration: BoxDecoration(
              color: colors.surfaceLowRamFallback,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(tokens.radii.lg),
              ),
              border: Border.all(color: colors.borderSubtle),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Handle pill
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: colors.borderSubtle,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                SizedBox(height: tokens.spacing.md),

                // Year and Tag
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: colors.primaryEmerald.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(tokens.radii.full),
                      ),
                      child: Text(
                        event.year,
                        style: typography.label.copyWith(
                          color: colors.primaryEmerald,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

              SizedBox(height: tokens.spacing.sm),

              Text(
                event.titleBn,
                style: typography.titleLarge.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colors.textPrimary,
                ),
              ),

              SizedBox(height: tokens.spacing.sm),

              Text(
                event.descriptionBn,
                style: typography.bodyMedium.copyWith(
                  color: colors.textPrimary,
                  height: 1.5,
                ),
              ),

              if (event.significanceBn != null &&
                  event.significanceBn!.isNotEmpty) ...[
                SizedBox(height: tokens.spacing.md),
                Callout(
                  title: 'ঐতিহাসিক গুরুত্ব ও তাৎপর্য',
                  message: event.significanceBn!,
                  variant: CalloutVariant.reference,
                ),
              ],

              SizedBox(height: tokens.spacing.lg),

              GlassButton(
                label: 'বন্ধ করুন',
                variant: GlassButtonVariant.secondary,
                isExpanded: true,
                onPressed: () => Navigator.of(ctx).pop(),
              ),

              SizedBox(height: tokens.spacing.md),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = tokens.colors;
    final typography = tokens.typography;

    final historyAsync = ref.watch(historyErasProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: CustomScrollView(
        slivers: <Widget>[
          const GlassSliverAppBar(title: 'ইসলামের সোনালী ইতিহাস'),

          SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: tokens.spacing.md,
              vertical: tokens.spacing.sm,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Guidance Box
                GlassCard(
                  padding: EdgeInsets.all(tokens.spacing.md),
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: colors.primaryEmerald.withValues(alpha: 0.12),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.hourglass_top_rounded,
                          color: colors.primaryEmerald,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: tokens.spacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '৫৮টি অবিস্মরণীয় ঐতিহাসিক ঘটনা',
                              style: typography.titleMedium.copyWith(
                                fontWeight: FontWeight.bold,
                                color: colors.textPrimary,
                              ),
                            ),
                            Text(
                              'রাসূলুল্লাহ (সা.)-এর নবুওয়াত থেকে আধুনিক যুগ পর্যন্ত কালানুক্রমিক টাইমলাইন।',
                              style: typography.bodyMedium.copyWith(
                                color: colors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: tokens.spacing.md),

                // Era Filter Chips
                historyAsync.when(
                  loading: () => const SizedBox.shrink(),
                  error: (err, _) => const SizedBox.shrink(),
                  data: (eras) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 6),
                            child: GlassChip(
                              label: 'সকল যুগ',
                              selected: _selectedEraId == 'all',
                              onTap: () => _onSelectEra('all'),
                            ),
                          ),
                          ...eras.map((era) {
                            final isSelected = _selectedEraId == era.id;
                            return Padding(
                              padding: const EdgeInsets.only(right: 6),
                              child: GlassChip(
                                label: '${era.icon ?? "📖"} ${era.nameBn}',
                                selected: isSelected,
                                onTap: () => _onSelectEra(era.id),
                              ),
                            );
                          }),
                        ],
                      ),
                    );
                  },
                ),

                SizedBox(height: tokens.spacing.md),

                // Timeline Events
                historyAsync.when(
                  loading: () => const GlassShimmerLoader(height: 250),
                  error: (err, _) => Text('ত্রুটি: $err'),
                  data: (eras) {
                    // Extract all events matching selected era
                    final matchingEras = _selectedEraId == 'all'
                        ? eras
                        : eras.where((e) => e.id == _selectedEraId).toList();

                    final eventsWithEra =
                        <(ContentHistoryEra, ContentHistoryEvent)>[];
                    for (final era in matchingEras) {
                      for (final event in era.events) {
                        eventsWithEra.add((era, event));
                      }
                    }

                    if (eventsWithEra.isEmpty) {
                      return const Center(
                        child: EmptyState(
                          title: 'কোনো ঘটনা পাওয়া যায়নি',
                          message: 'অন্য যুগ নির্বাচন করুন।',
                        ),
                      );
                    }

                    return Column(
                      children: eventsWithEra.asMap().entries.map((entry) {
                        final idx = entry.key;
                        final (era, event) = entry.value;
                        final isLast = idx == eventsWithEra.length - 1;

                        return IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              // Vertical Line & Dot
                              Column(
                                children: <Widget>[
                                  Container(
                                    width: 14,
                                    height: 14,
                                    decoration: BoxDecoration(
                                      color: colors.primaryEmerald,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                  if (!isLast)
                                    Expanded(
                                      child: Container(
                                        width: 2,
                                        color: colors.primaryEmerald.withValues(
                                          alpha: 0.35,
                                        ),
                                      ),
                                    ),
                                ],
                              ),

                              SizedBox(width: tokens.spacing.md),

                              // Event Card
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: GlassCard(
                                    onTap: () =>
                                        _onOpenEventDetail(context, event),
                                    padding: EdgeInsets.all(tokens.spacing.md),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              event.year,
                                              style: typography.label.copyWith(
                                                color: colors.primaryEmerald,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              era.nameBn,
                                              style: typography.label.copyWith(
                                                color: colors.textSecondary,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          event.titleBn,
                                          style: typography.titleMedium
                                              .copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: colors.textPrimary,
                                              ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          event.descriptionBn,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: typography.bodyMedium.copyWith(
                                            color: colors.textSecondary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),

                SizedBox(height: tokens.spacing.xl),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
