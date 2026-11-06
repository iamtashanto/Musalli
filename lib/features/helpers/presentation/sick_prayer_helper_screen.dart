import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:musalli/core/design_system/components/content_components.dart';
import 'package:musalli/core/design_system/components/glass_components.dart';
import 'package:musalli/core/design_system/components/glass_navigation.dart';
import 'package:musalli/core/design_system/tokens/design_tokens.dart';
import 'package:musalli/features/helpers/domain/decision_tree.dart';
import 'package:musalli/features/helpers/domain/sick_prayer_tree.dart';

/// Interactive helper screen for "আমি কীভাবে নামাজ পড়ব?" (Sick Prayer Assistant).
class SickPrayerHelperScreen extends StatefulWidget {
  const SickPrayerHelperScreen({super.key});

  @override
  State<SickPrayerHelperScreen> createState() => _SickPrayerHelperScreenState();
}

class _SickPrayerHelperScreenState extends State<SickPrayerHelperScreen> {
  final List<String> _history = [SickPrayerDecisionTree.rootNodeId];
  DecisionResult? _currentResult;

  void _onSelectOption(DecisionOption option) {
    unawaited(HapticFeedback.selectionClick());
    setState(() {
      if (option.result != null) {
        _currentResult = option.result;
      } else if (option.nextNodeId != null) {
        _history.add(option.nextNodeId!);
      }
    });
  }

  void _onBack() {
    unawaited(HapticFeedback.selectionClick());
    setState(() {
      if (_currentResult != null) {
        _currentResult = null;
      } else if (_history.length > 1) {
        _history.removeLast();
      }
    });
  }

  void _onReset() {
    unawaited(HapticFeedback.mediumImpact());
    setState(() {
      _history
        ..clear()
        ..add(SickPrayerDecisionTree.rootNodeId);
      _currentResult = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = tokens.colors;
    final typography = tokens.typography;

    final currentNodeId = _history.last;
    final currentNode = SickPrayerDecisionTree.getNode(currentNodeId);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: CustomScrollView(
        slivers: <Widget>[
          GlassSliverAppBar(
            title: 'আমি কীভাবে নামাজ পড়ব?',
            leading: _history.length > 1 || _currentResult != null
                ? IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
                    tooltip: 'পূর্ববর্তী ধাপ',
                    onPressed: _onBack,
                  )
                : IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
                    tooltip: 'ফিরে যান',
                    onPressed: () => Navigator.of(context).maybePop(),
                  ),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.refresh_rounded),
                tooltip: 'পুনরায় শুরু করুন',
                onPressed: _onReset,
              ),
            ],
          ),

          SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: tokens.spacing.md,
              vertical: tokens.spacing.sm,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
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
                          Icons.accessibility_new_rounded,
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
                              'অসুস্থ ব্যক্তির নামাজ নির্দেশিকা',
                              style: typography.titleMedium.copyWith(
                                fontWeight: FontWeight.bold,
                                color: colors.textPrimary,
                              ),
                            ),
                            Text(
                              'আপনার শারীরিক সক্ষমতা অনুযায়ী হানাফি ফিকহের সঠিক নিয়ম জেনে নিন।',
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

                if (_currentResult != null)
                  _buildResultCard(context, _currentResult!)
                else if (currentNode != null)
                  _buildQuestionCard(context, currentNode),

                SizedBox(height: tokens.spacing.xl),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionCard(BuildContext context, DecisionNode node) {
    final tokens = context.tokens;
    final colors = tokens.colors;
    final typography = tokens.typography;

    return Semantics(
      label: 'প্রশ্ন: ${node.question}',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            node.question,
            style: typography.titleLarge.copyWith(
              fontWeight: FontWeight.bold,
              color: colors.textPrimary,
            ),
          ),
          if (node.hint.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              node.hint,
              style: typography.bodyMedium.copyWith(
                color: colors.textSecondary,
              ),
            ),
          ],
          SizedBox(height: tokens.spacing.md),

          ...node.options.map((option) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: GlassCard(
                onTap: () => _onSelectOption(option),
                padding: EdgeInsets.all(tokens.spacing.md),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            option.label,
                            style: typography.titleMedium.copyWith(
                              fontWeight: FontWeight.w600,
                              color: colors.textPrimary,
                            ),
                          ),
                          if (option.description.isNotEmpty) ...[
                            const SizedBox(height: 2),
                            Text(
                              option.description,
                              style: typography.bodyMedium.copyWith(
                                color: colors.textSecondary,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 16,
                      color: colors.primaryEmerald,
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildResultCard(BuildContext context, DecisionResult result) {
    final tokens = context.tokens;
    final colors = tokens.colors;
    final typography = tokens.typography;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        GlassCard(
          borderGlow: true,
          padding: EdgeInsets.all(tokens.spacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: colors.primaryEmerald.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(tokens.radii.full),
                  border: Border.all(
                    color: colors.primaryEmerald.withValues(alpha: 0.4),
                  ),
                ),
                child: Text(
                  result.verdict,
                  style: typography.label.copyWith(
                    color: colors.primaryEmerald,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              SizedBox(height: tokens.spacing.md),

              Text(
                result.title,
                style: typography.titleLarge.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colors.textPrimary,
                ),
              ),

              SizedBox(height: tokens.spacing.sm),

              Text(
                result.explanation,
                style: typography.bodyMedium.copyWith(
                  color: colors.textSecondary,
                  height: 1.5,
                ),
              ),

              if (result.actionSteps.isNotEmpty) ...[
                SizedBox(height: tokens.spacing.md),
                Text(
                  'আদায়ের পদ্ধতি:',
                  style: typography.titleMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colors.textPrimary,
                  ),
                ),
                const SizedBox(height: 6),
                ...result.actionSteps.map(
                  (step) => Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 4, right: 8),
                          child: Icon(
                            Icons.check_circle_rounded,
                            size: 16,
                            color: colors.primaryEmerald,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            step,
                            style: typography.bodyMedium.copyWith(
                              color: colors.textPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],

              if (result.reference.isNotEmpty) ...[
                SizedBox(height: tokens.spacing.md),
                Align(
                  alignment: Alignment.centerLeft,
                  child: ReferenceChip(citation: result.reference),
                ),
              ],
            ],
          ),
        ),

        SizedBox(height: tokens.spacing.lg),

        GlassButton(
          label: 'আবার পরীক্ষা করুন',
          icon: Icons.refresh_rounded,
          variant: GlassButtonVariant.secondary,
          isExpanded: true,
          onPressed: _onReset,
        ),
      ],
    );
  }
}
