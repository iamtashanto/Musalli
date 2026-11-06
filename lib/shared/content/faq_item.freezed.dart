// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'faq_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ContentFaqItem {

 int get id;@JsonKey(name: 'question_bn') String get questionBn;@JsonKey(name: 'question_en') String get questionEn;@JsonKey(name: 'answer_bn') String get answerBn;@JsonKey(name: 'answer_en') String get answerEn; String get category;
/// Create a copy of ContentFaqItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContentFaqItemCopyWith<ContentFaqItem> get copyWith => _$ContentFaqItemCopyWithImpl<ContentFaqItem>(this as ContentFaqItem, _$identity);

  /// Serializes this ContentFaqItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ContentFaqItem;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContentFaqItem&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.questionBn, _this.questionBn) || other.questionBn == _this.questionBn)&&(identical(other.questionEn, _this.questionEn) || other.questionEn == _this.questionEn)&&(identical(other.answerBn, _this.answerBn) || other.answerBn == _this.answerBn)&&(identical(other.answerEn, _this.answerEn) || other.answerEn == _this.answerEn)&&(identical(other.category, _this.category) || other.category == _this.category));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ContentFaqItem;
  return Object.hash(runtimeType,_this.id,_this.questionBn,_this.questionEn,_this.answerBn,_this.answerEn,_this.category);
}

@override
String toString() {
  final _this = this as ContentFaqItem;
  return 'ContentFaqItem(id: ${_this.id}, questionBn: ${_this.questionBn}, questionEn: ${_this.questionEn}, answerBn: ${_this.answerBn}, answerEn: ${_this.answerEn}, category: ${_this.category})';
}


}

