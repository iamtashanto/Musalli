// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shikhun_article.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ContentSection {

 String get title; List<String> get paragraphs; List<String>? get keyPoints;
/// Create a copy of ContentSection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContentSectionCopyWith<ContentSection> get copyWith => _$ContentSectionCopyWithImpl<ContentSection>(this as ContentSection, _$identity);

  /// Serializes this ContentSection to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ContentSection;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContentSection&&(identical(other.title, _this.title) || other.title == _this.title)&&const DeepCollectionEquality().equals(other.paragraphs, _this.paragraphs)&&const DeepCollectionEquality().equals(other.keyPoints, _this.keyPoints));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ContentSection;
  return Object.hash(runtimeType,_this.title,const DeepCollectionEquality().hash(_this.paragraphs),const DeepCollectionEquality().hash(_this.keyPoints));
}

@override
String toString() {
  final _this = this as ContentSection;
  return 'ContentSection(title: ${_this.title}, paragraphs: ${_this.paragraphs}, keyPoints: ${_this.keyPoints})';
}


}

/// @nodoc
abstract mixin class $ContentSectionCopyWith<$Res>  {
  factory $ContentSectionCopyWith(ContentSection value, $Res Function(ContentSection) _then) = _$ContentSectionCopyWithImpl;
@useResult
$Res call({
 String title, List<String> paragraphs, List<String>? keyPoints
});




}
/// @nodoc
class _$ContentSectionCopyWithImpl<$Res>
    implements $ContentSectionCopyWith<$Res> {
  _$ContentSectionCopyWithImpl(this._self, this._then);

  final ContentSection _self;
  final $Res Function(ContentSection) _then;

/// Create a copy of ContentSection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? paragraphs = null,Object? keyPoints = freezed,}) {
  return _then(ContentSection(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,paragraphs: null == paragraphs ? _self.paragraphs : paragraphs // ignore: cast_nullable_to_non_nullable
as List<String>,keyPoints: freezed == keyPoints ? _self.keyPoints : keyPoints // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}

}


/// Adds pattern-matching-related methods to [ContentSection].
extension ContentSectionPatterns on ContentSection {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ContentSection value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ContentSection() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ContentSection value)  $default,){
final _that = this;
switch (_that) {
case _ContentSection():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ContentSection value)?  $default,){
final _that = this;
switch (_that) {
case _ContentSection() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  List<String> paragraphs,  List<String>? keyPoints)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ContentSection() when $default != null:
return $default(_that.title,_that.paragraphs,_that.keyPoints);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  List<String> paragraphs,  List<String>? keyPoints)  $default,) {final _that = this;
switch (_that) {
case _ContentSection():
return $default(_that.title,_that.paragraphs,_that.keyPoints);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  List<String> paragraphs,  List<String>? keyPoints)?  $default,) {final _that = this;
switch (_that) {
case _ContentSection() when $default != null:
return $default(_that.title,_that.paragraphs,_that.keyPoints);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ContentSection implements ContentSection {
  const _ContentSection({required this.title,  List<String> paragraphs = const <String>[],  List<String>? keyPoints}): _paragraphs = paragraphs,_keyPoints = keyPoints;
  factory _ContentSection.fromJson(Map<String, dynamic> json) => _$ContentSectionFromJson(json);

@override final  String title;
 final  List<String> _paragraphs;
@override@JsonKey() List<String> get paragraphs {
  if (_paragraphs is EqualUnmodifiableListView) return _paragraphs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_paragraphs);
}

 final  List<String>? _keyPoints;
@override List<String>? get keyPoints {
  final value = _keyPoints;
  if (value == null) return null;
  if (_keyPoints is EqualUnmodifiableListView) return _keyPoints;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of ContentSection
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ContentSectionCopyWith<_ContentSection> get copyWith => __$ContentSectionCopyWithImpl<_ContentSection>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ContentSectionToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ContentSection&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other.paragraphs, _paragraphs)&&const DeepCollectionEquality().equals(other.keyPoints, _keyPoints));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,title,const DeepCollectionEquality().hash(_paragraphs),const DeepCollectionEquality().hash(_keyPoints));
}

