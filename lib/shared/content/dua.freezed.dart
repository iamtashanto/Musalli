// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dua.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ContentDua {

 String get id; String get titleBn; String get titleEn; String get arabic; String get uccharonBn; String get banglish; String get meaningBn; String? get meaningEn; ContentDuaCategory get category; ContentReviewStatus get reviewStatus; String? get audioSrc; ContentReference? get reference; String? get notes;
/// Create a copy of ContentDua
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContentDuaCopyWith<ContentDua> get copyWith => _$ContentDuaCopyWithImpl<ContentDua>(this as ContentDua, _$identity);

  /// Serializes this ContentDua to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ContentDua;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContentDua&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.titleBn, _this.titleBn) || other.titleBn == _this.titleBn)&&(identical(other.titleEn, _this.titleEn) || other.titleEn == _this.titleEn)&&(identical(other.arabic, _this.arabic) || other.arabic == _this.arabic)&&(identical(other.uccharonBn, _this.uccharonBn) || other.uccharonBn == _this.uccharonBn)&&(identical(other.banglish, _this.banglish) || other.banglish == _this.banglish)&&(identical(other.meaningBn, _this.meaningBn) || other.meaningBn == _this.meaningBn)&&(identical(other.meaningEn, _this.meaningEn) || other.meaningEn == _this.meaningEn)&&(identical(other.category, _this.category) || other.category == _this.category)&&(identical(other.reviewStatus, _this.reviewStatus) || other.reviewStatus == _this.reviewStatus)&&(identical(other.audioSrc, _this.audioSrc) || other.audioSrc == _this.audioSrc)&&(identical(other.reference, _this.reference) || other.reference == _this.reference)&&(identical(other.notes, _this.notes) || other.notes == _this.notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ContentDua;
  return Object.hash(runtimeType,_this.id,_this.titleBn,_this.titleEn,_this.arabic,_this.uccharonBn,_this.banglish,_this.meaningBn,_this.meaningEn,_this.category,_this.reviewStatus,_this.audioSrc,_this.reference,_this.notes);
}

@override
String toString() {
  final _this = this as ContentDua;
  return 'ContentDua(id: ${_this.id}, titleBn: ${_this.titleBn}, titleEn: ${_this.titleEn}, arabic: ${_this.arabic}, uccharonBn: ${_this.uccharonBn}, banglish: ${_this.banglish}, meaningBn: ${_this.meaningBn}, meaningEn: ${_this.meaningEn}, category: ${_this.category}, reviewStatus: ${_this.reviewStatus}, audioSrc: ${_this.audioSrc}, reference: ${_this.reference}, notes: ${_this.notes})';
}


}

