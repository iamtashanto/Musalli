// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hadith_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ContentHadithItem {

@JsonKey(fromJson: _idFromJson) String get id; String get titleBn; String get titleEn; String get narratorBn; String? get narratorEn; String get textBn; String? get textEn; ContentReference get reference; String get category; ContentReviewStatus get reviewStatus;
/// Create a copy of ContentHadithItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContentHadithItemCopyWith<ContentHadithItem> get copyWith => _$ContentHadithItemCopyWithImpl<ContentHadithItem>(this as ContentHadithItem, _$identity);

  /// Serializes this ContentHadithItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ContentHadithItem;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContentHadithItem&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.titleBn, _this.titleBn) || other.titleBn == _this.titleBn)&&(identical(other.titleEn, _this.titleEn) || other.titleEn == _this.titleEn)&&(identical(other.narratorBn, _this.narratorBn) || other.narratorBn == _this.narratorBn)&&(identical(other.narratorEn, _this.narratorEn) || other.narratorEn == _this.narratorEn)&&(identical(other.textBn, _this.textBn) || other.textBn == _this.textBn)&&(identical(other.textEn, _this.textEn) || other.textEn == _this.textEn)&&(identical(other.reference, _this.reference) || other.reference == _this.reference)&&(identical(other.category, _this.category) || other.category == _this.category)&&(identical(other.reviewStatus, _this.reviewStatus) || other.reviewStatus == _this.reviewStatus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ContentHadithItem;
  return Object.hash(runtimeType,_this.id,_this.titleBn,_this.titleEn,_this.narratorBn,_this.narratorEn,_this.textBn,_this.textEn,_this.reference,_this.category,_this.reviewStatus);
}

@override
String toString() {
  final _this = this as ContentHadithItem;
  return 'ContentHadithItem(id: ${_this.id}, titleBn: ${_this.titleBn}, titleEn: ${_this.titleEn}, narratorBn: ${_this.narratorBn}, narratorEn: ${_this.narratorEn}, textBn: ${_this.textBn}, textEn: ${_this.textEn}, reference: ${_this.reference}, category: ${_this.category}, reviewStatus: ${_this.reviewStatus})';
}


}

/// @nodoc
abstract mixin class $ContentHadithItemCopyWith<$Res>  {
  factory $ContentHadithItemCopyWith(ContentHadithItem value, $Res Function(ContentHadithItem) _then) = _$ContentHadithItemCopyWithImpl;
@useResult
$Res call({
@JsonKey(fromJson: _idFromJson) String id, String titleBn, String titleEn, String narratorBn, String? narratorEn, String textBn, String? textEn, ContentReference reference, String category, ContentReviewStatus reviewStatus
});


$ContentReferenceCopyWith<$Res> get reference;

}
/// @nodoc
class _$ContentHadithItemCopyWithImpl<$Res>
    implements $ContentHadithItemCopyWith<$Res> {
  _$ContentHadithItemCopyWithImpl(this._self, this._then);

  final ContentHadithItem _self;
  final $Res Function(ContentHadithItem) _then;

/// Create a copy of ContentHadithItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? titleBn = null,Object? titleEn = null,Object? narratorBn = null,Object? narratorEn = freezed,Object? textBn = null,Object? textEn = freezed,Object? reference = null,Object? category = null,Object? reviewStatus = null,}) {
  return _then(ContentHadithItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,titleBn: null == titleBn ? _self.titleBn : titleBn // ignore: cast_nullable_to_non_nullable
as String,titleEn: null == titleEn ? _self.titleEn : titleEn // ignore: cast_nullable_to_non_nullable
as String,narratorBn: null == narratorBn ? _self.narratorBn : narratorBn // ignore: cast_nullable_to_non_nullable
as String,narratorEn: freezed == narratorEn ? _self.narratorEn : narratorEn // ignore: cast_nullable_to_non_nullable
as String?,textBn: null == textBn ? _self.textBn : textBn // ignore: cast_nullable_to_non_nullable
as String,textEn: freezed == textEn ? _self.textEn : textEn // ignore: cast_nullable_to_non_nullable
as String?,reference: null == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as ContentReference,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,reviewStatus: null == reviewStatus ? _self.reviewStatus : reviewStatus // ignore: cast_nullable_to_non_nullable
as ContentReviewStatus,
  ));
}
/// Create a copy of ContentHadithItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ContentReferenceCopyWith<$Res> get reference {
  
  return $ContentReferenceCopyWith<$Res>(_self.reference, (value) {
    return _then(_self.copyWith(reference: value));
  });
}
}


