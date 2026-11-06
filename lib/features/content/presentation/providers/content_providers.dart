import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:musalli/features/content/data/content_repository.dart';
import 'package:musalli/features/content/data/content_search_service.dart';
import 'package:musalli/shared/content/content.dart';

/// Content repository singleton provider.
final contentRepositoryProvider = Provider<ContentRepository>((ref) {
  return ContentRepository();
});

/// Content search service provider.
final contentSearchServiceProvider = Provider<ContentSearchService>((ref) {
  final repo = ref.watch(contentRepositoryProvider);
  final service = ContentSearchService(repo);
  ref.onDispose(service.dispose);
  return service;
});

/// All 29 prayers list provider.
final prayersListProvider = FutureProvider<List<ContentPrayerType>>((ref) {
  return ref.watch(contentRepositoryProvider).getPrayers();
});

/// Single prayer by slug provider family.
final FutureProviderFamily<ContentPrayerType?, String> prayerBySlugProvider =
    FutureProvider.family<ContentPrayerType?, String>((ref, slug) {
      return ref.watch(contentRepositoryProvider).getPrayerBySlug(slug);
    });

/// Duas list provider.
final duasListProvider = FutureProvider<List<ContentDua>>((ref) {
  return ref.watch(contentRepositoryProvider).getDuas();
});

/// Hadiths list provider.
final hadithsListProvider = FutureProvider<List<ContentHadithItem>>((ref) {
  return ref.watch(contentRepositoryProvider).getHadiths();
});

/// Masail (rulings) list provider.
final rulingsListProvider = FutureProvider<List<ContentRuling>>((ref) {
  return ref.watch(contentRepositoryProvider).getRulings();
});

/// Single ruling by slug provider family.
final FutureProviderFamily<ContentRuling?, String> rulingBySlugProvider =
    FutureProvider.family<ContentRuling?, String>((ref, slug) {
      return ref.watch(contentRepositoryProvider).getRulingBySlug(slug);
    });

/// Surahs list provider (13 detailed prayer surahs).
final surahsListProvider = FutureProvider<List<ContentSurah>>((ref) {
  return ref.watch(contentRepositoryProvider).getSurahs();
});

/// All 114 Quran surahs metadata provider.
final allSurahsListProvider = FutureProvider<List<QuranSurahSummary>>((ref) {
  return ref.watch(contentRepositoryProvider).getAllSurahs();
});

/// Taharat sections list provider.
final taharatListProvider = FutureProvider<List<ContentTaharatSection>>((ref) {
  return ref.watch(contentRepositoryProvider).getTaharatSections();
});

/// Single taharat section by slug provider family.
final FutureProviderFamily<ContentTaharatSection?, String>
taharatBySlugProvider = FutureProvider.family<ContentTaharatSection?, String>((
  ref,
  slug,
) {
  return ref.watch(contentRepositoryProvider).getTaharatSectionBySlug(slug);
});

/// FAQs list provider.
final faqsListProvider = FutureProvider<List<ContentFaqItem>>((ref) {
  return ref.watch(contentRepositoryProvider).getFaqs();
});

/// Islamic history eras list provider.
final historyErasProvider = FutureProvider<List<ContentHistoryEra>>((ref) {
  return ref.watch(contentRepositoryProvider).getHistoryEras();
});

/// Search results provider family.
final FutureProviderFamily<List<ContentSearchResult>, String>
contentSearchProvider =
    FutureProvider.family<List<ContentSearchResult>, String>((ref, query) {
      if (query.trim().isEmpty) return Future.value(const []);
      return ref.watch(contentSearchServiceProvider).search(query);
    });