/// @nodoc
abstract mixin class $ContentDuaCopyWith<$Res>  {
  factory $ContentDuaCopyWith(ContentDua value, $Res Function(ContentDua) _then) = _$ContentDuaCopyWithImpl;
@useResult
$Res call({
 String id, String titleBn, String titleEn, String arabic, String uccharonBn, String banglish, String meaningBn, String? meaningEn, ContentDuaCategory category, ContentReviewStatus reviewStatus, String? audioSrc, ContentReference? reference, String? notes
});


$ContentReferenceCopyWith<$Res>? get reference;

}
/// @nodoc
class _$ContentDuaCopyWithImpl<$Res>
    implements $ContentDuaCopyWith<$Res> {
  _$ContentDuaCopyWithImpl(this._self, this._then);

  final ContentDua _self;
  final $Res Function(ContentDua) _then;

/// Create a copy of ContentDua
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? titleBn = null,Object? titleEn = null,Object? arabic = null,Object? uccharonBn = null,Object? banglish = null,Object? meaningBn = null,Object? meaningEn = freezed,Object? category = null,Object? reviewStatus = null,Object? audioSrc = freezed,Object? reference = freezed,Object? notes = freezed,}) {
  return _then(ContentDua(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,titleBn: null == titleBn ? _self.titleBn : titleBn // ignore: cast_nullable_to_non_nullable
as String,titleEn: null == titleEn ? _self.titleEn : titleEn // ignore: cast_nullable_to_non_nullable
as String,arabic: null == arabic ? _self.arabic : arabic // ignore: cast_nullable_to_non_nullable
as String,uccharonBn: null == uccharonBn ? _self.uccharonBn : uccharonBn // ignore: cast_nullable_to_non_nullable
as String,banglish: null == banglish ? _self.banglish : banglish // ignore: cast_nullable_to_non_nullable
as String,meaningBn: null == meaningBn ? _self.meaningBn : meaningBn // ignore: cast_nullable_to_non_nullable
as String,meaningEn: freezed == meaningEn ? _self.meaningEn : meaningEn // ignore: cast_nullable_to_non_nullable
as String?,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as ContentDuaCategory,reviewStatus: null == reviewStatus ? _self.reviewStatus : reviewStatus // ignore: cast_nullable_to_non_nullable
as ContentReviewStatus,audioSrc: freezed == audioSrc ? _self.audioSrc : audioSrc // ignore: cast_nullable_to_non_nullable
as String?,reference: freezed == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as ContentReference?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of ContentDua
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ContentReferenceCopyWith<$Res>? get reference {
    if (_self.reference == null) {
    return null;
  }

  return $ContentReferenceCopyWith<$Res>(_self.reference!, (value) {
    return _then(_self.copyWith(reference: value));
  });
}
}


/// Adds pattern-matching-related methods to [ContentDua].
extension ContentDuaPatterns on ContentDua {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ContentDua value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ContentDua() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ContentDua value)  $default,){
final _that = this;
switch (_that) {
case _ContentDua():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ContentDua value)?  $default,){
final _that = this;
switch (_that) {
case _ContentDua() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String titleBn,  String titleEn,  String arabic,  String uccharonBn,  String banglish,  String meaningBn,  String? meaningEn,  ContentDuaCategory category,  ContentReviewStatus reviewStatus,  String? audioSrc,  ContentReference? reference,  String? notes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ContentDua() when $default != null:
return $default(_that.id,_that.titleBn,_that.titleEn,_that.arabic,_that.uccharonBn,_that.banglish,_that.meaningBn,_that.meaningEn,_that.category,_that.reviewStatus,_that.audioSrc,_that.reference,_that.notes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String titleBn,  String titleEn,  String arabic,  String uccharonBn,  String banglish,  String meaningBn,  String? meaningEn,  ContentDuaCategory category,  ContentReviewStatus reviewStatus,  String? audioSrc,  ContentReference? reference,  String? notes)  $default,) {final _that = this;
switch (_that) {
case _ContentDua():
return $default(_that.id,_that.titleBn,_that.titleEn,_that.arabic,_that.uccharonBn,_that.banglish,_that.meaningBn,_that.meaningEn,_that.category,_that.reviewStatus,_that.audioSrc,_that.reference,_that.notes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String titleBn,  String titleEn,  String arabic,  String uccharonBn,  String banglish,  String meaningBn,  String? meaningEn,  ContentDuaCategory category,  ContentReviewStatus reviewStatus,  String? audioSrc,  ContentReference? reference,  String? notes)?  $default,) {final _that = this;
switch (_that) {
case _ContentDua() when $default != null:
return $default(_that.id,_that.titleBn,_that.titleEn,_that.arabic,_that.uccharonBn,_that.banglish,_that.meaningBn,_that.meaningEn,_that.category,_that.reviewStatus,_that.audioSrc,_that.reference,_that.notes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ContentDua implements ContentDua {
  const _ContentDua({required this.id, required this.titleBn, this.titleEn = '', required this.arabic, required this.uccharonBn, required this.banglish, required this.meaningBn, this.meaningEn, required this.category, this.reviewStatus = ContentReviewStatus.verified, this.audioSrc, this.reference, this.notes});
  factory _ContentDua.fromJson(Map<String, dynamic> json) => _$ContentDuaFromJson(json);

@override final  String id;
@override final  String titleBn;
@override@JsonKey() final  String titleEn;
@override final  String arabic;
@override final  String uccharonBn;
@override final  String banglish;
@override final  String meaningBn;
@override final  String? meaningEn;
@override final  ContentDuaCategory category;
@override@JsonKey() final  ContentReviewStatus reviewStatus;
@override final  String? audioSrc;
@override final  ContentReference? reference;
@override final  String? notes;

/// Create a copy of ContentDua
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ContentDuaCopyWith<_ContentDua> get copyWith => __$ContentDuaCopyWithImpl<_ContentDua>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ContentDuaToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ContentDua&&(identical(other.id, id) || other.id == id)&&(identical(other.titleBn, titleBn) || other.titleBn == titleBn)&&(identical(other.titleEn, titleEn) || other.titleEn == titleEn)&&(identical(other.arabic, arabic) || other.arabic == arabic)&&(identical(other.uccharonBn, uccharonBn) || other.uccharonBn == uccharonBn)&&(identical(other.banglish, banglish) || other.banglish == banglish)&&(identical(other.meaningBn, meaningBn) || other.meaningBn == meaningBn)&&(identical(other.meaningEn, meaningEn) || other.meaningEn == meaningEn)&&(identical(other.category, category) || other.category == category)&&(identical(other.reviewStatus, reviewStatus) || other.reviewStatus == reviewStatus)&&(identical(other.audioSrc, audioSrc) || other.audioSrc == audioSrc)&&(identical(other.reference, reference) || other.reference == reference)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,titleBn,titleEn,arabic,uccharonBn,banglish,meaningBn,meaningEn,category,reviewStatus,audioSrc,reference,notes);
}

@override
String toString() {
    return 'ContentDua(id: $id, titleBn: $titleBn, titleEn: $titleEn, arabic: $arabic, uccharonBn: $uccharonBn, banglish: $banglish, meaningBn: $meaningBn, meaningEn: $meaningEn, category: $category, reviewStatus: $reviewStatus, audioSrc: $audioSrc, reference: $reference, notes: $notes)';
}


}

/// @nodoc
abstract mixin class _$ContentDuaCopyWith<$Res> implements $ContentDuaCopyWith<$Res> {
  factory _$ContentDuaCopyWith(_ContentDua value, $Res Function(_ContentDua) _then) = __$ContentDuaCopyWithImpl;
@override @useResult
$Res call({
 String id, String titleBn, String titleEn, String arabic, String uccharonBn, String banglish, String meaningBn, String? meaningEn, ContentDuaCategory category, ContentReviewStatus reviewStatus, String? audioSrc, ContentReference? reference, String? notes
});


@override $ContentReferenceCopyWith<$Res>? get reference;

}
/// @nodoc
class __$ContentDuaCopyWithImpl<$Res>
    implements _$ContentDuaCopyWith<$Res> {
  __$ContentDuaCopyWithImpl(this._self, this._then);

  final _ContentDua _self;
  final $Res Function(_ContentDua) _then;

/// Create a copy of ContentDua
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? titleBn = null,Object? titleEn = null,Object? arabic = null,Object? uccharonBn = null,Object? banglish = null,Object? meaningBn = null,Object? meaningEn = freezed,Object? category = null,Object? reviewStatus = null,Object? audioSrc = freezed,Object? reference = freezed,Object? notes = freezed,}) {
  return _then(_ContentDua(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,titleBn: null == titleBn ? _self.titleBn : titleBn // ignore: cast_nullable_to_non_nullable
as String,titleEn: null == titleEn ? _self.titleEn : titleEn // ignore: cast_nullable_to_non_nullable
as String,arabic: null == arabic ? _self.arabic : arabic // ignore: cast_nullable_to_non_nullable
as String,uccharonBn: null == uccharonBn ? _self.uccharonBn : uccharonBn // ignore: cast_nullable_to_non_nullable
as String,banglish: null == banglish ? _self.banglish : banglish // ignore: cast_nullable_to_non_nullable
as String,meaningBn: null == meaningBn ? _self.meaningBn : meaningBn // ignore: cast_nullable_to_non_nullable
as String,meaningEn: freezed == meaningEn ? _self.meaningEn : meaningEn // ignore: cast_nullable_to_non_nullable
as String?,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as ContentDuaCategory,reviewStatus: null == reviewStatus ? _self.reviewStatus : reviewStatus // ignore: cast_nullable_to_non_nullable
as ContentReviewStatus,audioSrc: freezed == audioSrc ? _self.audioSrc : audioSrc // ignore: cast_nullable_to_non_nullable
as String?,reference: freezed == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as ContentReference?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of ContentDua
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ContentReferenceCopyWith<$Res>? get reference {
    if (_self.reference == null) {
    return null;
  }

  return $ContentReferenceCopyWith<$Res>(_self.reference!, (value) {
    return _then(_self.copyWith(reference: value));
  });
}
}

// dart format on