/// Adds pattern-matching-related methods to [ContentHadithItem].
extension ContentHadithItemPatterns on ContentHadithItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ContentHadithItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ContentHadithItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ContentHadithItem value)  $default,){
final _that = this;
switch (_that) {
case _ContentHadithItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ContentHadithItem value)?  $default,){
final _that = this;
switch (_that) {
case _ContentHadithItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(fromJson: _idFromJson)  String id,  String titleBn,  String titleEn,  String narratorBn,  String? narratorEn,  String textBn,  String? textEn,  ContentReference reference,  String category,  ContentReviewStatus reviewStatus)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ContentHadithItem() when $default != null:
return $default(_that.id,_that.titleBn,_that.titleEn,_that.narratorBn,_that.narratorEn,_that.textBn,_that.textEn,_that.reference,_that.category,_that.reviewStatus);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(fromJson: _idFromJson)  String id,  String titleBn,  String titleEn,  String narratorBn,  String? narratorEn,  String textBn,  String? textEn,  ContentReference reference,  String category,  ContentReviewStatus reviewStatus)  $default,) {final _that = this;
switch (_that) {
case _ContentHadithItem():
return $default(_that.id,_that.titleBn,_that.titleEn,_that.narratorBn,_that.narratorEn,_that.textBn,_that.textEn,_that.reference,_that.category,_that.reviewStatus);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(fromJson: _idFromJson)  String id,  String titleBn,  String titleEn,  String narratorBn,  String? narratorEn,  String textBn,  String? textEn,  ContentReference reference,  String category,  ContentReviewStatus reviewStatus)?  $default,) {final _that = this;
switch (_that) {
case _ContentHadithItem() when $default != null:
return $default(_that.id,_that.titleBn,_that.titleEn,_that.narratorBn,_that.narratorEn,_that.textBn,_that.textEn,_that.reference,_that.category,_that.reviewStatus);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ContentHadithItem implements ContentHadithItem {
  const _ContentHadithItem({@JsonKey(fromJson: _idFromJson) required this.id, required this.titleBn, this.titleEn = '', required this.narratorBn, this.narratorEn, required this.textBn, this.textEn, required this.reference, required this.category, this.reviewStatus = ContentReviewStatus.verified});
  factory _ContentHadithItem.fromJson(Map<String, dynamic> json) => _$ContentHadithItemFromJson(json);

@override@JsonKey(fromJson: _idFromJson) final  String id;
@override final  String titleBn;
@override@JsonKey() final  String titleEn;
@override final  String narratorBn;
@override final  String? narratorEn;
@override final  String textBn;
@override final  String? textEn;
@override final  ContentReference reference;
@override final  String category;
@override@JsonKey() final  ContentReviewStatus reviewStatus;

/// Create a copy of ContentHadithItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ContentHadithItemCopyWith<_ContentHadithItem> get copyWith => __$ContentHadithItemCopyWithImpl<_ContentHadithItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ContentHadithItemToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ContentHadithItem&&(identical(other.id, id) || other.id == id)&&(identical(other.titleBn, titleBn) || other.titleBn == titleBn)&&(identical(other.titleEn, titleEn) || other.titleEn == titleEn)&&(identical(other.narratorBn, narratorBn) || other.narratorBn == narratorBn)&&(identical(other.narratorEn, narratorEn) || other.narratorEn == narratorEn)&&(identical(other.textBn, textBn) || other.textBn == textBn)&&(identical(other.textEn, textEn) || other.textEn == textEn)&&(identical(other.reference, reference) || other.reference == reference)&&(identical(other.category, category) || other.category == category)&&(identical(other.reviewStatus, reviewStatus) || other.reviewStatus == reviewStatus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,titleBn,titleEn,narratorBn,narratorEn,textBn,textEn,reference,category,reviewStatus);
}

@override
String toString() {
    return 'ContentHadithItem(id: $id, titleBn: $titleBn, titleEn: $titleEn, narratorBn: $narratorBn, narratorEn: $narratorEn, textBn: $textBn, textEn: $textEn, reference: $reference, category: $category, reviewStatus: $reviewStatus)';
}


}

/// @nodoc
abstract mixin class _$ContentHadithItemCopyWith<$Res> implements $ContentHadithItemCopyWith<$Res> {
  factory _$ContentHadithItemCopyWith(_ContentHadithItem value, $Res Function(_ContentHadithItem) _then) = __$ContentHadithItemCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(fromJson: _idFromJson) String id, String titleBn, String titleEn, String narratorBn, String? narratorEn, String textBn, String? textEn, ContentReference reference, String category, ContentReviewStatus reviewStatus
});


@override $ContentReferenceCopyWith<$Res> get reference;

}
/// @nodoc
class __$ContentHadithItemCopyWithImpl<$Res>
    implements _$ContentHadithItemCopyWith<$Res> {
  __$ContentHadithItemCopyWithImpl(this._self, this._then);

  final _ContentHadithItem _self;
  final $Res Function(_ContentHadithItem) _then;

/// Create a copy of ContentHadithItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? titleBn = null,Object? titleEn = null,Object? narratorBn = null,Object? narratorEn = freezed,Object? textBn = null,Object? textEn = freezed,Object? reference = null,Object? category = null,Object? reviewStatus = null,}) {
  return _then(_ContentHadithItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,titleBn: null == titleBn ? _self.titleBn : titleBn // ignore: cast_nullable_to_non_nullable
as String,titleEn: null == titleEn ? _self.titleEn : titleEn // ignore: cast_nullable_to_non_nullable
as String,narratorBn: null == narratorBn ? _self.narratorBn : narratorBn // ignore: cast_nullable_to_non_nullable
as String,narratorEn: freezed == narratorEn ? _self.narratorEn : narratorEn // ignore: cast_nullable_to_non_nullable
as String?,textBn: null == textBn ? _self.textBn : textBn // ignore: cast_nullable_to_non_nullable
as String,textEn: freezed == textEn ? _self.textEn : textEn // ignore: cast_nullable_to_non_nullable
as String?,reference: null == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as ContentReference,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,reviewStatus: null == reviewStatus ? _self.reviewStatus : reviewStatus // ignore: cast_nullable_to_non_nullable
as ContentReviewStatus,
  ));
}

/// Create a copy of ContentHadithItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ContentReferenceCopyWith<$Res> get reference {
  
  return $ContentReferenceCopyWith<$Res>(_self.reference, (value) {
    return _then(_self.copyWith(reference: value));
  });
}
}

// dart format on
