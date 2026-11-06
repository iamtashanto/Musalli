// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'surah.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ContentFazilat {

 String get textBn; ContentReference? get reference;
/// Create a copy of ContentFazilat
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContentFazilatCopyWith<ContentFazilat> get copyWith => _$ContentFazilatCopyWithImpl<ContentFazilat>(this as ContentFazilat, _$identity);

  /// Serializes this ContentFazilat to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ContentFazilat;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContentFazilat&&(identical(other.textBn, _this.textBn) || other.textBn == _this.textBn)&&(identical(other.reference, _this.reference) || other.reference == _this.reference));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ContentFazilat;
  return Object.hash(runtimeType,_this.textBn,_this.reference);
}

@override
String toString() {
  final _this = this as ContentFazilat;
  return 'ContentFazilat(textBn: ${_this.textBn}, reference: ${_this.reference})';
}


}

/// @nodoc
abstract mixin class $ContentFazilatCopyWith<$Res>  {
  factory $ContentFazilatCopyWith(ContentFazilat value, $Res Function(ContentFazilat) _then) = _$ContentFazilatCopyWithImpl;
@useResult
$Res call({
 String textBn, ContentReference? reference
});


$ContentReferenceCopyWith<$Res>? get reference;

}
/// @nodoc
class _$ContentFazilatCopyWithImpl<$Res>
    implements $ContentFazilatCopyWith<$Res> {
  _$ContentFazilatCopyWithImpl(this._self, this._then);

  final ContentFazilat _self;
  final $Res Function(ContentFazilat) _then;

/// Create a copy of ContentFazilat
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? textBn = null,Object? reference = freezed,}) {
  return _then(ContentFazilat(
textBn: null == textBn ? _self.textBn : textBn // ignore: cast_nullable_to_non_nullable
as String,reference: freezed == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as ContentReference?,
  ));
}
/// Create a copy of ContentFazilat
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


/// Adds pattern-matching-related methods to [ContentFazilat].
extension ContentFazilatPatterns on ContentFazilat {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ContentFazilat value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ContentFazilat() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ContentFazilat value)  $default,){
final _that = this;
switch (_that) {
case _ContentFazilat():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ContentFazilat value)?  $default,){
final _that = this;
switch (_that) {
case _ContentFazilat() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String textBn,  ContentReference? reference)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ContentFazilat() when $default != null:
return $default(_that.textBn,_that.reference);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String textBn,  ContentReference? reference)  $default,) {final _that = this;
switch (_that) {
case _ContentFazilat():
return $default(_that.textBn,_that.reference);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String textBn,  ContentReference? reference)?  $default,) {final _that = this;
switch (_that) {
case _ContentFazilat() when $default != null:
return $default(_that.textBn,_that.reference);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ContentFazilat implements ContentFazilat {
  const _ContentFazilat({required this.textBn, this.reference});
  factory _ContentFazilat.fromJson(Map<String, dynamic> json) => _$ContentFazilatFromJson(json);

@override final  String textBn;
@override final  ContentReference? reference;

/// Create a copy of ContentFazilat
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ContentFazilatCopyWith<_ContentFazilat> get copyWith => __$ContentFazilatCopyWithImpl<_ContentFazilat>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ContentFazilatToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ContentFazilat&&(identical(other.textBn, textBn) || other.textBn == textBn)&&(identical(other.reference, reference) || other.reference == reference));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,textBn,reference);
}

@override
String toString() {
    return 'ContentFazilat(textBn: $textBn, reference: $reference)';
}


}

/// @nodoc
abstract mixin class _$ContentFazilatCopyWith<$Res> implements $ContentFazilatCopyWith<$Res> {
  factory _$ContentFazilatCopyWith(_ContentFazilat value, $Res Function(_ContentFazilat) _then) = __$ContentFazilatCopyWithImpl;
@override @useResult
$Res call({
 String textBn, ContentReference? reference
});


@override $ContentReferenceCopyWith<$Res>? get reference;

}
/// @nodoc
class __$ContentFazilatCopyWithImpl<$Res>
    implements _$ContentFazilatCopyWith<$Res> {
  __$ContentFazilatCopyWithImpl(this._self, this._then);

  final _ContentFazilat _self;
  final $Res Function(_ContentFazilat) _then;

/// Create a copy of ContentFazilat
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? textBn = null,Object? reference = freezed,}) {
  return _then(_ContentFazilat(
textBn: null == textBn ? _self.textBn : textBn // ignore: cast_nullable_to_non_nullable
as String,reference: freezed == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as ContentReference?,
  ));
}

