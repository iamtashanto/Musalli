// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reference.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ContentReference {

 ReferenceType get type; String get source;@JsonKey(fromJson: _numberFromJson) String get number; ContentHadithGrade? get grade; String? get url;
/// Create a copy of ContentReference
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContentReferenceCopyWith<ContentReference> get copyWith => _$ContentReferenceCopyWithImpl<ContentReference>(this as ContentReference, _$identity);

  /// Serializes this ContentReference to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ContentReference;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContentReference&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.source, _this.source) || other.source == _this.source)&&(identical(other.number, _this.number) || other.number == _this.number)&&(identical(other.grade, _this.grade) || other.grade == _this.grade)&&(identical(other.url, _this.url) || other.url == _this.url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ContentReference;
  return Object.hash(runtimeType,_this.type,_this.source,_this.number,_this.grade,_this.url);
}

@override
String toString() {
  final _this = this as ContentReference;
  return 'ContentReference(type: ${_this.type}, source: ${_this.source}, number: ${_this.number}, grade: ${_this.grade}, url: ${_this.url})';
}


}

/// @nodoc
abstract mixin class $ContentReferenceCopyWith<$Res>  {
  factory $ContentReferenceCopyWith(ContentReference value, $Res Function(ContentReference) _then) = _$ContentReferenceCopyWithImpl;
@useResult
$Res call({
 ReferenceType type, String source,@JsonKey(fromJson: _numberFromJson) String number, ContentHadithGrade? grade, String? url
});




}
/// @nodoc
class _$ContentReferenceCopyWithImpl<$Res>
    implements $ContentReferenceCopyWith<$Res> {
  _$ContentReferenceCopyWithImpl(this._self, this._then);

  final ContentReference _self;
  final $Res Function(ContentReference) _then;

/// Create a copy of ContentReference
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? source = null,Object? number = null,Object? grade = freezed,Object? url = freezed,}) {
  return _then(ContentReference(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ReferenceType,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as String,grade: freezed == grade ? _self.grade : grade // ignore: cast_nullable_to_non_nullable
as ContentHadithGrade?,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ContentReference].
extension ContentReferencePatterns on ContentReference {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ContentReference value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ContentReference() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ContentReference value)  $default,){
final _that = this;
switch (_that) {
case _ContentReference():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ContentReference value)?  $default,){
final _that = this;
switch (_that) {
case _ContentReference() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ReferenceType type,  String source, @JsonKey(fromJson: _numberFromJson)  String number,  ContentHadithGrade? grade,  String? url)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ContentReference() when $default != null:
return $default(_that.type,_that.source,_that.number,_that.grade,_that.url);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ReferenceType type,  String source, @JsonKey(fromJson: _numberFromJson)  String number,  ContentHadithGrade? grade,  String? url)  $default,) {final _that = this;
switch (_that) {
case _ContentReference():
return $default(_that.type,_that.source,_that.number,_that.grade,_that.url);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ReferenceType type,  String source, @JsonKey(fromJson: _numberFromJson)  String number,  ContentHadithGrade? grade,  String? url)?  $default,) {final _that = this;
switch (_that) {
case _ContentReference() when $default != null:
return $default(_that.type,_that.source,_that.number,_that.grade,_that.url);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ContentReference implements ContentReference {
  const _ContentReference({required this.type, required this.source, @JsonKey(fromJson: _numberFromJson) required this.number, this.grade, this.url});
  factory _ContentReference.fromJson(Map<String, dynamic> json) => _$ContentReferenceFromJson(json);

@override final  ReferenceType type;
@override final  String source;
@override@JsonKey(fromJson: _numberFromJson) final  String number;
@override final  ContentHadithGrade? grade;
@override final  String? url;

/// Create a copy of ContentReference
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ContentReferenceCopyWith<_ContentReference> get copyWith => __$ContentReferenceCopyWithImpl<_ContentReference>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ContentReferenceToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ContentReference&&(identical(other.type, type) || other.type == type)&&(identical(other.source, source) || other.source == source)&&(identical(other.number, number) || other.number == number)&&(identical(other.grade, grade) || other.grade == grade)&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,type,source,number,grade,url);
}

@override
String toString() {
    return 'ContentReference(type: $type, source: $source, number: $number, grade: $grade, url: $url)';
}


}

/// @nodoc
abstract mixin class _$ContentReferenceCopyWith<$Res> implements $ContentReferenceCopyWith<$Res> {
  factory _$ContentReferenceCopyWith(_ContentReference value, $Res Function(_ContentReference) _then) = __$ContentReferenceCopyWithImpl;
@override @useResult
$Res call({
 ReferenceType type, String source,@JsonKey(fromJson: _numberFromJson) String number, ContentHadithGrade? grade, String? url
});




}
/// @nodoc
class __$ContentReferenceCopyWithImpl<$Res>
    implements _$ContentReferenceCopyWith<$Res> {
  __$ContentReferenceCopyWithImpl(this._self, this._then);

  final _ContentReference _self;
  final $Res Function(_ContentReference) _then;

/// Create a copy of ContentReference
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? source = null,Object? number = null,Object? grade = freezed,Object? url = freezed,}) {
  return _then(_ContentReference(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ReferenceType,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as String,grade: freezed == grade ? _self.grade : grade // ignore: cast_nullable_to_non_nullable
as ContentHadithGrade?,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
