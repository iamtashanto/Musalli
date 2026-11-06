import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:musalli/shared/content/content_enums.dart';

part 'reference.freezed.dart';
part 'reference.g.dart';

String _numberFromJson(dynamic value) => value == null ? '' : value.toString();

/// Citation reference to Quran, Hadith, or classical Fiqh manuals.
@freezed
abstract class ContentReference with _$ContentReference {
  const factory ContentReference({
    required ReferenceType type,
    required String source,
    @JsonKey(fromJson: _numberFromJson) required String number,
    ContentHadithGrade? grade,
    String? url,
  }) = _ContentReference;

  factory ContentReference.fromJson(Map<String, dynamic> json) =>
      _$ContentReferenceFromJson(json);
}