/// Create a copy of ContentFazilat
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


/// @nodoc
mixin _$ContentSurah {

 String get id; int get number; String get nameBn; String get nameAr; String get nameEn; int get ayahCount; List<ContentRecitation> get ayahs; String get audioSrc; ContentRevelationType get revelation; ContentFazilat? get fazilat;
/// Create a copy of ContentSurah
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContentSurahCopyWith<ContentSurah> get copyWith => _$ContentSurahCopyWithImpl<ContentSurah>(this as ContentSurah, _$identity);

  /// Serializes this ContentSurah to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ContentSurah;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContentSurah&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.number, _this.number) || other.number == _this.number)&&(identical(other.nameBn, _this.nameBn) || other.nameBn == _this.nameBn)&&(identical(other.nameAr, _this.nameAr) || other.nameAr == _this.nameAr)&&(identical(other.nameEn, _this.nameEn) || other.nameEn == _this.nameEn)&&(identical(other.ayahCount, _this.ayahCount) || other.ayahCount == _this.ayahCount)&&const DeepCollectionEquality().equals(other.ayahs, _this.ayahs)&&(identical(other.audioSrc, _this.audioSrc) || other.audioSrc == _this.audioSrc)&&(identical(other.revelation, _this.revelation) || other.revelation == _this.revelation)&&(identical(other.fazilat, _this.fazilat) || other.fazilat == _this.fazilat));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ContentSurah;
  return Object.hash(runtimeType,_this.id,_this.number,_this.nameBn,_this.nameAr,_this.nameEn,_this.ayahCount,const DeepCollectionEquality().hash(_this.ayahs),_this.audioSrc,_this.revelation,_this.fazilat);
}

@override
String toString() {
  final _this = this as ContentSurah;
  return 'ContentSurah(id: ${_this.id}, number: ${_this.number}, nameBn: ${_this.nameBn}, nameAr: ${_this.nameAr}, nameEn: ${_this.nameEn}, ayahCount: ${_this.ayahCount}, ayahs: ${_this.ayahs}, audioSrc: ${_this.audioSrc}, revelation: ${_this.revelation}, fazilat: ${_this.fazilat})';
}


}

/// @nodoc
abstract mixin class $ContentSurahCopyWith<$Res>  {
  factory $ContentSurahCopyWith(ContentSurah value, $Res Function(ContentSurah) _then) = _$ContentSurahCopyWithImpl;
@useResult
$Res call({
 String id, int number, String nameBn, String nameAr, String nameEn, int ayahCount, List<ContentRecitation> ayahs, String audioSrc, ContentRevelationType revelation, ContentFazilat? fazilat
});


$ContentFazilatCopyWith<$Res>? get fazilat;

}
/// @nodoc
class _$ContentSurahCopyWithImpl<$Res>
    implements $ContentSurahCopyWith<$Res> {
  _$ContentSurahCopyWithImpl(this._self, this._then);

  final ContentSurah _self;
  final $Res Function(ContentSurah) _then;

/// Create a copy of ContentSurah
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? number = null,Object? nameBn = null,Object? nameAr = null,Object? nameEn = null,Object? ayahCount = null,Object? ayahs = null,Object? audioSrc = null,Object? revelation = null,Object? fazilat = freezed,}) {
  return _then(ContentSurah(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int,nameBn: null == nameBn ? _self.nameBn : nameBn // ignore: cast_nullable_to_non_nullable
as String,nameAr: null == nameAr ? _self.nameAr : nameAr // ignore: cast_nullable_to_non_nullable
as String,nameEn: null == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String,ayahCount: null == ayahCount ? _self.ayahCount : ayahCount // ignore: cast_nullable_to_non_nullable
as int,ayahs: null == ayahs ? _self.ayahs : ayahs // ignore: cast_nullable_to_non_nullable
as List<ContentRecitation>,audioSrc: null == audioSrc ? _self.audioSrc : audioSrc // ignore: cast_nullable_to_non_nullable
as String,revelation: null == revelation ? _self.revelation : revelation // ignore: cast_nullable_to_non_nullable
as ContentRevelationType,fazilat: freezed == fazilat ? _self.fazilat : fazilat // ignore: cast_nullable_to_non_nullable
as ContentFazilat?,
  ));
}
/// Create a copy of ContentSurah
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ContentFazilatCopyWith<$Res>? get fazilat {
    if (_self.fazilat == null) {
    return null;
  }

  return $ContentFazilatCopyWith<$Res>(_self.fazilat!, (value) {
    return _then(_self.copyWith(fazilat: value));
  });
}
}


