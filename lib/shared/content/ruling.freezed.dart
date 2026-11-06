// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ruling.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ContentRuling {

 String get id; String get slug; String get titleBn; String get titleEn; String get summaryBn; String get category; ContentRulingStatus get status; AppliesToGender get appliesTo; String get bodyBn; ContentGenderDifferences? get genderDifferences; List<ContentPrayerFAQ>? get faqs; List<ContentReference> get references; List<String>? get relatedTopics; List<String>? get relatedPrayers; ContentReviewStatus get reviewStatus;
/// Create a copy of ContentRuling
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContentRulingCopyWith<ContentRuling> get copyWith => _$ContentRulingCopyWithImpl<ContentRuling>(this as ContentRuling, _$identity);

  /// Serializes this ContentRuling to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ContentRuling;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContentRuling&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.slug, _this.slug) || other.slug == _this.slug)&&(identical(other.titleBn, _this.titleBn) || other.titleBn == _this.titleBn)&&(identical(other.titleEn, _this.titleEn) || other.titleEn == _this.titleEn)&&(identical(other.summaryBn, _this.summaryBn) || other.summaryBn == _this.summaryBn)&&(identical(other.category, _this.category) || other.category == _this.category)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.appliesTo, _this.appliesTo) || other.appliesTo == _this.appliesTo)&&(identical(other.bodyBn, _this.bodyBn) || other.bodyBn == _this.bodyBn)&&(identical(other.genderDifferences, _this.genderDifferences) || other.genderDifferences == _this.genderDifferences)&&const DeepCollectionEquality().equals(other.faqs, _this.faqs)&&const DeepCollectionEquality().equals(other.references, _this.references)&&const DeepCollectionEquality().equals(other.relatedTopics, _this.relatedTopics)&&const DeepCollectionEquality().equals(other.relatedPrayers, _this.relatedPrayers)&&(identical(other.reviewStatus, _this.reviewStatus) || other.reviewStatus == _this.reviewStatus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ContentRuling;
  return Object.hash(runtimeType,_this.id,_this.slug,_this.titleBn,_this.titleEn,_this.summaryBn,_this.category,_this.status,_this.appliesTo,_this.bodyBn,_this.genderDifferences,const DeepCollectionEquality().hash(_this.faqs),const DeepCollectionEquality().hash(_this.references),const DeepCollectionEquality().hash(_this.relatedTopics),const DeepCollectionEquality().hash(_this.relatedPrayers),_this.reviewStatus);
}

@override
String toString() {
  final _this = this as ContentRuling;
  return 'ContentRuling(id: ${_this.id}, slug: ${_this.slug}, titleBn: ${_this.titleBn}, titleEn: ${_this.titleEn}, summaryBn: ${_this.summaryBn}, category: ${_this.category}, status: ${_this.status}, appliesTo: ${_this.appliesTo}, bodyBn: ${_this.bodyBn}, genderDifferences: ${_this.genderDifferences}, faqs: ${_this.faqs}, references: ${_this.references}, relatedTopics: ${_this.relatedTopics}, relatedPrayers: ${_this.relatedPrayers}, reviewStatus: ${_this.reviewStatus})';
}


}