@override
String toString() {
    return 'ContentSection(title: $title, paragraphs: $paragraphs, keyPoints: $keyPoints)';
}


}

/// @nodoc
abstract mixin class _$ContentSectionCopyWith<$Res> implements $ContentSectionCopyWith<$Res> {
  factory _$ContentSectionCopyWith(_ContentSection value, $Res Function(_ContentSection) _then) = __$ContentSectionCopyWithImpl;
@override @useResult
$Res call({
 String title, List<String> paragraphs, List<String>? keyPoints
});




}
/// @nodoc
class __$ContentSectionCopyWithImpl<$Res>
    implements _$ContentSectionCopyWith<$Res> {
  __$ContentSectionCopyWithImpl(this._self, this._then);

  final _ContentSection _self;
  final $Res Function(_ContentSection) _then;

/// Create a copy of ContentSection
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? paragraphs = null,Object? keyPoints = freezed,}) {
  return _then(_ContentSection(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,paragraphs: null == paragraphs ? _self._paragraphs : paragraphs // ignore: cast_nullable_to_non_nullable
as List<String>,keyPoints: freezed == keyPoints ? _self._keyPoints : keyPoints // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}


}


/// @nodoc
mixin _$ContentShikhunArticle {

 String get slug; String get titleBn; String get titleEn; String get summaryBn; String get category; String get categoryLabelBn; int get readTimeMinutes; String get publishedDate; List<ContentSection> get contentSections; List<ContentPrayerFAQ> get faqs; List<String>? get relatedPrayers; List<String>? get relatedMasail;
/// Create a copy of ContentShikhunArticle
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContentShikhunArticleCopyWith<ContentShikhunArticle> get copyWith => _$ContentShikhunArticleCopyWithImpl<ContentShikhunArticle>(this as ContentShikhunArticle, _$identity);

  /// Serializes this ContentShikhunArticle to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ContentShikhunArticle;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContentShikhunArticle&&(identical(other.slug, _this.slug) || other.slug == _this.slug)&&(identical(other.titleBn, _this.titleBn) || other.titleBn == _this.titleBn)&&(identical(other.titleEn, _this.titleEn) || other.titleEn == _this.titleEn)&&(identical(other.summaryBn, _this.summaryBn) || other.summaryBn == _this.summaryBn)&&(identical(other.category, _this.category) || other.category == _this.category)&&(identical(other.categoryLabelBn, _this.categoryLabelBn) || other.categoryLabelBn == _this.categoryLabelBn)&&(identical(other.readTimeMinutes, _this.readTimeMinutes) || other.readTimeMinutes == _this.readTimeMinutes)&&(identical(other.publishedDate, _this.publishedDate) || other.publishedDate == _this.publishedDate)&&const DeepCollectionEquality().equals(other.contentSections, _this.contentSections)&&const DeepCollectionEquality().equals(other.faqs, _this.faqs)&&const DeepCollectionEquality().equals(other.relatedPrayers, _this.relatedPrayers)&&const DeepCollectionEquality().equals(other.relatedMasail, _this.relatedMasail));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ContentShikhunArticle;
  return Object.hash(runtimeType,_this.slug,_this.titleBn,_this.titleEn,_this.summaryBn,_this.category,_this.categoryLabelBn,_this.readTimeMinutes,_this.publishedDate,const DeepCollectionEquality().hash(_this.contentSections),const DeepCollectionEquality().hash(_this.faqs),const DeepCollectionEquality().hash(_this.relatedPrayers),const DeepCollectionEquality().hash(_this.relatedMasail));
}

@override
String toString() {
  final _this = this as ContentShikhunArticle;
  return 'ContentShikhunArticle(slug: ${_this.slug}, titleBn: ${_this.titleBn}, titleEn: ${_this.titleEn}, summaryBn: ${_this.summaryBn}, category: ${_this.category}, categoryLabelBn: ${_this.categoryLabelBn}, readTimeMinutes: ${_this.readTimeMinutes}, publishedDate: ${_this.publishedDate}, contentSections: ${_this.contentSections}, faqs: ${_this.faqs}, relatedPrayers: ${_this.relatedPrayers}, relatedMasail: ${_this.relatedMasail})';
}


}

/// @nodoc
abstract mixin class $ContentShikhunArticleCopyWith<$Res>  {
  factory $ContentShikhunArticleCopyWith(ContentShikhunArticle value, $Res Function(ContentShikhunArticle) _then) = _$ContentShikhunArticleCopyWithImpl;
@useResult
$Res call({
 String slug, String titleBn, String titleEn, String summaryBn, String category, String categoryLabelBn, int readTimeMinutes, String publishedDate, List<ContentSection> contentSections, List<ContentPrayerFAQ> faqs, List<String>? relatedPrayers, List<String>? relatedMasail
});




}
/// @nodoc
class _$ContentShikhunArticleCopyWithImpl<$Res>
    implements $ContentShikhunArticleCopyWith<$Res> {
  _$ContentShikhunArticleCopyWithImpl(this._self, this._then);

  final ContentShikhunArticle _self;
  final $Res Function(ContentShikhunArticle) _then;

/// Create a copy of ContentShikhunArticle
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? slug = null,Object? titleBn = null,Object? titleEn = null,Object? summaryBn = null,Object? category = null,Object? categoryLabelBn = null,Object? readTimeMinutes = null,Object? publishedDate = null,Object? contentSections = null,Object? faqs = null,Object? relatedPrayers = freezed,Object? relatedMasail = freezed,}) {
  return _then(ContentShikhunArticle(
slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,titleBn: null == titleBn ? _self.titleBn : titleBn // ignore: cast_nullable_to_non_nullable
as String,titleEn: null == titleEn ? _self.titleEn : titleEn // ignore: cast_nullable_to_non_nullable
as String,summaryBn: null == summaryBn ? _self.summaryBn : summaryBn // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,categoryLabelBn: null == categoryLabelBn ? _self.categoryLabelBn : categoryLabelBn // ignore: cast_nullable_to_non_nullable
as String,readTimeMinutes: null == readTimeMinutes ? _self.readTimeMinutes : readTimeMinutes // ignore: cast_nullable_to_non_nullable
as int,publishedDate: null == publishedDate ? _self.publishedDate : publishedDate // ignore: cast_nullable_to_non_nullable
as String,contentSections: null == contentSections ? _self.contentSections : contentSections // ignore: cast_nullable_to_non_nullable
as List<ContentSection>,faqs: null == faqs ? _self.faqs : faqs // ignore: cast_nullable_to_non_nullable
as List<ContentPrayerFAQ>,relatedPrayers: freezed == relatedPrayers ? _self.relatedPrayers : relatedPrayers // ignore: cast_nullable_to_non_nullable
as List<String>?,relatedMasail: freezed == relatedMasail ? _self.relatedMasail : relatedMasail // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}

}


/// Adds pattern-matching-related methods to [ContentShikhunArticle].
extension ContentShikhunArticlePatterns on ContentShikhunArticle {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ContentShikhunArticle value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ContentShikhunArticle() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ContentShikhunArticle value)  $default,){
final _that = this;
switch (_that) {
case _ContentShikhunArticle():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ContentShikhunArticle value)?  $default,){
final _that = this;
switch (_that) {
case _ContentShikhunArticle() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String slug,  String titleBn,  String titleEn,  String summaryBn,  String category,  String categoryLabelBn,  int readTimeMinutes,  String publishedDate,  List<ContentSection> contentSections,  List<ContentPrayerFAQ> faqs,  List<String>? relatedPrayers,  List<String>? relatedMasail)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ContentShikhunArticle() when $default != null:
return $default(_that.slug,_that.titleBn,_that.titleEn,_that.summaryBn,_that.category,_that.categoryLabelBn,_that.readTimeMinutes,_that.publishedDate,_that.contentSections,_that.faqs,_that.relatedPrayers,_that.relatedMasail);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String slug,  String titleBn,  String titleEn,  String summaryBn,  String category,  String categoryLabelBn,  int readTimeMinutes,  String publishedDate,  List<ContentSection> contentSections,  List<ContentPrayerFAQ> faqs,  List<String>? relatedPrayers,  List<String>? relatedMasail)  $default,) {final _that = this;
switch (_that) {
case _ContentShikhunArticle():
return $default(_that.slug,_that.titleBn,_that.titleEn,_that.summaryBn,_that.category,_that.categoryLabelBn,_that.readTimeMinutes,_that.publishedDate,_that.contentSections,_that.faqs,_that.relatedPrayers,_that.relatedMasail);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String slug,  String titleBn,  String titleEn,  String summaryBn,  String category,  String categoryLabelBn,  int readTimeMinutes,  String publishedDate,  List<ContentSection> contentSections,  List<ContentPrayerFAQ> faqs,  List<String>? relatedPrayers,  List<String>? relatedMasail)?  $default,) {final _that = this;
switch (_that) {
case _ContentShikhunArticle() when $default != null:
return $default(_that.slug,_that.titleBn,_that.titleEn,_that.summaryBn,_that.category,_that.categoryLabelBn,_that.readTimeMinutes,_that.publishedDate,_that.contentSections,_that.faqs,_that.relatedPrayers,_that.relatedMasail);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ContentShikhunArticle implements ContentShikhunArticle {
  const _ContentShikhunArticle({required this.slug, required this.titleBn, this.titleEn = '', required this.summaryBn, required this.category, required this.categoryLabelBn, this.readTimeMinutes = 5, this.publishedDate = '',  List<ContentSection> contentSections = const <ContentSection>[],  List<ContentPrayerFAQ> faqs = const <ContentPrayerFAQ>[],  List<String>? relatedPrayers,  List<String>? relatedMasail}): _contentSections = contentSections,_faqs = faqs,_relatedPrayers = relatedPrayers,_relatedMasail = relatedMasail;
  factory _ContentShikhunArticle.fromJson(Map<String, dynamic> json) => _$ContentShikhunArticleFromJson(json);

@override final  String slug;
@override final  String titleBn;
@override@JsonKey() final  String titleEn;
@override final  String summaryBn;
@override final  String category;
@override final  String categoryLabelBn;
@override@JsonKey() final  int readTimeMinutes;
@override@JsonKey() final  String publishedDate;
 final  List<ContentSection> _contentSections;
@override@JsonKey() List<ContentSection> get contentSections {
  if (_contentSections is EqualUnmodifiableListView) return _contentSections;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_contentSections);
}

 final  List<ContentPrayerFAQ> _faqs;
@override@JsonKey() List<ContentPrayerFAQ> get faqs {
  if (_faqs is EqualUnmodifiableListView) return _faqs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_faqs);
}

 final  List<String>? _relatedPrayers;
@override List<String>? get relatedPrayers {
  final value = _relatedPrayers;
  if (value == null) return null;
  if (_relatedPrayers is EqualUnmodifiableListView) return _relatedPrayers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<String>? _relatedMasail;
@override List<String>? get relatedMasail {
  final value = _relatedMasail;
  if (value == null) return null;
  if (_relatedMasail is EqualUnmodifiableListView) return _relatedMasail;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of ContentShikhunArticle
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ContentShikhunArticleCopyWith<_ContentShikhunArticle> get copyWith => __$ContentShikhunArticleCopyWithImpl<_ContentShikhunArticle>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ContentShikhunArticleToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ContentShikhunArticle&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.titleBn, titleBn) || other.titleBn == titleBn)&&(identical(other.titleEn, titleEn) || other.titleEn == titleEn)&&(identical(other.summaryBn, summaryBn) || other.summaryBn == summaryBn)&&(identical(other.category, category) || other.category == category)&&(identical(other.categoryLabelBn, categoryLabelBn) || other.categoryLabelBn == categoryLabelBn)&&(identical(other.readTimeMinutes, readTimeMinutes) || other.readTimeMinutes == readTimeMinutes)&&(identical(other.publishedDate, publishedDate) || other.publishedDate == publishedDate)&&const DeepCollectionEquality().equals(other.contentSections, _contentSections)&&const DeepCollectionEquality().equals(other.faqs, _faqs)&&const DeepCollectionEquality().equals(other.relatedPrayers, _relatedPrayers)&&const DeepCollectionEquality().equals(other.relatedMasail, _relatedMasail));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,slug,titleBn,titleEn,summaryBn,category,categoryLabelBn,readTimeMinutes,publishedDate,const DeepCollectionEquality().hash(_contentSections),const DeepCollectionEquality().hash(_faqs),const DeepCollectionEquality().hash(_relatedPrayers),const DeepCollectionEquality().hash(_relatedMasail));
}

