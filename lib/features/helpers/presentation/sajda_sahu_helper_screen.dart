import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:musalli/core/design_system/components/content_components.dart';
import 'package:musalli/core/design_system/components/glass_components.dart';
import 'package:musalli/core/design_system/components/glass_navigation.dart';
import 'package:musalli/core/design_system/tokens/design_tokens.dart';
import 'package:musalli/features/helpers/domain/decision_tree.dart';
import 'package:musalli/features/helpers/domain/sajda_sahu_tree.dart';

/// Interactive helper screen for "আমার কী ভুল হয়েছে?" (Sajda Sahu Assistant).
class SajdaSahuHelperScreen extends StatefulWidget {
  const SajdaSahuHelperScreen({super.key});

  @override
  State<SajdaSahuHelperScreen> createState() => _SajdaSahuHelperScreenState();
}

class _SajdaSahuHelperScreenState extends State<SajdaSahuHelperScreen> {
  final List<String> _history = [SajdaSahuDecisionTree.rootNodeId];
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
        ..add(SajdaSahuDecisionTree.rootNodeId);
      _currentResult = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = tokens.colors;
    final typography = tokens.typography;

    final currentNodeId = _history.last;
    final currentNode = SajdaSahuDecisionTree.getNode(currentNodeId);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: CustomScrollView(
        slivers: <Widget>[
          GlassSliverAppBar(
            title: 'আমার কী ভুল হয়েছে?',
            leading: _history.length > 1 || _currentResult != null
                ? IconButton(
                    icon: const Icon(Icons.arrow_back_ios_rounded),
                    tooltip: 'পূর্ববর্তী ধাপ',
                    onPressed: _onBack,
                  )
                : null,
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
                // Header guidance card
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
                          Icons.help_outline_rounded,
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
                              'সাহু সিজদা সহকারী',
                              style: typography.titleMedium.copyWith(
                                fontWeight: FontWeight.bold,
                                color: colors.textPrimary,
                              ),
                            ),
                            Text(
                              'ধাপে ধাপে প্রশ্নের উত্তর দিয়ে জেনে নিন আপনার ভুলটির শরঈ সমাধান।',
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

                // Active question or final result
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
      label: 'ধাপ: ${node.question}',
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

          // Options list
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

    final badgeColor = result.invalidatesSalah
        ? colors.error
        : result.requiresSajdaSahu
        ? colors.goldAccent
        : colors.primaryEmerald;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        GlassCard(
          borderGlow: true,
          padding: EdgeInsets.all(tokens.spacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Status Badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: badgeColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(tokens.radii.full),
                  border: Border.all(color: badgeColor.withValues(alpha: 0.4)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      result.invalidatesSalah
                          ? Icons.cancel_outlined
                          : result.requiresSajdaSahu
                          ? Icons.warning_amber_rounded
                          : Icons.check_circle_outline_rounded,
                      color: badgeColor,
                      size: 16,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      result.verdict,
                      style: typography.label.copyWith(
                        color: badgeColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
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
                  'এখন যা করতে হবে:',
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
          label: 'আবার শুরু করুন',
          icon: Icons.refresh_rounded,
          variant: GlassButtonVariant.secondary,
          isExpanded: true,
          onPressed: _onReset,
        ),
      ],
    );
  }
}
