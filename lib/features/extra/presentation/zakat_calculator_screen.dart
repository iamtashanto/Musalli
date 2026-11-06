import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musalli/core/design_system/components/glass_components.dart';
import 'package:musalli/core/design_system/tokens/design_tokens.dart';
import 'package:musalli/core/utils/bengali_numbers.dart';

class ZakatCalculatorScreen extends ConsumerStatefulWidget {
  const ZakatCalculatorScreen({super.key});

  @override
  ConsumerState<ZakatCalculatorScreen> createState() => _ZakatCalculatorScreenState();
}

class _ZakatCalculatorScreenState extends ConsumerState<ZakatCalculatorScreen> {
  // Nisab defaults in BDT (indicative values based on 52.5 tola silver or 7.5 tola gold)
  // Silver Nisab ~ 595 grams * 180 BDT ~ 107,100 BDT
  // Gold Nisab ~ 87.48 grams * 11,500 BDT ~ 1,006,000 BDT
  double _silverPricePerGram = 180.0;
  
  // Asset controllers
  final _cashController = TextEditingController();
  final _bankController = TextEditingController();
  final _goldGramsController = TextEditingController();
  final _goldRateController = TextEditingController(text: '11500');
  final _silverGramsController = TextEditingController();
  final _businessStockController = TextEditingController();
  final _investmentsController = TextEditingController();
  final _loansGivenController = TextEditingController();

  // Deductions / Liabilities
  final _immediateDebtsController = TextEditingController();
  final _dueExpensesController = TextEditingController();

  bool _useSilverNisab = true; // Hanafi recommendation: silver nisab for greater benefit to the poor

  @override
  void dispose() {
    _cashController.dispose();
    _bankController.dispose();
    _goldGramsController.dispose();
    _goldRateController.dispose();
    _silverGramsController.dispose();
    _businessStockController.dispose();
    _investmentsController.dispose();
    _loansGivenController.dispose();
    _immediateDebtsController.dispose();
    _dueExpensesController.dispose();
    super.dispose();
  }

  double _parse(TextEditingController c) => double.tryParse(c.text.replaceAll(',', '')) ?? 0.0;

  double get _silverNisabThreshold => 595.0 * _silverPricePerGram; // 52.5 tola ~ 595g
  double get _goldNisabThreshold => 87.48 * (_parse(_goldRateController) > 0 ? _parse(_goldRateController) : 11500);

  double get _currentNisab => _useSilverNisab ? _silverNisabThreshold : _goldNisabThreshold;

  double get _totalAssets {
    final cash = _parse(_cashController);
    final bank = _parse(_bankController);
    final gold = _parse(_goldGramsController) * (_parse(_goldRateController) > 0 ? _parse(_goldRateController) : 11500);
    final silver = _parse(_silverGramsController) * _silverPricePerGram;
    final stock = _parse(_businessStockController);
    final inv = _parse(_investmentsController);
    final loans = _parse(_loansGivenController);
    return cash + bank + gold + silver + stock + inv + loans;
  }

  double get _totalLiabilities {
    final debts = _parse(_immediateDebtsController);
    final expenses = _parse(_dueExpensesController);
    return debts + expenses;
  }

  double get _netZakatableWealth {
    final net = _totalAssets - _totalLiabilities;
    return net > 0 ? net : 0;
  }

  bool get _isZakatDue => _netZakatableWealth >= _currentNisab;

  double get _zakatAmount => _isZakatDue ? _netZakatableWealth * 0.025 : 0.0;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;

