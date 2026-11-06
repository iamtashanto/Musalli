import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:musalli/core/design_system/components/glass_components.dart';
import 'package:musalli/core/design_system/tokens/design_tokens.dart';
import 'package:musalli/features/kids/domain/kids_models.dart';
import 'package:musalli/features/kids/domain/kids_service.dart';

/// Modal dialog requiring parent verification via an arithmetic problem in Bengali digits.
class ParentGateDialog extends StatefulWidget {
  const ParentGateDialog({
    super.key,
    required this.onVerified,
    this.titleBn = 'অভিভাবক প্রবেশদ্বার 🛡️',
  });

  final VoidCallback onVerified;
  final String titleBn;

  @override
  State<ParentGateDialog> createState() => _ParentGateDialogState();
}

class _ParentGateDialogState extends State<ParentGateDialog> {
  late final KidsService _kidsService;
  late MathGateChallenge _challenge;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _kidsService = const KidsService();
    _generateNewChallenge();
  }

  void _generateNewChallenge() {
    setState(() {
      _challenge = _kidsService.generateMathChallenge();
      _errorMessage = null;
    });
  }

  void _verifyOption(int index) {
    if (index == _challenge.correctIndex) {
      unawaited(HapticFeedback.lightImpact());
      Navigator.of(context).pop();
      widget.onVerified();
    } else {
      unawaited(HapticFeedback.heavyImpact());
      setState(() {
        _errorMessage = 'ভুল উত্তর! অনুগ্রহ করে সঠিক উত্তর দিন।';
        _generateNewChallenge();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = tokens.colors;
    final typography = tokens.typography;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.all(tokens.spacing.md),
      child: GlassCard(
        padding: EdgeInsets.all(tokens.spacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.lock_outline,
                  color: Color(0xFFF59E0B),
                  size: 24,
                ),
                SizedBox(width: tokens.spacing.xs),
                Expanded(
                  child: Text(
                    widget.titleBn,
                    style: typography.titleMedium.copyWith(
                      color: colors.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: tokens.spacing.xs),
            Text(
              'এই অংশে প্রবেশের জন্য নিচের গাণিতিক সমস্যাটির উত্তর দিন:',
              style: typography.bodyMedium.copyWith(
                color: colors.textSecondary,
              ),
            ),
            SizedBox(height: tokens.spacing.md),

            // Math Question Box
            Container(
              padding: EdgeInsets.all(tokens.spacing.md),
              decoration: BoxDecoration(
                color: colors.surfaceGlassTint,
                borderRadius: tokens.radii.borderMd,
                border: Border.all(color: colors.borderSubtle),
              ),
              child: Text(
                _challenge.promptBn,
                textAlign: TextAlign.center,
                style: typography.display.copyWith(
                  color: const Color(0xFF10B981),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            if (_errorMessage != null) ...[
              SizedBox(height: tokens.spacing.xs),
              Text(
                _errorMessage!,
                textAlign: TextAlign.center,
                style: typography.label.copyWith(
                  color: const Color(0xFFEF4444),
                ),
              ),
            ],

            SizedBox(height: tokens.spacing.md),

            // Options
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: _challenge.optionsBn.asMap().entries.map((entry) {
                final idx = entry.key;
                final opt = entry.value;

                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: tokens.spacing.xxs,
                    ),
                    child: ElevatedButton(
                      onPressed: () => _verifyOption(idx),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colors.surfaceGlassTint,
                        foregroundColor: colors.textPrimary,
                        padding: EdgeInsets.symmetric(
                          vertical: tokens.spacing.sm,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: tokens.radii.borderMd,
                          side: BorderSide(color: colors.borderSubtle),
                        ),
                      ),
                      child: Text(
                        opt,
                        style: typography.titleMedium.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: tokens.spacing.md),

            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'বাতিল করুন',
                style: typography.label.copyWith(color: colors.textSecondary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
