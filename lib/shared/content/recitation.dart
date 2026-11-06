import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:musalli/shared/content/reference.dart';

part 'recitation.freezed.dart';
part 'recitation.g.dart';

/// Recitation block containing the 4 canonical textual layers.
@freezed
abstract class ContentRecitation with _$ContentRecitation {
  const factory ContentRecitation({
    required String id,
    required String titleBn,
    @Default('') String titleEn,
    required String arabic,
    required String uccharonBn,
    required String banglish,
    required String meaningBn,
    String? meaningEn,
    String? audioSrc,
    ContentReference? reference,
    String? notes,
  }) = _ContentRecitation;

  factory ContentRecitation.fromJson(Map<String, dynamic> json) =>
      _$ContentRecitationFromJson(json);
}
