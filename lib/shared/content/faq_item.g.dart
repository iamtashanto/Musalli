// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'faq_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ContentFaqItem _$ContentFaqItemFromJson(Map<String, dynamic> json) =>
    _ContentFaqItem(
      id: (json['id'] as num).toInt(),
      questionBn: json['question_bn'] as String,
      questionEn: json['question_en'] as String? ?? '',
      answerBn: json['answer_bn'] as String,
      answerEn: json['answer_en'] as String? ?? '',
      category: json['category'] as String? ?? 'general',
    );

Map<String, dynamic> _$ContentFaqItemToJson(_ContentFaqItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'question_bn': instance.questionBn,
      'question_en': instance.questionEn,
      'answer_bn': instance.answerBn,
      'answer_en': instance.answerEn,
      'category': instance.category,
    };