/// Adds pattern-matching-related methods to [ContentSurah].
extension ContentSurahPatterns on ContentSurah {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ContentSurah value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ContentSurah() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ContentSurah value)  $default,){
final _that = this;
switch (_that) {
case _ContentSurah():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ContentSurah value)?  $default,){
final _that = this;
switch (_that) {
case _ContentSurah() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  int number,  String nameBn,  String nameAr,  String nameEn,  int ayahCount,  List<ContentRecitation> ayahs,  String audioSrc,  ContentRevelationType revelation,  ContentFazilat? fazilat)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ContentSurah() when $default != null:
return $default(_that.id,_that.number,_that.nameBn,_that.nameAr,_that.nameEn,_that.ayahCount,_that.ayahs,_that.audioSrc,_that.revelation,_that.fazilat);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  int number,  String nameBn,  String nameAr,  String nameEn,  int ayahCount,  List<ContentRecitation> ayahs,  String audioSrc,  ContentRevelationType revelation,  ContentFazilat? fazilat)  $default,) {final _that = this;
switch (_that) {
case _ContentSurah():
return $default(_that.id,_that.number,_that.nameBn,_that.nameAr,_that.nameEn,_that.ayahCount,_that.ayahs,_that.audioSrc,_that.revelation,_that.fazilat);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  int number,  String nameBn,  String nameAr,  String nameEn,  int ayahCount,  List<ContentRecitation> ayahs,  String audioSrc,  ContentRevelationType revelation,  ContentFazilat? fazilat)?  $default,) {final _that = this;
switch (_that) {
case _ContentSurah() when $default != null:
return $default(_that.id,_that.number,_that.nameBn,_that.nameAr,_that.nameEn,_that.ayahCount,_that.ayahs,_that.audioSrc,_that.revelation,_that.fazilat);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ContentSurah implements ContentSurah {
  const _ContentSurah({required this.id, required this.number, required this.nameBn, required this.nameAr, required this.nameEn, required this.ayahCount,  List<ContentRecitation> ayahs = const <ContentRecitation>[], this.audioSrc = '', this.revelation = ContentRevelationType.makki, this.fazilat}): _ayahs = ayahs;
  factory _ContentSurah.fromJson(Map<String, dynamic> json) => _$ContentSurahFromJson(json);

@override final  String id;
@override final  int number;
@override final  String nameBn;
@override final  String nameAr;
@override final  String nameEn;
@override final  int ayahCount;
 final  List<ContentRecitation> _ayahs;
@override@JsonKey() List<ContentRecitation> get ayahs {
  if (_ayahs is EqualUnmodifiableListView) return _ayahs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_ayahs);
}

@override@JsonKey() final  String audioSrc;
@override@JsonKey() final  ContentRevelationType revelation;
@override final  ContentFazilat? fazilat;

/// Create a copy of ContentSurah
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ContentSurahCopyWith<_ContentSurah> get copyWith => __$ContentSurahCopyWithImpl<_ContentSurah>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ContentSurahToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ContentSurah&&(identical(other.id, id) || other.id == id)&&(identical(other.number, number) || other.number == number)&&(identical(other.nameBn, nameBn) || other.nameBn == nameBn)&&(identical(other.nameAr, nameAr) || other.nameAr == nameAr)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.ayahCount, ayahCount) || other.ayahCount == ayahCount)&&const DeepCollectionEquality().equals(other.ayahs, _ayahs)&&(identical(other.audioSrc, audioSrc) || other.audioSrc == audioSrc)&&(identical(other.revelation, revelation) || other.revelation == revelation)&&(identical(other.fazilat, fazilat) || other.fazilat == fazilat));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,number,nameBn,nameAr,nameEn,ayahCount,const DeepCollectionEquality().hash(_ayahs),audioSrc,revelation,fazilat);
}