/// @nodoc
abstract mixin class $ContentRulingCopyWith<$Res>  {
  factory $ContentRulingCopyWith(ContentRuling value, $Res Function(ContentRuling) _then) = _$ContentRulingCopyWithImpl;
@useResult
$Res call({
 String id, String slug, String titleBn, String titleEn, String summaryBn, String category, ContentRulingStatus status, AppliesToGender appliesTo, String bodyBn, ContentGenderDifferences? genderDifferences, List<ContentPrayerFAQ>? faqs, List<ContentReference> references, List<String>? relatedTopics, List<String>? relatedPrayers, ContentReviewStatus reviewStatus
});


$ContentGenderDifferencesCopyWith<$Res>? get genderDifferences;

}
/// @nodoc
class _$ContentRulingCopyWithImpl<$Res>
    implements $ContentRulingCopyWith<$Res> {
  _$ContentRulingCopyWithImpl(this._self, this._then);

  final ContentRuling _self;
  final $Res Function(ContentRuling) _then;

/// Create a copy of ContentRuling
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? slug = null,Object? titleBn = null,Object? titleEn = null,Object? summaryBn = null,Object? category = null,Object? status = null,Object? appliesTo = null,Object? bodyBn = null,Object? genderDifferences = freezed,Object? faqs = freezed,Object? references = null,Object? relatedTopics = freezed,Object? relatedPrayers = freezed,Object? reviewStatus = null,}) {
  return _then(ContentRuling(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,titleBn: null == titleBn ? _self.titleBn : titleBn // ignore: cast_nullable_to_non_nullable
as String,titleEn: null == titleEn ? _self.titleEn : titleEn // ignore: cast_nullable_to_non_nullable
as String,summaryBn: null == summaryBn ? _self.summaryBn : summaryBn // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ContentRulingStatus,appliesTo: null == appliesTo ? _self.appliesTo : appliesTo // ignore: cast_nullable_to_non_nullable
as AppliesToGender,bodyBn: null == bodyBn ? _self.bodyBn : bodyBn // ignore: cast_nullable_to_non_nullable
as String,genderDifferences: freezed == genderDifferences ? _self.genderDifferences : genderDifferences // ignore: cast_nullable_to_non_nullable
as ContentGenderDifferences?,faqs: freezed == faqs ? _self.faqs : faqs // ignore: cast_nullable_to_non_nullable
as List<ContentPrayerFAQ>?,references: null == references ? _self.references : references // ignore: cast_nullable_to_non_nullable
as List<ContentReference>,relatedTopics: freezed == relatedTopics ? _self.relatedTopics : relatedTopics // ignore: cast_nullable_to_non_nullable
as List<String>?,relatedPrayers: freezed == relatedPrayers ? _self.relatedPrayers : relatedPrayers // ignore: cast_nullable_to_non_nullable
as List<String>?,reviewStatus: null == reviewStatus ? _self.reviewStatus : reviewStatus // ignore: cast_nullable_to_non_nullable
as ContentReviewStatus,
  ));
}
/// Create a copy of ContentRuling
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ContentGenderDifferencesCopyWith<$Res>? get genderDifferences {
    if (_self.genderDifferences == null) {
    return null;
  }

  return $ContentGenderDifferencesCopyWith<$Res>(_self.genderDifferences!, (value) {
    return _then(_self.copyWith(genderDifferences: value));
  });
}
}


