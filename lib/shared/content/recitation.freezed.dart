// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recitation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ContentRecitation {

 String get id; String get titleBn; String get titleEn; String get arabic; String get uccharonBn; String get banglish; String get meaningBn; String? get meaningEn; String? get audioSrc; ContentReference? get reference; String? get notes;
/// Create a copy of ContentRecitation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContentRecitationCopyWith<ContentRecitation> get copyWith => _$ContentRecitationCopyWithImpl<ContentRecitation>(this as ContentRecitation, _$identity);

  /// Serializes this ContentRecitation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ContentRecitation;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContentRecitation&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.titleBn, _this.titleBn) || other.titleBn == _this.titleBn)&&(identical(other.titleEn, _this.titleEn) || other.titleEn == _this.titleEn)&&(identical(other.arabic, _this.arabic) || other.arabic == _this.arabic)&&(identical(other.uccharonBn, _this.uccharonBn) || other.uccharonBn == _this.uccharonBn)&&(identical(other.banglish, _this.banglish) || other.banglish == _this.banglish)&&(identical(other.meaningBn, _this.meaningBn) || other.meaningBn == _this.meaningBn)&&(identical(other.meaningEn, _this.meaningEn) || other.meaningEn == _this.meaningEn)&&(identical(other.audioSrc, _this.audioSrc) || other.audioSrc == _this.audioSrc)&&(identical(other.reference, _this.reference) || other.reference == _this.reference)&&(identical(other.notes, _this.notes) || other.notes == _this.notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ContentRecitation;
  return Object.hash(runtimeType,_this.id,_this.titleBn,_this.titleEn,_this.arabic,_this.uccharonBn,_this.banglish,_this.meaningBn,_this.meaningEn,_this.audioSrc,_this.reference,_this.notes);
}

@override
String toString() {
  final _this = this as ContentRecitation;
  return 'ContentRecitation(id: ${_this.id}, titleBn: ${_this.titleBn}, titleEn: ${_this.titleEn}, arabic: ${_this.arabic}, uccharonBn: ${_this.uccharonBn}, banglish: ${_this.banglish}, meaningBn: ${_this.meaningBn}, meaningEn: ${_this.meaningEn}, audioSrc: ${_this.audioSrc}, reference: ${_this.reference}, notes: ${_this.notes})';
}


}