@override
String toString() {
    return 'ContentSurah(id: $id, number: $number, nameBn: $nameBn, nameAr: $nameAr, nameEn: $nameEn, ayahCount: $ayahCount, ayahs: $ayahs, audioSrc: $audioSrc, revelation: $revelation, fazilat: $fazilat)';
}


}

/// @nodoc
abstract mixin class _$ContentSurahCopyWith<$Res> implements $ContentSurahCopyWith<$Res> {
  factory _$ContentSurahCopyWith(_ContentSurah value, $Res Function(_ContentSurah) _then) = __$ContentSurahCopyWithImpl;
@override @useResult
$Res call({
 String id, int number, String nameBn, String nameAr, String nameEn, int ayahCount, List<ContentRecitation> ayahs, String audioSrc, ContentRevelationType revelation, ContentFazilat? fazilat
});


@override $ContentFazilatCopyWith<$Res>? get fazilat;

}
/// @nodoc
class __$ContentSurahCopyWithImpl<$Res>
    implements _$ContentSurahCopyWith<$Res> {
  __$ContentSurahCopyWithImpl(this._self, this._then);

  final _ContentSurah _self;
  final $Res Function(_ContentSurah) _then;

/// Create a copy of ContentSurah
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? number = null,Object? nameBn = null,Object? nameAr = null,Object? nameEn = null,Object? ayahCount = null,Object? ayahs = null,Object? audioSrc = null,Object? revelation = null,Object? fazilat = freezed,}) {
  return _then(_ContentSurah(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int,nameBn: null == nameBn ? _self.nameBn : nameBn // ignore: cast_nullable_to_non_nullable
as String,nameAr: null == nameAr ? _self.nameAr : nameAr // ignore: cast_nullable_to_non_nullable
as String,nameEn: null == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String,ayahCount: null == ayahCount ? _self.ayahCount : ayahCount // ignore: cast_nullable_to_non_nullable
as int,ayahs: null == ayahs ? _self._ayahs : ayahs // ignore: cast_nullable_to_non_nullable
as List<ContentRecitation>,audioSrc: null == audioSrc ? _self.audioSrc : audioSrc // ignore: cast_nullable_to_non_nullable
as String,revelation: null == revelation ? _self.revelation : revelation // ignore: cast_nullable_to_non_nullable
as ContentRevelationType,fazilat: freezed == fazilat ? _self.fazilat : fazilat // ignore: cast_nullable_to_non_nullable
as ContentFazilat?,
  ));
}

/// Create a copy of ContentSurah
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ContentFazilatCopyWith<$Res>? get fazilat {
    if (_self.fazilat == null) {
    return null;
  }

  return $ContentFazilatCopyWith<$Res>(_self.fazilat!, (value) {
    return _then(_self.copyWith(fazilat: value));
  });
}
}