    return Scaffold(
      backgroundColor: tokens.colors.backgroundStart,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'যাকাত ক্যালকুলেটর',
          style: tokens.typography.titleLarge.copyWith(fontWeight: FontWeight.w700),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(tokens.spacing.md),
        children: [
          // Nisab Indicator Card
          GlassCard(
            enableBlur: true,
            borderGlow: _isZakatDue,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'নিসাবের ভিত্তি',
                      style: tokens.typography.titleMedium.copyWith(fontWeight: FontWeight.w700),
                    ),
                    Row(
                      children: [
                        ChoiceChip(
                          label: const Text('রুপা (অগ্রগণ্য)'),
                          selected: _useSilverNisab,
                          selectedColor: tokens.colors.primaryEmerald.withAlpha(51),
                          onSelected: (val) => setState(() => _useSilverNisab = true),
                        ),
                        SizedBox(width: tokens.spacing.xs),
                        ChoiceChip(
                          label: const Text('স্বর্ণ'),
                          selected: !_useSilverNisab,
                          selectedColor: tokens.colors.primaryEmerald.withAlpha(51),
                          onSelected: (val) => setState(() => _useSilverNisab = false),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: tokens.spacing.sm),
                Text(
                  'বর্তমান নিসাব সীমা: ৳ ${BengaliNumberFormatter.toBengali(_currentNisab.toStringAsFixed(0))}',
                  style: tokens.typography.bodyMedium.copyWith(color: tokens.colors.textSecondary),
                ),
                SizedBox(height: tokens.spacing.md),
                Container(
                  padding: EdgeInsets.all(tokens.spacing.md),
                  decoration: BoxDecoration(
                    color: _isZakatDue
                        ? tokens.colors.primaryEmerald.withAlpha(30)
                        : tokens.colors.surfaceGlassTint,
                    borderRadius: BorderRadius.circular(tokens.radii.md),
                    border: Border.all(
                      color: _isZakatDue
                          ? tokens.colors.primaryEmerald
                          : tokens.colors.borderSubtle,
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        _isZakatDue ? 'আপনার প্রদেয় যাকাত (২.৫%)' : 'যাকাত ফরজ হওয়ার সীমার নিচে',
                        style: tokens.typography.label.copyWith(
                          color: _isZakatDue
                              ? tokens.colors.primaryEmerald
                              : tokens.colors.textSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: tokens.spacing.xs),
                      Text(
                        '৳ ${BengaliNumberFormatter.toBengali(_zakatAmount.toStringAsFixed(2))}',
                        style: tokens.typography.display.copyWith(
                          color: _isZakatDue
                              ? tokens.colors.primaryEmerald
                              : tokens.colors.textPrimary,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(height: tokens.spacing.xs),
                      Text(
                        'মোট যাকাতযোগ্য সম্পদ: ৳ ${BengaliNumberFormatter.toBengali(_netZakatableWealth.toStringAsFixed(0))}',
                        style: tokens.typography.bodySmall.copyWith(
                          color: tokens.colors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: tokens.spacing.lg),
          Text(
            '১. যাকাতযোগ্য সম্পদসমূহ (টাকা)',
            style: tokens.typography.titleMedium.copyWith(fontWeight: FontWeight.w700),
          ),
          SizedBox(height: tokens.spacing.sm),

          _buildInputTile('হাতে থাকা নগদ অর্থ', _cashController),
          _buildInputTile('ব্যাংকে জমা টাকা', _bankController),
          _buildInputTile('ব্যবসার পণ্য বা মালের মূল্য', _businessStockController),
          _buildInputTile('বিনিয়োগ, শেয়ার বা প্রাইজবন্ড', _investmentsController),
          _buildInputTile('পাওনা টাকা (যা উশুলযোগ্য)', _loansGivenController),
          
          SizedBox(height: tokens.spacing.md),
          Text(
            'স্বর্ণ ও রুপা',
            style: tokens.typography.bodyLarge.copyWith(fontWeight: FontWeight.w600),
          ),
          SizedBox(height: tokens.spacing.xs),
          Row(
            children: [
              Expanded(
                child: _buildInputTile('স্বর্ণ (গ্রাম)', _goldGramsController),
              ),
              SizedBox(width: tokens.spacing.sm),
              Expanded(
                child: _buildInputTile('স্বর্ণের দর/গ্রাম', _goldRateController),
              ),
            ],
          ),
          _buildInputTile('রুপা (গ্রাম)', _silverGramsController),

          SizedBox(height: tokens.spacing.lg),
          Text(
            '২. প্রদেয় দায় বা ঋণ (বাদ যাবে)',
            style: tokens.typography.titleMedium.copyWith(
              fontWeight: FontWeight.w700,
              color: tokens.colors.wajibColor,
            ),
          ),
          SizedBox(height: tokens.spacing.sm),

          _buildInputTile('অবিলম্বে পরিশোধযোগ্য দেনা বা ঋণ', _immediateDebtsController),
          _buildInputTile('বকেয়া বিল, বেতন ও খরচ', _dueExpensesController),

          SizedBox(height: tokens.spacing.lg),
          // Rules & Disclaimer Note
          Container(
            padding: EdgeInsets.all(tokens.spacing.md),
            decoration: BoxDecoration(
              color: tokens.colors.surfaceGlassTint,
              borderRadius: BorderRadius.circular(tokens.radii.md),
              border: Border.all(color: tokens.colors.borderSubtle),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '💡 যাকাত সম্পর্কিত আবশ্যকীয় নিয়মাবলি:',
                  style: tokens.typography.titleSmall.copyWith(fontWeight: FontWeight.w700),
                ),
                SizedBox(height: tokens.spacing.xs),
                Text(
                  '• নিসাব পরিমাণ সম্পদের মালিকানা পূর্ণ এক চন্দ্রবছর (হিজরি বর্ষ) স্থায়ী হলে তার ওপর ২.৫% যাকাত আবশ্যক হয়।\n'
                  '• মৌলিক মানবিক প্রয়োজন (যেমন থাকার বাড়ি, পরনের কাপড়, নিত্য ব্যবহার্য আসবাব ও গাড়ি) যাকাতমুক্ত।\n'
                  '• জটিল কোনো শরয়ি মাসআলায় স্থানীয় বিজ্ঞ মুফতির পরামর্শ নিন।',
                  style: tokens.typography.bodySmall.copyWith(color: tokens.colors.textSecondary, height: 1.5),
                ),
              ],
            ),
          ),
          SizedBox(height: tokens.spacing.xl),
        ],
      ),
    );
  }

  Widget _buildInputTile(String label, TextEditingController controller) {
    final tokens = context.tokens;
    return Padding(
      padding: EdgeInsets.only(bottom: tokens.spacing.sm),
      child: GlassCard(
        enableBlur: false,
        padding: EdgeInsets.symmetric(horizontal: tokens.spacing.md, vertical: tokens.spacing.xs),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: tokens.typography.bodyMedium.copyWith(fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(width: tokens.spacing.sm),
            SizedBox(
              width: 120,
              child: TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.right,
                style: tokens.typography.bodyLarge.copyWith(fontWeight: FontWeight.w700),
                decoration: InputDecoration(
                  hintText: '০',
                  hintStyle: tokens.typography.bodyLarge.copyWith(color: tokens.colors.textSecondary.withAlpha(100)),
                  border: InputBorder.none,
                ),
                onChanged: (_) => setState(() {}),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