/// @nodoc
abstract mixin class $ContentFaqItemCopyWith<$Res>  {
  factory $ContentFaqItemCopyWith(ContentFaqItem value, $Res Function(ContentFaqItem) _then) = _$ContentFaqItemCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'question_bn') String questionBn,@JsonKey(name: 'question_en') String questionEn,@JsonKey(name: 'answer_bn') String answerBn,@JsonKey(name: 'answer_en') String answerEn, String category
});




}
/// @nodoc
class _$ContentFaqItemCopyWithImpl<$Res>
    implements $ContentFaqItemCopyWith<$Res> {
  _$ContentFaqItemCopyWithImpl(this._self, this._then);

  final ContentFaqItem _self;
  final $Res Function(ContentFaqItem) _then;

/// Create a copy of ContentFaqItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? questionBn = null,Object? questionEn = null,Object? answerBn = null,Object? answerEn = null,Object? category = null,}) {
  return _then(ContentFaqItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,questionBn: null == questionBn ? _self.questionBn : questionBn // ignore: cast_nullable_to_non_nullable
as String,questionEn: null == questionEn ? _self.questionEn : questionEn // ignore: cast_nullable_to_non_nullable
as String,answerBn: null == answerBn ? _self.answerBn : answerBn // ignore: cast_nullable_to_non_nullable
as String,answerEn: null == answerEn ? _self.answerEn : answerEn // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ContentFaqItem].
extension ContentFaqItemPatterns on ContentFaqItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ContentFaqItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ContentFaqItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ContentFaqItem value)  $default,){
final _that = this;
switch (_that) {
case _ContentFaqItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ContentFaqItem value)?  $default,){
final _that = this;
switch (_that) {
case _ContentFaqItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'question_bn')  String questionBn, @JsonKey(name: 'question_en')  String questionEn, @JsonKey(name: 'answer_bn')  String answerBn, @JsonKey(name: 'answer_en')  String answerEn,  String category)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ContentFaqItem() when $default != null:
return $default(_that.id,_that.questionBn,_that.questionEn,_that.answerBn,_that.answerEn,_that.category);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'question_bn')  String questionBn, @JsonKey(name: 'question_en')  String questionEn, @JsonKey(name: 'answer_bn')  String answerBn, @JsonKey(name: 'answer_en')  String answerEn,  String category)  $default,) {final _that = this;
switch (_that) {
case _ContentFaqItem():
return $default(_that.id,_that.questionBn,_that.questionEn,_that.answerBn,_that.answerEn,_that.category);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'question_bn')  String questionBn, @JsonKey(name: 'question_en')  String questionEn, @JsonKey(name: 'answer_bn')  String answerBn, @JsonKey(name: 'answer_en')  String answerEn,  String category)?  $default,) {final _that = this;
switch (_that) {
case _ContentFaqItem() when $default != null:
return $default(_that.id,_that.questionBn,_that.questionEn,_that.answerBn,_that.answerEn,_that.category);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ContentFaqItem implements ContentFaqItem {
  const _ContentFaqItem({required this.id, @JsonKey(name: 'question_bn') required this.questionBn, @JsonKey(name: 'question_en') this.questionEn = '', @JsonKey(name: 'answer_bn') required this.answerBn, @JsonKey(name: 'answer_en') this.answerEn = '', this.category = 'general'});
  factory _ContentFaqItem.fromJson(Map<String, dynamic> json) => _$ContentFaqItemFromJson(json);

@override final  int id;
@override@JsonKey(name: 'question_bn') final  String questionBn;
@override@JsonKey(name: 'question_en') final  String questionEn;
@override@JsonKey(name: 'answer_bn') final  String answerBn;
@override@JsonKey(name: 'answer_en') final  String answerEn;
@override@JsonKey() final  String category;

/// Create a copy of ContentFaqItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ContentFaqItemCopyWith<_ContentFaqItem> get copyWith => __$ContentFaqItemCopyWithImpl<_ContentFaqItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ContentFaqItemToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ContentFaqItem&&(identical(other.id, id) || other.id == id)&&(identical(other.questionBn, questionBn) || other.questionBn == questionBn)&&(identical(other.questionEn, questionEn) || other.questionEn == questionEn)&&(identical(other.answerBn, answerBn) || other.answerBn == answerBn)&&(identical(other.answerEn, answerEn) || other.answerEn == answerEn)&&(identical(other.category, category) || other.category == category));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,questionBn,questionEn,answerBn,answerEn,category);
}

@override
String toString() {
    return 'ContentFaqItem(id: $id, questionBn: $questionBn, questionEn: $questionEn, answerBn: $answerBn, answerEn: $answerEn, category: $category)';
}


}

/// @nodoc
abstract mixin class _$ContentFaqItemCopyWith<$Res> implements $ContentFaqItemCopyWith<$Res> {
  factory _$ContentFaqItemCopyWith(_ContentFaqItem value, $Res Function(_ContentFaqItem) _then) = __$ContentFaqItemCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'question_bn') String questionBn,@JsonKey(name: 'question_en') String questionEn,@JsonKey(name: 'answer_bn') String answerBn,@JsonKey(name: 'answer_en') String answerEn, String category
});




}
/// @nodoc
class __$ContentFaqItemCopyWithImpl<$Res>
    implements _$ContentFaqItemCopyWith<$Res> {
  __$ContentFaqItemCopyWithImpl(this._self, this._then);

  final _ContentFaqItem _self;
  final $Res Function(_ContentFaqItem) _then;

/// Create a copy of ContentFaqItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? questionBn = null,Object? questionEn = null,Object? answerBn = null,Object? answerEn = null,Object? category = null,}) {
  return _then(_ContentFaqItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,questionBn: null == questionBn ? _self.questionBn : questionBn // ignore: cast_nullable_to_non_nullable
as String,questionEn: null == questionEn ? _self.questionEn : questionEn // ignore: cast_nullable_to_non_nullable
as String,answerBn: null == answerBn ? _self.answerBn : answerBn // ignore: cast_nullable_to_non_nullable
as String,answerEn: null == answerEn ? _self.answerEn : answerEn // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