/// @nodoc
mixin _$QuranSurahSummary {

 int get number;@JsonKey(name: 'name_arabic') String get nameArabic;@JsonKey(name: 'name_bangla') String get nameBangla;@JsonKey(name: 'name_english') String get nameEnglish;@JsonKey(name: 'name_banglish') String get nameBanglish;@JsonKey(name: 'total_ayah') int get totalAyah;@JsonKey(name: 'revelation_type') String get revelationType;@JsonKey(name: 'revelation_type_en') String get revelationTypeEn;@JsonKey(name: 'audio_url') String? get audioUrl;
/// Create a copy of QuranSurahSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuranSurahSummaryCopyWith<QuranSurahSummary> get copyWith => _$QuranSurahSummaryCopyWithImpl<QuranSurahSummary>(this as QuranSurahSummary, _$identity);

  /// Serializes this QuranSurahSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as QuranSurahSummary;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuranSurahSummary&&(identical(other.number, _this.number) || other.number == _this.number)&&(identical(other.nameArabic, _this.nameArabic) || other.nameArabic == _this.nameArabic)&&(identical(other.nameBangla, _this.nameBangla) || other.nameBangla == _this.nameBangla)&&(identical(other.nameEnglish, _this.nameEnglish) || other.nameEnglish == _this.nameEnglish)&&(identical(other.nameBanglish, _this.nameBanglish) || other.nameBanglish == _this.nameBanglish)&&(identical(other.totalAyah, _this.totalAyah) || other.totalAyah == _this.totalAyah)&&(identical(other.revelationType, _this.revelationType) || other.revelationType == _this.revelationType)&&(identical(other.revelationTypeEn, _this.revelationTypeEn) || other.revelationTypeEn == _this.revelationTypeEn)&&(identical(other.audioUrl, _this.audioUrl) || other.audioUrl == _this.audioUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as QuranSurahSummary;
  return Object.hash(runtimeType,_this.number,_this.nameArabic,_this.nameBangla,_this.nameEnglish,_this.nameBanglish,_this.totalAyah,_this.revelationType,_this.revelationTypeEn,_this.audioUrl);
}

@override
String toString() {
  final _this = this as QuranSurahSummary;
  return 'QuranSurahSummary(number: ${_this.number}, nameArabic: ${_this.nameArabic}, nameBangla: ${_this.nameBangla}, nameEnglish: ${_this.nameEnglish}, nameBanglish: ${_this.nameBanglish}, totalAyah: ${_this.totalAyah}, revelationType: ${_this.revelationType}, revelationTypeEn: ${_this.revelationTypeEn}, audioUrl: ${_this.audioUrl})';
}


}

