import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:musalli/core/design_system/components/glass_components.dart';
import 'package:musalli/core/design_system/tokens/design_tokens.dart';
import 'package:musalli/features/times/domain/models/location_item.dart';
import 'package:musalli/features/times/presentation/providers/times_providers.dart';

class DistrictPickerSheet extends ConsumerStatefulWidget {
  const DistrictPickerSheet({
    required this.currentLocation,
    required this.onSelectLocation,
    super.key,
  });

  final LocationItem currentLocation;
  final ValueChanged<LocationItem> onSelectLocation;

  @override
  ConsumerState<DistrictPickerSheet> createState() =>
      _DistrictPickerSheetState();
}

class _DistrictPickerSheetState extends ConsumerState<DistrictPickerSheet> {
  final TextEditingController _searchCtrl = TextEditingController();
  String _query = '';
  bool _isLocating = false;

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  Future<void> _handleGpsLocation() async {
    setState(() => _isLocating = true);

    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          if (mounted) {
            _showRationaleSnackbar('লোকেশন পারমিশন দেওয়া হয়নি।');
          }
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        if (mounted) {
          _showRationaleSnackbar('সেটিংস থেকে লোকেশন পারমিশন চালু করুন।');
        }
        return;
      }

      final pos = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.medium,
        ),
      );

      // Find closest district by distance
      final all = await ref.read(locationsRepositoryProvider).getAllLocations();
      LocationItem? closest;
      double minDistance = double.infinity;

      for (final loc in all) {
        final d = Geolocator.distanceBetween(
          pos.latitude,
          pos.longitude,
          loc.lat,
          loc.lng,
        );
        if (d < minDistance) {
          minDistance = d;
          closest = loc;
        }
      }

      if (closest != null && mounted) {
        widget.onSelectLocation(closest);
        Navigator.of(context).pop();
      }
    } catch (_) {
      if (mounted) {
        _showRationaleSnackbar(
          'অবস্থান নির্ণয় করা সম্ভব হয়নি। জেলা তালিকা থেকে নির্বাচন করুন।',
        );
      }
    } finally {
      if (mounted) setState(() => _isLocating = false);
    }
  }

  void _showRationaleSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final colors = tokens.colors;
    final typography = tokens.typography;

    final locationsAsync = ref.watch(allLocationsProvider);

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      padding: EdgeInsets.all(tokens.spacing.md),
      decoration: BoxDecoration(
        color: colors.backgroundMiddle,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Drag handle
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

          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'অবস্থান নির্বাচন করুন',
                style: typography.titleLarge.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colors.textPrimary,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close_rounded),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),

          SizedBox(height: tokens.spacing.sm),

          // Search Field
          TextField(
            controller: _searchCtrl,
            onChanged: (val) => setState(() => _query = val),
            style: typography.bodyLarge.copyWith(color: colors.textPrimary),
            decoration: InputDecoration(
              hintText: 'জেলা বা শহরের নাম লিখুন...',
              hintStyle: typography.bodyMedium.copyWith(
                color: colors.textMuted,
              ),
              prefixIcon: Icon(
                Icons.search_rounded,
                color: colors.primaryEmerald,
              ),
              filled: true,
              fillColor: colors.surfaceGlassTint,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              border: OutlineInputBorder(
                borderRadius: tokens.radii.borderMd,
                borderSide: BorderSide(color: colors.borderSubtle),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: tokens.radii.borderMd,
                borderSide: BorderSide(color: colors.borderSubtle),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: tokens.radii.borderMd,
                borderSide: BorderSide(color: colors.primaryEmerald),
              ),
            ),
          ),

          SizedBox(height: tokens.spacing.sm),

          // GPS Auto-detect Button
          GlassButton(
            label: _isLocating
                ? 'বর্তমান অবস্থান নির্ণয় হচ্ছে...'
                : 'বর্তমান অবস্থান নির্ণয় করুন (GPS)',
            icon: Icons.my_location_rounded,
            onPressed: _isLocating ? null : _handleGpsLocation,
          ),

          SizedBox(height: tokens.spacing.md),

          // Locations List
          Expanded(
            child: locationsAsync.when(
              loading: () => Center(
                child: CircularProgressIndicator(color: colors.primaryEmerald),
              ),
              error: (err, _) => Center(child: Text('Error: $err')),
              data: (locations) {
                final filtered = locations.where((loc) {
                  if (_query.trim().isEmpty) return true;
                  final q = _query.toLowerCase();
                  return loc.nameBn.toLowerCase().contains(q) ||
                      loc.nameEn.toLowerCase().contains(q) ||
                      (loc.divisionBn?.toLowerCase().contains(q) ?? false) ||
                      loc.countryBn.toLowerCase().contains(q);
                }).toList();

                if (filtered.isEmpty) {
                  return Center(
                    child: Text(
                      'কোনো জেলা বা শহর খুঁজে পাওয়া যায়নি।',
                      style: typography.bodyMedium.copyWith(
                        color: colors.textSecondary,
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final item = filtered[index];
                    final isSelected = item.id == widget.currentLocation.id;

                    return ListTile(
                      onTap: () {
                        widget.onSelectLocation(item);
                        Navigator.of(context).pop();
                      },
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      leading: Icon(
                        isSelected
                            ? Icons.check_circle_rounded
                            : Icons.location_city_rounded,
                        color: isSelected
                            ? colors.primaryEmerald
                            : colors.textSecondary,
                      ),
                      title: Text(
                        item.nameBn,
                        style: typography.bodyLarge.copyWith(
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.w500,
                          color: isSelected
                              ? colors.primaryEmerald
                              : colors.textPrimary,
                        ),
                      ),
                      subtitle: Text(
                        '${item.nameEn}${item.divisionBn != null ? ' • ${item.divisionBn} বিভাগ' : ''} • ${item.countryBn}',
                        style: typography.label.copyWith(
                          color: colors.textSecondary,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