@override
String toString() {
    return 'ContentShikhunArticle(slug: $slug, titleBn: $titleBn, titleEn: $titleEn, summaryBn: $summaryBn, category: $category, categoryLabelBn: $categoryLabelBn, readTimeMinutes: $readTimeMinutes, publishedDate: $publishedDate, contentSections: $contentSections, faqs: $faqs, relatedPrayers: $relatedPrayers, relatedMasail: $relatedMasail)';
}


}

/// @nodoc
abstract mixin class _$ContentShikhunArticleCopyWith<$Res> implements $ContentShikhunArticleCopyWith<$Res> {
  factory _$ContentShikhunArticleCopyWith(_ContentShikhunArticle value, $Res Function(_ContentShikhunArticle) _then) = __$ContentShikhunArticleCopyWithImpl;
@override @useResult
$Res call({
 String slug, String titleBn, String titleEn, String summaryBn, String category, String categoryLabelBn, int readTimeMinutes, String publishedDate, List<ContentSection> contentSections, List<ContentPrayerFAQ> faqs, List<String>? relatedPrayers, List<String>? relatedMasail
});




}
/// @nodoc
class __$ContentShikhunArticleCopyWithImpl<$Res>
    implements _$ContentShikhunArticleCopyWith<$Res> {
  __$ContentShikhunArticleCopyWithImpl(this._self, this._then);

  final _ContentShikhunArticle _self;
  final $Res Function(_ContentShikhunArticle) _then;

/// Create a copy of ContentShikhunArticle
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? slug = null,Object? titleBn = null,Object? titleEn = null,Object? summaryBn = null,Object? category = null,Object? categoryLabelBn = null,Object? readTimeMinutes = null,Object? publishedDate = null,Object? contentSections = null,Object? faqs = null,Object? relatedPrayers = freezed,Object? relatedMasail = freezed,}) {
  return _then(_ContentShikhunArticle(
slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,titleBn: null == titleBn ? _self.titleBn : titleBn // ignore: cast_nullable_to_non_nullable
as String,titleEn: null == titleEn ? _self.titleEn : titleEn // ignore: cast_nullable_to_non_nullable
as String,summaryBn: null == summaryBn ? _self.summaryBn : summaryBn // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,categoryLabelBn: null == categoryLabelBn ? _self.categoryLabelBn : categoryLabelBn // ignore: cast_nullable_to_non_nullable
as String,readTimeMinutes: null == readTimeMinutes ? _self.readTimeMinutes : readTimeMinutes // ignore: cast_nullable_to_non_nullable
as int,publishedDate: null == publishedDate ? _self.publishedDate : publishedDate // ignore: cast_nullable_to_non_nullable
as String,contentSections: null == contentSections ? _self._contentSections : contentSections // ignore: cast_nullable_to_non_nullable
as List<ContentSection>,faqs: null == faqs ? _self._faqs : faqs // ignore: cast_nullable_to_non_nullable
as List<ContentPrayerFAQ>,relatedPrayers: freezed == relatedPrayers ? _self._relatedPrayers : relatedPrayers // ignore: cast_nullable_to_non_nullable
as List<String>?,relatedMasail: freezed == relatedMasail ? _self._relatedMasail : relatedMasail // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}


}

// dart format on