/// @nodoc
abstract mixin class $QuranSurahSummaryCopyWith<$Res>  {
  factory $QuranSurahSummaryCopyWith(QuranSurahSummary value, $Res Function(QuranSurahSummary) _then) = _$QuranSurahSummaryCopyWithImpl;
@useResult
$Res call({
 int number,@JsonKey(name: 'name_arabic') String nameArabic,@JsonKey(name: 'name_bangla') String nameBangla,@JsonKey(name: 'name_english') String nameEnglish,@JsonKey(name: 'name_banglish') String nameBanglish,@JsonKey(name: 'total_ayah') int totalAyah,@JsonKey(name: 'revelation_type') String revelationType,@JsonKey(name: 'revelation_type_en') String revelationTypeEn,@JsonKey(name: 'audio_url') String? audioUrl
});




}
/// @nodoc
class _$QuranSurahSummaryCopyWithImpl<$Res>
    implements $QuranSurahSummaryCopyWith<$Res> {
  _$QuranSurahSummaryCopyWithImpl(this._self, this._then);

  final QuranSurahSummary _self;
  final $Res Function(QuranSurahSummary) _then;

/// Create a copy of QuranSurahSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? number = null,Object? nameArabic = null,Object? nameBangla = null,Object? nameEnglish = null,Object? nameBanglish = null,Object? totalAyah = null,Object? revelationType = null,Object? revelationTypeEn = null,Object? audioUrl = freezed,}) {
  return _then(QuranSurahSummary(
number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int,nameArabic: null == nameArabic ? _self.nameArabic : nameArabic // ignore: cast_nullable_to_non_nullable
as String,nameBangla: null == nameBangla ? _self.nameBangla : nameBangla // ignore: cast_nullable_to_non_nullable
as String,nameEnglish: null == nameEnglish ? _self.nameEnglish : nameEnglish // ignore: cast_nullable_to_non_nullable
as String,nameBanglish: null == nameBanglish ? _self.nameBanglish : nameBanglish // ignore: cast_nullable_to_non_nullable
as String,totalAyah: null == totalAyah ? _self.totalAyah : totalAyah // ignore: cast_nullable_to_non_nullable
as int,revelationType: null == revelationType ? _self.revelationType : revelationType // ignore: cast_nullable_to_non_nullable
as String,revelationTypeEn: null == revelationTypeEn ? _self.revelationTypeEn : revelationTypeEn // ignore: cast_nullable_to_non_nullable
as String,audioUrl: freezed == audioUrl ? _self.audioUrl : audioUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [QuranSurahSummary].
extension QuranSurahSummaryPatterns on QuranSurahSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuranSurahSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuranSurahSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuranSurahSummary value)  $default,){
final _that = this;
switch (_that) {
case _QuranSurahSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuranSurahSummary value)?  $default,){
final _that = this;
switch (_that) {
case _QuranSurahSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int number, @JsonKey(name: 'name_arabic')  String nameArabic, @JsonKey(name: 'name_bangla')  String nameBangla, @JsonKey(name: 'name_english')  String nameEnglish, @JsonKey(name: 'name_banglish')  String nameBanglish, @JsonKey(name: 'total_ayah')  int totalAyah, @JsonKey(name: 'revelation_type')  String revelationType, @JsonKey(name: 'revelation_type_en')  String revelationTypeEn, @JsonKey(name: 'audio_url')  String? audioUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuranSurahSummary() when $default != null:
return $default(_that.number,_that.nameArabic,_that.nameBangla,_that.nameEnglish,_that.nameBanglish,_that.totalAyah,_that.revelationType,_that.revelationTypeEn,_that.audioUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int number, @JsonKey(name: 'name_arabic')  String nameArabic, @JsonKey(name: 'name_bangla')  String nameBangla, @JsonKey(name: 'name_english')  String nameEnglish, @JsonKey(name: 'name_banglish')  String nameBanglish, @JsonKey(name: 'total_ayah')  int totalAyah, @JsonKey(name: 'revelation_type')  String revelationType, @JsonKey(name: 'revelation_type_en')  String revelationTypeEn, @JsonKey(name: 'audio_url')  String? audioUrl)  $default,) {final _that = this;
switch (_that) {
case _QuranSurahSummary():
return $default(_that.number,_that.nameArabic,_that.nameBangla,_that.nameEnglish,_that.nameBanglish,_that.totalAyah,_that.revelationType,_that.revelationTypeEn,_that.audioUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int number, @JsonKey(name: 'name_arabic')  String nameArabic, @JsonKey(name: 'name_bangla')  String nameBangla, @JsonKey(name: 'name_english')  String nameEnglish, @JsonKey(name: 'name_banglish')  String nameBanglish, @JsonKey(name: 'total_ayah')  int totalAyah, @JsonKey(name: 'revelation_type')  String revelationType, @JsonKey(name: 'revelation_type_en')  String revelationTypeEn, @JsonKey(name: 'audio_url')  String? audioUrl)?  $default,) {final _that = this;
switch (_that) {
case _QuranSurahSummary() when $default != null:
return $default(_that.number,_that.nameArabic,_that.nameBangla,_that.nameEnglish,_that.nameBanglish,_that.totalAyah,_that.revelationType,_that.revelationTypeEn,_that.audioUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QuranSurahSummary implements QuranSurahSummary {
  const _QuranSurahSummary({required this.number, @JsonKey(name: 'name_arabic') required this.nameArabic, @JsonKey(name: 'name_bangla') required this.nameBangla, @JsonKey(name: 'name_english') required this.nameEnglish, @JsonKey(name: 'name_banglish') required this.nameBanglish, @JsonKey(name: 'total_ayah') required this.totalAyah, @JsonKey(name: 'revelation_type') required this.revelationType, @JsonKey(name: 'revelation_type_en') required this.revelationTypeEn, @JsonKey(name: 'audio_url') this.audioUrl});
  factory _QuranSurahSummary.fromJson(Map<String, dynamic> json) => _$QuranSurahSummaryFromJson(json);

@override final  int number;
@override@JsonKey(name: 'name_arabic') final  String nameArabic;
@override@JsonKey(name: 'name_bangla') final  String nameBangla;
@override@JsonKey(name: 'name_english') final  String nameEnglish;
@override@JsonKey(name: 'name_banglish') final  String nameBanglish;
@override@JsonKey(name: 'total_ayah') final  int totalAyah;
@override@JsonKey(name: 'revelation_type') final  String revelationType;
@override@JsonKey(name: 'revelation_type_en') final  String revelationTypeEn;
@override@JsonKey(name: 'audio_url') final  String? audioUrl;

/// Create a copy of QuranSurahSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuranSurahSummaryCopyWith<_QuranSurahSummary> get copyWith => __$QuranSurahSummaryCopyWithImpl<_QuranSurahSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QuranSurahSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuranSurahSummary&&(identical(other.number, number) || other.number == number)&&(identical(other.nameArabic, nameArabic) || other.nameArabic == nameArabic)&&(identical(other.nameBangla, nameBangla) || other.nameBangla == nameBangla)&&(identical(other.nameEnglish, nameEnglish) || other.nameEnglish == nameEnglish)&&(identical(other.nameBanglish, nameBanglish) || other.nameBanglish == nameBanglish)&&(identical(other.totalAyah, totalAyah) || other.totalAyah == totalAyah)&&(identical(other.revelationType, revelationType) || other.revelationType == revelationType)&&(identical(other.revelationTypeEn, revelationTypeEn) || other.revelationTypeEn == revelationTypeEn)&&(identical(other.audioUrl, audioUrl) || other.audioUrl == audioUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,number,nameArabic,nameBangla,nameEnglish,nameBanglish,totalAyah,revelationType,revelationTypeEn,audioUrl);
}

@override
String toString() {
    return 'QuranSurahSummary(number: $number, nameArabic: $nameArabic, nameBangla: $nameBangla, nameEnglish: $nameEnglish, nameBanglish: $nameBanglish, totalAyah: $totalAyah, revelationType: $revelationType, revelationTypeEn: $revelationTypeEn, audioUrl: $audioUrl)';
}


}

/// @nodoc
abstract mixin class _$QuranSurahSummaryCopyWith<$Res> implements $QuranSurahSummaryCopyWith<$Res> {
  factory _$QuranSurahSummaryCopyWith(_QuranSurahSummary value, $Res Function(_QuranSurahSummary) _then) = __$QuranSurahSummaryCopyWithImpl;
@override @useResult
$Res call({
 int number,@JsonKey(name: 'name_arabic') String nameArabic,@JsonKey(name: 'name_bangla') String nameBangla,@JsonKey(name: 'name_english') String nameEnglish,@JsonKey(name: 'name_banglish') String nameBanglish,@JsonKey(name: 'total_ayah') int totalAyah,@JsonKey(name: 'revelation_type') String revelationType,@JsonKey(name: 'revelation_type_en') String revelationTypeEn,@JsonKey(name: 'audio_url') String? audioUrl
});




}
/// @nodoc
class __$QuranSurahSummaryCopyWithImpl<$Res>
    implements _$QuranSurahSummaryCopyWith<$Res> {
  __$QuranSurahSummaryCopyWithImpl(this._self, this._then);

  final _QuranSurahSummary _self;
  final $Res Function(_QuranSurahSummary) _then;

/// Create a copy of QuranSurahSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? number = null,Object? nameArabic = null,Object? nameBangla = null,Object? nameEnglish = null,Object? nameBanglish = null,Object? totalAyah = null,Object? revelationType = null,Object? revelationTypeEn = null,Object? audioUrl = freezed,}) {
  return _then(_QuranSurahSummary(
number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int,nameArabic: null == nameArabic ? _self.nameArabic : nameArabic // ignore: cast_nullable_to_non_nullable
as String,nameBangla: null == nameBangla ? _self.nameBangla : nameBangla // ignore: cast_nullable_to_non_nullable
as String,nameEnglish: null == nameEnglish ? _self.nameEnglish : nameEnglish // ignore: cast_nullable_to_non_nullable
as String,nameBanglish: null == nameBanglish ? _self.nameBanglish : nameBanglish // ignore: cast_nullable_to_non_nullable
as String,totalAyah: null == totalAyah ? _self.totalAyah : totalAyah // ignore: cast_nullable_to_non_nullable
as int,revelationType: null == revelationType ? _self.revelationType : revelationType // ignore: cast_nullable_to_non_nullable
as String,revelationTypeEn: null == revelationTypeEn ? _self.revelationTypeEn : revelationTypeEn // ignore: cast_nullable_to_non_nullable
as String,audioUrl: freezed == audioUrl ? _self.audioUrl : audioUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