/// Adds pattern-matching-related methods to [ContentRuling].
extension ContentRulingPatterns on ContentRuling {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ContentRuling value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ContentRuling() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ContentRuling value)  $default,){
final _that = this;
switch (_that) {
case _ContentRuling():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ContentRuling value)?  $default,){
final _that = this;
switch (_that) {
case _ContentRuling() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String slug,  String titleBn,  String titleEn,  String summaryBn,  String category,  ContentRulingStatus status,  AppliesToGender appliesTo,  String bodyBn,  ContentGenderDifferences? genderDifferences,  List<ContentPrayerFAQ>? faqs,  List<ContentReference> references,  List<String>? relatedTopics,  List<String>? relatedPrayers,  ContentReviewStatus reviewStatus)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ContentRuling() when $default != null:
return $default(_that.id,_that.slug,_that.titleBn,_that.titleEn,_that.summaryBn,_that.category,_that.status,_that.appliesTo,_that.bodyBn,_that.genderDifferences,_that.faqs,_that.references,_that.relatedTopics,_that.relatedPrayers,_that.reviewStatus);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String slug,  String titleBn,  String titleEn,  String summaryBn,  String category,  ContentRulingStatus status,  AppliesToGender appliesTo,  String bodyBn,  ContentGenderDifferences? genderDifferences,  List<ContentPrayerFAQ>? faqs,  List<ContentReference> references,  List<String>? relatedTopics,  List<String>? relatedPrayers,  ContentReviewStatus reviewStatus)  $default,) {final _that = this;
switch (_that) {
case _ContentRuling():
return $default(_that.id,_that.slug,_that.titleBn,_that.titleEn,_that.summaryBn,_that.category,_that.status,_that.appliesTo,_that.bodyBn,_that.genderDifferences,_that.faqs,_that.references,_that.relatedTopics,_that.relatedPrayers,_that.reviewStatus);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String slug,  String titleBn,  String titleEn,  String summaryBn,  String category,  ContentRulingStatus status,  AppliesToGender appliesTo,  String bodyBn,  ContentGenderDifferences? genderDifferences,  List<ContentPrayerFAQ>? faqs,  List<ContentReference> references,  List<String>? relatedTopics,  List<String>? relatedPrayers,  ContentReviewStatus reviewStatus)?  $default,) {final _that = this;
switch (_that) {
case _ContentRuling() when $default != null:
return $default(_that.id,_that.slug,_that.titleBn,_that.titleEn,_that.summaryBn,_that.category,_that.status,_that.appliesTo,_that.bodyBn,_that.genderDifferences,_that.faqs,_that.references,_that.relatedTopics,_that.relatedPrayers,_that.reviewStatus);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ContentRuling implements ContentRuling {
  const _ContentRuling({required this.id, required this.slug, required this.titleBn, this.titleEn = '', required this.summaryBn, required this.category, required this.status, required this.appliesTo, required this.bodyBn, this.genderDifferences,  List<ContentPrayerFAQ>? faqs,  List<ContentReference> references = const <ContentReference>[],  List<String>? relatedTopics,  List<String>? relatedPrayers, this.reviewStatus = ContentReviewStatus.verified}): _faqs = faqs,_references = references,_relatedTopics = relatedTopics,_relatedPrayers = relatedPrayers;
  factory _ContentRuling.fromJson(Map<String, dynamic> json) => _$ContentRulingFromJson(json);

@override final  String id;
@override final  String slug;
@override final  String titleBn;
@override@JsonKey() final  String titleEn;
@override final  String summaryBn;
@override final  String category;
@override final  ContentRulingStatus status;
@override final  AppliesToGender appliesTo;
@override final  String bodyBn;
@override final  ContentGenderDifferences? genderDifferences;
 final  List<ContentPrayerFAQ>? _faqs;
@override List<ContentPrayerFAQ>? get faqs {
  final value = _faqs;
  if (value == null) return null;
  if (_faqs is EqualUnmodifiableListView) return _faqs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<ContentReference> _references;
@override@JsonKey() List<ContentReference> get references {
  if (_references is EqualUnmodifiableListView) return _references;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_references);
}

 final  List<String>? _relatedTopics;
@override List<String>? get relatedTopics {
  final value = _relatedTopics;
  if (value == null) return null;
  if (_relatedTopics is EqualUnmodifiableListView) return _relatedTopics;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<String>? _relatedPrayers;
@override List<String>? get relatedPrayers {
  final value = _relatedPrayers;
  if (value == null) return null;
  if (_relatedPrayers is EqualUnmodifiableListView) return _relatedPrayers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey() final  ContentReviewStatus reviewStatus;

/// Create a copy of ContentRuling
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ContentRulingCopyWith<_ContentRuling> get copyWith => __$ContentRulingCopyWithImpl<_ContentRuling>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ContentRulingToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ContentRuling&&(identical(other.id, id) || other.id == id)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.titleBn, titleBn) || other.titleBn == titleBn)&&(identical(other.titleEn, titleEn) || other.titleEn == titleEn)&&(identical(other.summaryBn, summaryBn) || other.summaryBn == summaryBn)&&(identical(other.category, category) || other.category == category)&&(identical(other.status, status) || other.status == status)&&(identical(other.appliesTo, appliesTo) || other.appliesTo == appliesTo)&&(identical(other.bodyBn, bodyBn) || other.bodyBn == bodyBn)&&(identical(other.genderDifferences, genderDifferences) || other.genderDifferences == genderDifferences)&&const DeepCollectionEquality().equals(other.faqs, _faqs)&&const DeepCollectionEquality().equals(other.references, _references)&&const DeepCollectionEquality().equals(other.relatedTopics, _relatedTopics)&&const DeepCollectionEquality().equals(other.relatedPrayers, _relatedPrayers)&&(identical(other.reviewStatus, reviewStatus) || other.reviewStatus == reviewStatus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,slug,titleBn,titleEn,summaryBn,category,status,appliesTo,bodyBn,genderDifferences,const DeepCollectionEquality().hash(_faqs),const DeepCollectionEquality().hash(_references),const DeepCollectionEquality().hash(_relatedTopics),const DeepCollectionEquality().hash(_relatedPrayers),reviewStatus);
}

@override
String toString() {
    return 'ContentRuling(id: $id, slug: $slug, titleBn: $titleBn, titleEn: $titleEn, summaryBn: $summaryBn, category: $category, status: $status, appliesTo: $appliesTo, bodyBn: $bodyBn, genderDifferences: $genderDifferences, faqs: $faqs, references: $references, relatedTopics: $relatedTopics, relatedPrayers: $relatedPrayers, reviewStatus: $reviewStatus)';
}


}

/// @nodoc
abstract mixin class _$ContentRulingCopyWith<$Res> implements $ContentRulingCopyWith<$Res> {
  factory _$ContentRulingCopyWith(_ContentRuling value, $Res Function(_ContentRuling) _then) = __$ContentRulingCopyWithImpl;
@override @useResult
$Res call({
 String id, String slug, String titleBn, String titleEn, String summaryBn, String category, ContentRulingStatus status, AppliesToGender appliesTo, String bodyBn, ContentGenderDifferences? genderDifferences, List<ContentPrayerFAQ>? faqs, List<ContentReference> references, List<String>? relatedTopics, List<String>? relatedPrayers, ContentReviewStatus reviewStatus
});


@override $ContentGenderDifferencesCopyWith<$Res>? get genderDifferences;

}
/// @nodoc
class __$ContentRulingCopyWithImpl<$Res>
    implements _$ContentRulingCopyWith<$Res> {
  __$ContentRulingCopyWithImpl(this._self, this._then);

  final _ContentRuling _self;
  final $Res Function(_ContentRuling) _then;

/// Create a copy of ContentRuling
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? slug = null,Object? titleBn = null,Object? titleEn = null,Object? summaryBn = null,Object? category = null,Object? status = null,Object? appliesTo = null,Object? bodyBn = null,Object? genderDifferences = freezed,Object? faqs = freezed,Object? references = null,Object? relatedTopics = freezed,Object? relatedPrayers = freezed,Object? reviewStatus = null,}) {
  return _then(_ContentRuling(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,titleBn: null == titleBn ? _self.titleBn : titleBn // ignore: cast_nullable_to_non_nullable
as String,titleEn: null == titleEn ? _self.titleEn : titleEn // ignore: cast_nullable_to_non_nullable
as String,summaryBn: null == summaryBn ? _self.summaryBn : summaryBn // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ContentRulingStatus,appliesTo: null == appliesTo ? _self.appliesTo : appliesTo // ignore: cast_nullable_to_non_nullable
as AppliesToGender,bodyBn: null == bodyBn ? _self.bodyBn : bodyBn // ignore: cast_nullable_to_non_nullable
as String,genderDifferences: freezed == genderDifferences ? _self.genderDifferences : genderDifferences // ignore: cast_nullable_to_non_nullable
as ContentGenderDifferences?,faqs: freezed == faqs ? _self._faqs : faqs // ignore: cast_nullable_to_non_nullable
as List<ContentPrayerFAQ>?,references: null == references ? _self._references : references // ignore: cast_nullable_to_non_nullable
as List<ContentReference>,relatedTopics: freezed == relatedTopics ? _self._relatedTopics : relatedTopics // ignore: cast_nullable_to_non_nullable
as List<String>?,relatedPrayers: freezed == relatedPrayers ? _self._relatedPrayers : relatedPrayers // ignore: cast_nullable_to_non_nullable
as List<String>?,reviewStatus: null == reviewStatus ? _self.reviewStatus : reviewStatus // ignore: cast_nullable_to_non_nullable
as ContentReviewStatus,
  ));
}

/// Create a copy of ContentRuling
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ContentGenderDifferencesCopyWith<$Res>? get genderDifferences {
    if (_self.genderDifferences == null) {
    return null;
  }

  return $ContentGenderDifferencesCopyWith<$Res>(_self.genderDifferences!, (value) {
    return _then(_self.copyWith(genderDifferences: value));
  });
}
}

// dart format on