/// @nodoc
abstract mixin class $ContentRecitationCopyWith<$Res>  {
  factory $ContentRecitationCopyWith(ContentRecitation value, $Res Function(ContentRecitation) _then) = _$ContentRecitationCopyWithImpl;
@useResult
$Res call({
 String id, String titleBn, String titleEn, String arabic, String uccharonBn, String banglish, String meaningBn, String? meaningEn, String? audioSrc, ContentReference? reference, String? notes
});


$ContentReferenceCopyWith<$Res>? get reference;

}
/// @nodoc
class _$ContentRecitationCopyWithImpl<$Res>
    implements $ContentRecitationCopyWith<$Res> {
  _$ContentRecitationCopyWithImpl(this._self, this._then);

  final ContentRecitation _self;
  final $Res Function(ContentRecitation) _then;

/// Create a copy of ContentRecitation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? titleBn = null,Object? titleEn = null,Object? arabic = null,Object? uccharonBn = null,Object? banglish = null,Object? meaningBn = null,Object? meaningEn = freezed,Object? audioSrc = freezed,Object? reference = freezed,Object? notes = freezed,}) {
  return _then(ContentRecitation(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,titleBn: null == titleBn ? _self.titleBn : titleBn // ignore: cast_nullable_to_non_nullable
as String,titleEn: null == titleEn ? _self.titleEn : titleEn // ignore: cast_nullable_to_non_nullable
as String,arabic: null == arabic ? _self.arabic : arabic // ignore: cast_nullable_to_non_nullable
as String,uccharonBn: null == uccharonBn ? _self.uccharonBn : uccharonBn // ignore: cast_nullable_to_non_nullable
as String,banglish: null == banglish ? _self.banglish : banglish // ignore: cast_nullable_to_non_nullable
as String,meaningBn: null == meaningBn ? _self.meaningBn : meaningBn // ignore: cast_nullable_to_non_nullable
as String,meaningEn: freezed == meaningEn ? _self.meaningEn : meaningEn // ignore: cast_nullable_to_non_nullable
as String?,audioSrc: freezed == audioSrc ? _self.audioSrc : audioSrc // ignore: cast_nullable_to_non_nullable
as String?,reference: freezed == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as ContentReference?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of ContentRecitation
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


/// Adds pattern-matching-related methods to [ContentRecitation].
extension ContentRecitationPatterns on ContentRecitation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ContentRecitation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ContentRecitation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ContentRecitation value)  $default,){
final _that = this;
switch (_that) {
case _ContentRecitation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ContentRecitation value)?  $default,){
final _that = this;
switch (_that) {
case _ContentRecitation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String titleBn,  String titleEn,  String arabic,  String uccharonBn,  String banglish,  String meaningBn,  String? meaningEn,  String? audioSrc,  ContentReference? reference,  String? notes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ContentRecitation() when $default != null:
return $default(_that.id,_that.titleBn,_that.titleEn,_that.arabic,_that.uccharonBn,_that.banglish,_that.meaningBn,_that.meaningEn,_that.audioSrc,_that.reference,_that.notes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String titleBn,  String titleEn,  String arabic,  String uccharonBn,  String banglish,  String meaningBn,  String? meaningEn,  String? audioSrc,  ContentReference? reference,  String? notes)  $default,) {final _that = this;
switch (_that) {
case _ContentRecitation():
return $default(_that.id,_that.titleBn,_that.titleEn,_that.arabic,_that.uccharonBn,_that.banglish,_that.meaningBn,_that.meaningEn,_that.audioSrc,_that.reference,_that.notes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String titleBn,  String titleEn,  String arabic,  String uccharonBn,  String banglish,  String meaningBn,  String? meaningEn,  String? audioSrc,  ContentReference? reference,  String? notes)?  $default,) {final _that = this;
switch (_that) {
case _ContentRecitation() when $default != null:
return $default(_that.id,_that.titleBn,_that.titleEn,_that.arabic,_that.uccharonBn,_that.banglish,_that.meaningBn,_that.meaningEn,_that.audioSrc,_that.reference,_that.notes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ContentRecitation implements ContentRecitation {
  const _ContentRecitation({required this.id, required this.titleBn, this.titleEn = '', required this.arabic, required this.uccharonBn, required this.banglish, required this.meaningBn, this.meaningEn, this.audioSrc, this.reference, this.notes});
  factory _ContentRecitation.fromJson(Map<String, dynamic> json) => _$ContentRecitationFromJson(json);

@override final  String id;
@override final  String titleBn;
@override@JsonKey() final  String titleEn;
@override final  String arabic;
@override final  String uccharonBn;
@override final  String banglish;
@override final  String meaningBn;
@override final  String? meaningEn;
@override final  String? audioSrc;
@override final  ContentReference? reference;
@override final  String? notes;

/// Create a copy of ContentRecitation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ContentRecitationCopyWith<_ContentRecitation> get copyWith => __$ContentRecitationCopyWithImpl<_ContentRecitation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ContentRecitationToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ContentRecitation&&(identical(other.id, id) || other.id == id)&&(identical(other.titleBn, titleBn) || other.titleBn == titleBn)&&(identical(other.titleEn, titleEn) || other.titleEn == titleEn)&&(identical(other.arabic, arabic) || other.arabic == arabic)&&(identical(other.uccharonBn, uccharonBn) || other.uccharonBn == uccharonBn)&&(identical(other.banglish, banglish) || other.banglish == banglish)&&(identical(other.meaningBn, meaningBn) || other.meaningBn == meaningBn)&&(identical(other.meaningEn, meaningEn) || other.meaningEn == meaningEn)&&(identical(other.audioSrc, audioSrc) || other.audioSrc == audioSrc)&&(identical(other.reference, reference) || other.reference == reference)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,titleBn,titleEn,arabic,uccharonBn,banglish,meaningBn,meaningEn,audioSrc,reference,notes);
}

@override
String toString() {
    return 'ContentRecitation(id: $id, titleBn: $titleBn, titleEn: $titleEn, arabic: $arabic, uccharonBn: $uccharonBn, banglish: $banglish, meaningBn: $meaningBn, meaningEn: $meaningEn, audioSrc: $audioSrc, reference: $reference, notes: $notes)';
}


}

/// @nodoc
abstract mixin class _$ContentRecitationCopyWith<$Res> implements $ContentRecitationCopyWith<$Res> {
  factory _$ContentRecitationCopyWith(_ContentRecitation value, $Res Function(_ContentRecitation) _then) = __$ContentRecitationCopyWithImpl;
@override @useResult
$Res call({
 String id, String titleBn, String titleEn, String arabic, String uccharonBn, String banglish, String meaningBn, String? meaningEn, String? audioSrc, ContentReference? reference, String? notes
});


@override $ContentReferenceCopyWith<$Res>? get reference;

}
/// @nodoc
class __$ContentRecitationCopyWithImpl<$Res>
    implements _$ContentRecitationCopyWith<$Res> {
  __$ContentRecitationCopyWithImpl(this._self, this._then);

  final _ContentRecitation _self;
  final $Res Function(_ContentRecitation) _then;

/// Create a copy of ContentRecitation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? titleBn = null,Object? titleEn = null,Object? arabic = null,Object? uccharonBn = null,Object? banglish = null,Object? meaningBn = null,Object? meaningEn = freezed,Object? audioSrc = freezed,Object? reference = freezed,Object? notes = freezed,}) {
  return _then(_ContentRecitation(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,titleBn: null == titleBn ? _self.titleBn : titleBn // ignore: cast_nullable_to_non_nullable
as String,titleEn: null == titleEn ? _self.titleEn : titleEn // ignore: cast_nullable_to_non_nullable
as String,arabic: null == arabic ? _self.arabic : arabic // ignore: cast_nullable_to_non_nullable
as String,uccharonBn: null == uccharonBn ? _self.uccharonBn : uccharonBn // ignore: cast_nullable_to_non_nullable
as String,banglish: null == banglish ? _self.banglish : banglish // ignore: cast_nullable_to_non_nullable
as String,meaningBn: null == meaningBn ? _self.meaningBn : meaningBn // ignore: cast_nullable_to_non_nullable
as String,meaningEn: freezed == meaningEn ? _self.meaningEn : meaningEn // ignore: cast_nullable_to_non_nullable
as String?,audioSrc: freezed == audioSrc ? _self.audioSrc : audioSrc // ignore: cast_nullable_to_non_nullable
as String?,reference: freezed == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as ContentReference?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of ContentRecitation
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
