import 'package:freezed_annotation/freezed_annotation.dart';

part 'faq_item.freezed.dart';
part 'faq_item.g.dart';

/// Question & Answer item on prayer rules and general Islamic guidelines.
@freezed
abstract class ContentFaqItem with _$ContentFaqItem {
  const factory ContentFaqItem({
    required int id,
    @JsonKey(name: 'question_bn') required String questionBn,
    @JsonKey(name: 'question_en') @Default('') String questionEn,
    @JsonKey(name: 'answer_bn') required String answerBn,
    @JsonKey(name: 'answer_en') @Default('') String answerEn,
    @Default('general') String category,
  }) = _ContentFaqItem;

  factory ContentFaqItem.fromJson(Map<String, dynamic> json) =>
      _$ContentFaqItemFromJson(json);
}

