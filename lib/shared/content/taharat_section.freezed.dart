// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'taharat_section.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TaharatItem {

 String get title; String get description; ContentReference? get reference;
/// Create a copy of TaharatItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaharatItemCopyWith<TaharatItem> get copyWith => _$TaharatItemCopyWithImpl<TaharatItem>(this as TaharatItem, _$identity);

  /// Serializes this TaharatItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TaharatItem;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaharatItem&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.reference, _this.reference) || other.reference == _this.reference));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TaharatItem;
  return Object.hash(runtimeType,_this.title,_this.description,_this.reference);
}

@override
String toString() {
  final _this = this as TaharatItem;
  return 'TaharatItem(title: ${_this.title}, description: ${_this.description}, reference: ${_this.reference})';
}


}

/// @nodoc
abstract mixin class $TaharatItemCopyWith<$Res>  {
  factory $TaharatItemCopyWith(TaharatItem value, $Res Function(TaharatItem) _then) = _$TaharatItemCopyWithImpl;
@useResult
$Res call({
 String title, String description, ContentReference? reference
});


$ContentReferenceCopyWith<$Res>? get reference;

}
/// @nodoc
class _$TaharatItemCopyWithImpl<$Res>
    implements $TaharatItemCopyWith<$Res> {
  _$TaharatItemCopyWithImpl(this._self, this._then);

  final TaharatItem _self;
  final $Res Function(TaharatItem) _then;

/// Create a copy of TaharatItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? description = null,Object? reference = freezed,}) {
  return _then(TaharatItem(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,reference: freezed == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as ContentReference?,
  ));
}
/// Create a copy of TaharatItem
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


/// Adds pattern-matching-related methods to [TaharatItem].
extension TaharatItemPatterns on TaharatItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TaharatItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TaharatItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TaharatItem value)  $default,){
final _that = this;
switch (_that) {
case _TaharatItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TaharatItem value)?  $default,){
final _that = this;
switch (_that) {
case _TaharatItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String description,  ContentReference? reference)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TaharatItem() when $default != null:
return $default(_that.title,_that.description,_that.reference);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String description,  ContentReference? reference)  $default,) {final _that = this;
switch (_that) {
case _TaharatItem():
return $default(_that.title,_that.description,_that.reference);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String description,  ContentReference? reference)?  $default,) {final _that = this;
switch (_that) {
case _TaharatItem() when $default != null:
return $default(_that.title,_that.description,_that.reference);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TaharatItem implements TaharatItem {
  const _TaharatItem({required this.title, required this.description, this.reference});
  factory _TaharatItem.fromJson(Map<String, dynamic> json) => _$TaharatItemFromJson(json);

@override final  String title;
@override final  String description;
@override final  ContentReference? reference;

/// Create a copy of TaharatItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaharatItemCopyWith<_TaharatItem> get copyWith => __$TaharatItemCopyWithImpl<_TaharatItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TaharatItemToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TaharatItem&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.reference, reference) || other.reference == reference));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,title,description,reference);
}

@override
String toString() {
    return 'TaharatItem(title: $title, description: $description, reference: $reference)';
}


}

/// @nodoc
abstract mixin class _$TaharatItemCopyWith<$Res> implements $TaharatItemCopyWith<$Res> {
  factory _$TaharatItemCopyWith(_TaharatItem value, $Res Function(_TaharatItem) _then) = __$TaharatItemCopyWithImpl;
@override @useResult
$Res call({
 String title, String description, ContentReference? reference
});


@override $ContentReferenceCopyWith<$Res>? get reference;

}
/// @nodoc
class __$TaharatItemCopyWithImpl<$Res>
    implements _$TaharatItemCopyWith<$Res> {
  __$TaharatItemCopyWithImpl(this._self, this._then);

  final _TaharatItem _self;
  final $Res Function(_TaharatItem) _then;

/// Create a copy of TaharatItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? description = null,Object? reference = freezed,}) {
  return _then(_TaharatItem(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,reference: freezed == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as ContentReference?,
  ));
}

/// Create a copy of TaharatItem
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
mixin _$TaharatStep {

 int get stepNumber; String get titleBn; String get titleEn; String get descriptionBn; bool get isFard; bool get isSunnah; String get illustrationKey; String? get recitationId; ContentRecitation? get recitationCustom; String? get tipsBn; ContentReference? get reference;
/// Create a copy of TaharatStep
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaharatStepCopyWith<TaharatStep> get copyWith => _$TaharatStepCopyWithImpl<TaharatStep>(this as TaharatStep, _$identity);

  /// Serializes this TaharatStep to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TaharatStep;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaharatStep&&(identical(other.stepNumber, _this.stepNumber) || other.stepNumber == _this.stepNumber)&&(identical(other.titleBn, _this.titleBn) || other.titleBn == _this.titleBn)&&(identical(other.titleEn, _this.titleEn) || other.titleEn == _this.titleEn)&&(identical(other.descriptionBn, _this.descriptionBn) || other.descriptionBn == _this.descriptionBn)&&(identical(other.isFard, _this.isFard) || other.isFard == _this.isFard)&&(identical(other.isSunnah, _this.isSunnah) || other.isSunnah == _this.isSunnah)&&(identical(other.illustrationKey, _this.illustrationKey) || other.illustrationKey == _this.illustrationKey)&&(identical(other.recitationId, _this.recitationId) || other.recitationId == _this.recitationId)&&(identical(other.recitationCustom, _this.recitationCustom) || other.recitationCustom == _this.recitationCustom)&&(identical(other.tipsBn, _this.tipsBn) || other.tipsBn == _this.tipsBn)&&(identical(other.reference, _this.reference) || other.reference == _this.reference));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TaharatStep;
  return Object.hash(runtimeType,_this.stepNumber,_this.titleBn,_this.titleEn,_this.descriptionBn,_this.isFard,_this.isSunnah,_this.illustrationKey,_this.recitationId,_this.recitationCustom,_this.tipsBn,_this.reference);
}

@override
String toString() {
  final _this = this as TaharatStep;
  return 'TaharatStep(stepNumber: ${_this.stepNumber}, titleBn: ${_this.titleBn}, titleEn: ${_this.titleEn}, descriptionBn: ${_this.descriptionBn}, isFard: ${_this.isFard}, isSunnah: ${_this.isSunnah}, illustrationKey: ${_this.illustrationKey}, recitationId: ${_this.recitationId}, recitationCustom: ${_this.recitationCustom}, tipsBn: ${_this.tipsBn}, reference: ${_this.reference})';
}


}

/// @nodoc
abstract mixin class $TaharatStepCopyWith<$Res>  {
  factory $TaharatStepCopyWith(TaharatStep value, $Res Function(TaharatStep) _then) = _$TaharatStepCopyWithImpl;
@useResult
$Res call({
 int stepNumber, String titleBn, String titleEn, String descriptionBn, bool isFard, bool isSunnah, String illustrationKey, String? recitationId, ContentRecitation? recitationCustom, String? tipsBn, ContentReference? reference
});


$ContentRecitationCopyWith<$Res>? get recitationCustom;$ContentReferenceCopyWith<$Res>? get reference;

}
/// @nodoc
class _$TaharatStepCopyWithImpl<$Res>
    implements $TaharatStepCopyWith<$Res> {
  _$TaharatStepCopyWithImpl(this._self, this._then);

  final TaharatStep _self;
  final $Res Function(TaharatStep) _then;

/// Create a copy of TaharatStep
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? stepNumber = null,Object? titleBn = null,Object? titleEn = null,Object? descriptionBn = null,Object? isFard = null,Object? isSunnah = null,Object? illustrationKey = null,Object? recitationId = freezed,Object? recitationCustom = freezed,Object? tipsBn = freezed,Object? reference = freezed,}) {
  return _then(TaharatStep(
stepNumber: null == stepNumber ? _self.stepNumber : stepNumber // ignore: cast_nullable_to_non_nullable
as int,titleBn: null == titleBn ? _self.titleBn : titleBn // ignore: cast_nullable_to_non_nullable
as String,titleEn: null == titleEn ? _self.titleEn : titleEn // ignore: cast_nullable_to_non_nullable
as String,descriptionBn: null == descriptionBn ? _self.descriptionBn : descriptionBn // ignore: cast_nullable_to_non_nullable
as String,isFard: null == isFard ? _self.isFard : isFard // ignore: cast_nullable_to_non_nullable
as bool,isSunnah: null == isSunnah ? _self.isSunnah : isSunnah // ignore: cast_nullable_to_non_nullable
as bool,illustrationKey: null == illustrationKey ? _self.illustrationKey : illustrationKey // ignore: cast_nullable_to_non_nullable
as String,recitationId: freezed == recitationId ? _self.recitationId : recitationId // ignore: cast_nullable_to_non_nullable
as String?,recitationCustom: freezed == recitationCustom ? _self.recitationCustom : recitationCustom // ignore: cast_nullable_to_non_nullable
as ContentRecitation?,tipsBn: freezed == tipsBn ? _self.tipsBn : tipsBn // ignore: cast_nullable_to_non_nullable
as String?,reference: freezed == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as ContentReference?,
  ));
}
/// Create a copy of TaharatStep
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ContentRecitationCopyWith<$Res>? get recitationCustom {
    if (_self.recitationCustom == null) {
    return null;
  }

  return $ContentRecitationCopyWith<$Res>(_self.recitationCustom!, (value) {
    return _then(_self.copyWith(recitationCustom: value));
  });
}/// Create a copy of TaharatStep
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


/// Adds pattern-matching-related methods to [TaharatStep].
extension TaharatStepPatterns on TaharatStep {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TaharatStep value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TaharatStep() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TaharatStep value)  $default,){
final _that = this;
switch (_that) {
case _TaharatStep():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TaharatStep value)?  $default,){
final _that = this;
switch (_that) {
case _TaharatStep() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int stepNumber,  String titleBn,  String titleEn,  String descriptionBn,  bool isFard,  bool isSunnah,  String illustrationKey,  String? recitationId,  ContentRecitation? recitationCustom,  String? tipsBn,  ContentReference? reference)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TaharatStep() when $default != null:
return $default(_that.stepNumber,_that.titleBn,_that.titleEn,_that.descriptionBn,_that.isFard,_that.isSunnah,_that.illustrationKey,_that.recitationId,_that.recitationCustom,_that.tipsBn,_that.reference);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int stepNumber,  String titleBn,  String titleEn,  String descriptionBn,  bool isFard,  bool isSunnah,  String illustrationKey,  String? recitationId,  ContentRecitation? recitationCustom,  String? tipsBn,  ContentReference? reference)  $default,) {final _that = this;
switch (_that) {
case _TaharatStep():
return $default(_that.stepNumber,_that.titleBn,_that.titleEn,_that.descriptionBn,_that.isFard,_that.isSunnah,_that.illustrationKey,_that.recitationId,_that.recitationCustom,_that.tipsBn,_that.reference);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int stepNumber,  String titleBn,  String titleEn,  String descriptionBn,  bool isFard,  bool isSunnah,  String illustrationKey,  String? recitationId,  ContentRecitation? recitationCustom,  String? tipsBn,  ContentReference? reference)?  $default,) {final _that = this;
switch (_that) {
case _TaharatStep() when $default != null:
return $default(_that.stepNumber,_that.titleBn,_that.titleEn,_that.descriptionBn,_that.isFard,_that.isSunnah,_that.illustrationKey,_that.recitationId,_that.recitationCustom,_that.tipsBn,_that.reference);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TaharatStep implements TaharatStep {
  const _TaharatStep({required this.stepNumber, required this.titleBn, this.titleEn = '', required this.descriptionBn, this.isFard = false, this.isSunnah = false, required this.illustrationKey, this.recitationId, this.recitationCustom, this.tipsBn, this.reference});
  factory _TaharatStep.fromJson(Map<String, dynamic> json) => _$TaharatStepFromJson(json);

@override final  int stepNumber;
@override final  String titleBn;
@override@JsonKey() final  String titleEn;
@override final  String descriptionBn;
@override@JsonKey() final  bool isFard;
@override@JsonKey() final  bool isSunnah;
@override final  String illustrationKey;
@override final  String? recitationId;
@override final  ContentRecitation? recitationCustom;
@override final  String? tipsBn;
@override final  ContentReference? reference;

/// Create a copy of TaharatStep
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaharatStepCopyWith<_TaharatStep> get copyWith => __$TaharatStepCopyWithImpl<_TaharatStep>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TaharatStepToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TaharatStep&&(identical(other.stepNumber, stepNumber) || other.stepNumber == stepNumber)&&(identical(other.titleBn, titleBn) || other.titleBn == titleBn)&&(identical(other.titleEn, titleEn) || other.titleEn == titleEn)&&(identical(other.descriptionBn, descriptionBn) || other.descriptionBn == descriptionBn)&&(identical(other.isFard, isFard) || other.isFard == isFard)&&(identical(other.isSunnah, isSunnah) || other.isSunnah == isSunnah)&&(identical(other.illustrationKey, illustrationKey) || other.illustrationKey == illustrationKey)&&(identical(other.recitationId, recitationId) || other.recitationId == recitationId)&&(identical(other.recitationCustom, recitationCustom) || other.recitationCustom == recitationCustom)&&(identical(other.tipsBn, tipsBn) || other.tipsBn == tipsBn)&&(identical(other.reference, reference) || other.reference == reference));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,stepNumber,titleBn,titleEn,descriptionBn,isFard,isSunnah,illustrationKey,recitationId,recitationCustom,tipsBn,reference);
}

@override
String toString() {
    return 'TaharatStep(stepNumber: $stepNumber, titleBn: $titleBn, titleEn: $titleEn, descriptionBn: $descriptionBn, isFard: $isFard, isSunnah: $isSunnah, illustrationKey: $illustrationKey, recitationId: $recitationId, recitationCustom: $recitationCustom, tipsBn: $tipsBn, reference: $reference)';
}


}

/// @nodoc
abstract mixin class _$TaharatStepCopyWith<$Res> implements $TaharatStepCopyWith<$Res> {
  factory _$TaharatStepCopyWith(_TaharatStep value, $Res Function(_TaharatStep) _then) = __$TaharatStepCopyWithImpl;
@override @useResult
$Res call({
 int stepNumber, String titleBn, String titleEn, String descriptionBn, bool isFard, bool isSunnah, String illustrationKey, String? recitationId, ContentRecitation? recitationCustom, String? tipsBn, ContentReference? reference
});


@override $ContentRecitationCopyWith<$Res>? get recitationCustom;@override $ContentReferenceCopyWith<$Res>? get reference;

}
/// @nodoc
class __$TaharatStepCopyWithImpl<$Res>
    implements _$TaharatStepCopyWith<$Res> {
  __$TaharatStepCopyWithImpl(this._self, this._then);

  final _TaharatStep _self;
  final $Res Function(_TaharatStep) _then;

/// Create a copy of TaharatStep
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? stepNumber = null,Object? titleBn = null,Object? titleEn = null,Object? descriptionBn = null,Object? isFard = null,Object? isSunnah = null,Object? illustrationKey = null,Object? recitationId = freezed,Object? recitationCustom = freezed,Object? tipsBn = freezed,Object? reference = freezed,}) {
  return _then(_TaharatStep(
stepNumber: null == stepNumber ? _self.stepNumber : stepNumber // ignore: cast_nullable_to_non_nullable
as int,titleBn: null == titleBn ? _self.titleBn : titleBn // ignore: cast_nullable_to_non_nullable
as String,titleEn: null == titleEn ? _self.titleEn : titleEn // ignore: cast_nullable_to_non_nullable
as String,descriptionBn: null == descriptionBn ? _self.descriptionBn : descriptionBn // ignore: cast_nullable_to_non_nullable
as String,isFard: null == isFard ? _self.isFard : isFard // ignore: cast_nullable_to_non_nullable
as bool,isSunnah: null == isSunnah ? _self.isSunnah : isSunnah // ignore: cast_nullable_to_non_nullable
as bool,illustrationKey: null == illustrationKey ? _self.illustrationKey : illustrationKey // ignore: cast_nullable_to_non_nullable
as String,recitationId: freezed == recitationId ? _self.recitationId : recitationId // ignore: cast_nullable_to_non_nullable
as String?,recitationCustom: freezed == recitationCustom ? _self.recitationCustom : recitationCustom // ignore: cast_nullable_to_non_nullable
as ContentRecitation?,tipsBn: freezed == tipsBn ? _self.tipsBn : tipsBn // ignore: cast_nullable_to_non_nullable
as String?,reference: freezed == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as ContentReference?,
  ));
}

/// Create a copy of TaharatStep
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ContentRecitationCopyWith<$Res>? get recitationCustom {
    if (_self.recitationCustom == null) {
    return null;
  }

  return $ContentRecitationCopyWith<$Res>(_self.recitationCustom!, (value) {
    return _then(_self.copyWith(recitationCustom: value));
  });
}/// Create a copy of TaharatStep
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
mixin _$TaharatSpecialCase {

 String get title; String get bodyBn; ContentReference? get reference;
/// Create a copy of TaharatSpecialCase
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TaharatSpecialCaseCopyWith<TaharatSpecialCase> get copyWith => _$TaharatSpecialCaseCopyWithImpl<TaharatSpecialCase>(this as TaharatSpecialCase, _$identity);

  /// Serializes this TaharatSpecialCase to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TaharatSpecialCase;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TaharatSpecialCase&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.bodyBn, _this.bodyBn) || other.bodyBn == _this.bodyBn)&&(identical(other.reference, _this.reference) || other.reference == _this.reference));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TaharatSpecialCase;
  return Object.hash(runtimeType,_this.title,_this.bodyBn,_this.reference);
}

@override
String toString() {
  final _this = this as TaharatSpecialCase;
  return 'TaharatSpecialCase(title: ${_this.title}, bodyBn: ${_this.bodyBn}, reference: ${_this.reference})';
}


}

/// @nodoc
abstract mixin class $TaharatSpecialCaseCopyWith<$Res>  {
  factory $TaharatSpecialCaseCopyWith(TaharatSpecialCase value, $Res Function(TaharatSpecialCase) _then) = _$TaharatSpecialCaseCopyWithImpl;
@useResult
$Res call({
 String title, String bodyBn, ContentReference? reference
});


$ContentReferenceCopyWith<$Res>? get reference;

}
/// @nodoc
class _$TaharatSpecialCaseCopyWithImpl<$Res>
    implements $TaharatSpecialCaseCopyWith<$Res> {
  _$TaharatSpecialCaseCopyWithImpl(this._self, this._then);

  final TaharatSpecialCase _self;
  final $Res Function(TaharatSpecialCase) _then;

/// Create a copy of TaharatSpecialCase
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? bodyBn = null,Object? reference = freezed,}) {
  return _then(TaharatSpecialCase(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,bodyBn: null == bodyBn ? _self.bodyBn : bodyBn // ignore: cast_nullable_to_non_nullable
as String,reference: freezed == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as ContentReference?,
  ));
}
/// Create a copy of TaharatSpecialCase
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


/// Adds pattern-matching-related methods to [TaharatSpecialCase].
extension TaharatSpecialCasePatterns on TaharatSpecialCase {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TaharatSpecialCase value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TaharatSpecialCase() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TaharatSpecialCase value)  $default,){
final _that = this;
switch (_that) {
case _TaharatSpecialCase():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TaharatSpecialCase value)?  $default,){
final _that = this;
switch (_that) {
case _TaharatSpecialCase() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String bodyBn,  ContentReference? reference)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TaharatSpecialCase() when $default != null:
return $default(_that.title,_that.bodyBn,_that.reference);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String bodyBn,  ContentReference? reference)  $default,) {final _that = this;
switch (_that) {
case _TaharatSpecialCase():
return $default(_that.title,_that.bodyBn,_that.reference);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String bodyBn,  ContentReference? reference)?  $default,) {final _that = this;
switch (_that) {
case _TaharatSpecialCase() when $default != null:
return $default(_that.title,_that.bodyBn,_that.reference);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TaharatSpecialCase implements TaharatSpecialCase {
  const _TaharatSpecialCase({required this.title, required this.bodyBn, this.reference});
  factory _TaharatSpecialCase.fromJson(Map<String, dynamic> json) => _$TaharatSpecialCaseFromJson(json);

@override final  String title;
@override final  String bodyBn;
@override final  ContentReference? reference;

/// Create a copy of TaharatSpecialCase
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TaharatSpecialCaseCopyWith<_TaharatSpecialCase> get copyWith => __$TaharatSpecialCaseCopyWithImpl<_TaharatSpecialCase>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TaharatSpecialCaseToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TaharatSpecialCase&&(identical(other.title, title) || other.title == title)&&(identical(other.bodyBn, bodyBn) || other.bodyBn == bodyBn)&&(identical(other.reference, reference) || other.reference == reference));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,title,bodyBn,reference);
}

@override
String toString() {
    return 'TaharatSpecialCase(title: $title, bodyBn: $bodyBn, reference: $reference)';
}


}

/// @nodoc
abstract mixin class _$TaharatSpecialCaseCopyWith<$Res> implements $TaharatSpecialCaseCopyWith<$Res> {
  factory _$TaharatSpecialCaseCopyWith(_TaharatSpecialCase value, $Res Function(_TaharatSpecialCase) _then) = __$TaharatSpecialCaseCopyWithImpl;
@override @useResult
$Res call({
 String title, String bodyBn, ContentReference? reference
});


@override $ContentReferenceCopyWith<$Res>? get reference;

}
/// @nodoc
class __$TaharatSpecialCaseCopyWithImpl<$Res>
    implements _$TaharatSpecialCaseCopyWith<$Res> {
  __$TaharatSpecialCaseCopyWithImpl(this._self, this._then);

  final _TaharatSpecialCase _self;
  final $Res Function(_TaharatSpecialCase) _then;

/// Create a copy of TaharatSpecialCase
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? bodyBn = null,Object? reference = freezed,}) {
  return _then(_TaharatSpecialCase(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,bodyBn: null == bodyBn ? _self.bodyBn : bodyBn // ignore: cast_nullable_to_non_nullable
as String,reference: freezed == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as ContentReference?,
  ));
}

/// Create a copy of TaharatSpecialCase
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
mixin _$ContentTaharatSection {

 String get slug; String get titleBn; String get titleAr; String get titleEn; String get summaryBn; List<TaharatItem>? get farzList; List<TaharatItem>? get sunnahList; List<String>? get mustahabList; List<String>? get makruhList; List<TaharatItem>? get breakersList; List<TaharatStep>? get steps; List<TaharatSpecialCase>? get specialCases; List<ContentPrayerFAQ> get faqs; List<ContentReference> get references; ContentReviewStatus? get reviewStatus;
/// Create a copy of ContentTaharatSection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContentTaharatSectionCopyWith<ContentTaharatSection> get copyWith => _$ContentTaharatSectionCopyWithImpl<ContentTaharatSection>(this as ContentTaharatSection, _$identity);

  /// Serializes this ContentTaharatSection to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ContentTaharatSection;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContentTaharatSection&&(identical(other.slug, _this.slug) || other.slug == _this.slug)&&(identical(other.titleBn, _this.titleBn) || other.titleBn == _this.titleBn)&&(identical(other.titleAr, _this.titleAr) || other.titleAr == _this.titleAr)&&(identical(other.titleEn, _this.titleEn) || other.titleEn == _this.titleEn)&&(identical(other.summaryBn, _this.summaryBn) || other.summaryBn == _this.summaryBn)&&const DeepCollectionEquality().equals(other.farzList, _this.farzList)&&const DeepCollectionEquality().equals(other.sunnahList, _this.sunnahList)&&const DeepCollectionEquality().equals(other.mustahabList, _this.mustahabList)&&const DeepCollectionEquality().equals(other.makruhList, _this.makruhList)&&const DeepCollectionEquality().equals(other.breakersList, _this.breakersList)&&const DeepCollectionEquality().equals(other.steps, _this.steps)&&const DeepCollectionEquality().equals(other.specialCases, _this.specialCases)&&const DeepCollectionEquality().equals(other.faqs, _this.faqs)&&const DeepCollectionEquality().equals(other.references, _this.references)&&(identical(other.reviewStatus, _this.reviewStatus) || other.reviewStatus == _this.reviewStatus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ContentTaharatSection;
  return Object.hash(runtimeType,_this.slug,_this.titleBn,_this.titleAr,_this.titleEn,_this.summaryBn,const DeepCollectionEquality().hash(_this.farzList),const DeepCollectionEquality().hash(_this.sunnahList),const DeepCollectionEquality().hash(_this.mustahabList),const DeepCollectionEquality().hash(_this.makruhList),const DeepCollectionEquality().hash(_this.breakersList),const DeepCollectionEquality().hash(_this.steps),const DeepCollectionEquality().hash(_this.specialCases),const DeepCollectionEquality().hash(_this.faqs),const DeepCollectionEquality().hash(_this.references),_this.reviewStatus);
}

@override
String toString() {
  final _this = this as ContentTaharatSection;
  return 'ContentTaharatSection(slug: ${_this.slug}, titleBn: ${_this.titleBn}, titleAr: ${_this.titleAr}, titleEn: ${_this.titleEn}, summaryBn: ${_this.summaryBn}, farzList: ${_this.farzList}, sunnahList: ${_this.sunnahList}, mustahabList: ${_this.mustahabList}, makruhList: ${_this.makruhList}, breakersList: ${_this.breakersList}, steps: ${_this.steps}, specialCases: ${_this.specialCases}, faqs: ${_this.faqs}, references: ${_this.references}, reviewStatus: ${_this.reviewStatus})';
}


}

/// @nodoc
abstract mixin class $ContentTaharatSectionCopyWith<$Res>  {
  factory $ContentTaharatSectionCopyWith(ContentTaharatSection value, $Res Function(ContentTaharatSection) _then) = _$ContentTaharatSectionCopyWithImpl;
@useResult
$Res call({
 String slug, String titleBn, String titleAr, String titleEn, String summaryBn, List<TaharatItem>? farzList, List<TaharatItem>? sunnahList, List<String>? mustahabList, List<String>? makruhList, List<TaharatItem>? breakersList, List<TaharatStep>? steps, List<TaharatSpecialCase>? specialCases, List<ContentPrayerFAQ> faqs, List<ContentReference> references, ContentReviewStatus? reviewStatus
});




}
/// @nodoc
class _$ContentTaharatSectionCopyWithImpl<$Res>
    implements $ContentTaharatSectionCopyWith<$Res> {
  _$ContentTaharatSectionCopyWithImpl(this._self, this._then);

  final ContentTaharatSection _self;
  final $Res Function(ContentTaharatSection) _then;

/// Create a copy of ContentTaharatSection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? slug = null,Object? titleBn = null,Object? titleAr = null,Object? titleEn = null,Object? summaryBn = null,Object? farzList = freezed,Object? sunnahList = freezed,Object? mustahabList = freezed,Object? makruhList = freezed,Object? breakersList = freezed,Object? steps = freezed,Object? specialCases = freezed,Object? faqs = null,Object? references = null,Object? reviewStatus = freezed,}) {
  return _then(ContentTaharatSection(
slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,titleBn: null == titleBn ? _self.titleBn : titleBn // ignore: cast_nullable_to_non_nullable
as String,titleAr: null == titleAr ? _self.titleAr : titleAr // ignore: cast_nullable_to_non_nullable
as String,titleEn: null == titleEn ? _self.titleEn : titleEn // ignore: cast_nullable_to_non_nullable
as String,summaryBn: null == summaryBn ? _self.summaryBn : summaryBn // ignore: cast_nullable_to_non_nullable
as String,farzList: freezed == farzList ? _self.farzList : farzList // ignore: cast_nullable_to_non_nullable
as List<TaharatItem>?,sunnahList: freezed == sunnahList ? _self.sunnahList : sunnahList // ignore: cast_nullable_to_non_nullable
as List<TaharatItem>?,mustahabList: freezed == mustahabList ? _self.mustahabList : mustahabList // ignore: cast_nullable_to_non_nullable
as List<String>?,makruhList: freezed == makruhList ? _self.makruhList : makruhList // ignore: cast_nullable_to_non_nullable
as List<String>?,breakersList: freezed == breakersList ? _self.breakersList : breakersList // ignore: cast_nullable_to_non_nullable
as List<TaharatItem>?,steps: freezed == steps ? _self.steps : steps // ignore: cast_nullable_to_non_nullable
as List<TaharatStep>?,specialCases: freezed == specialCases ? _self.specialCases : specialCases // ignore: cast_nullable_to_non_nullable
as List<TaharatSpecialCase>?,faqs: null == faqs ? _self.faqs : faqs // ignore: cast_nullable_to_non_nullable
as List<ContentPrayerFAQ>,references: null == references ? _self.references : references // ignore: cast_nullable_to_non_nullable
as List<ContentReference>,reviewStatus: freezed == reviewStatus ? _self.reviewStatus : reviewStatus // ignore: cast_nullable_to_non_nullable
as ContentReviewStatus?,
  ));
}

}


/// Adds pattern-matching-related methods to [ContentTaharatSection].
extension ContentTaharatSectionPatterns on ContentTaharatSection {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ContentTaharatSection value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ContentTaharatSection() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ContentTaharatSection value)  $default,){
final _that = this;
switch (_that) {
case _ContentTaharatSection():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ContentTaharatSection value)?  $default,){
final _that = this;
switch (_that) {
case _ContentTaharatSection() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String slug,  String titleBn,  String titleAr,  String titleEn,  String summaryBn,  List<TaharatItem>? farzList,  List<TaharatItem>? sunnahList,  List<String>? mustahabList,  List<String>? makruhList,  List<TaharatItem>? breakersList,  List<TaharatStep>? steps,  List<TaharatSpecialCase>? specialCases,  List<ContentPrayerFAQ> faqs,  List<ContentReference> references,  ContentReviewStatus? reviewStatus)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ContentTaharatSection() when $default != null:
return $default(_that.slug,_that.titleBn,_that.titleAr,_that.titleEn,_that.summaryBn,_that.farzList,_that.sunnahList,_that.mustahabList,_that.makruhList,_that.breakersList,_that.steps,_that.specialCases,_that.faqs,_that.references,_that.reviewStatus);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String slug,  String titleBn,  String titleAr,  String titleEn,  String summaryBn,  List<TaharatItem>? farzList,  List<TaharatItem>? sunnahList,  List<String>? mustahabList,  List<String>? makruhList,  List<TaharatItem>? breakersList,  List<TaharatStep>? steps,  List<TaharatSpecialCase>? specialCases,  List<ContentPrayerFAQ> faqs,  List<ContentReference> references,  ContentReviewStatus? reviewStatus)  $default,) {final _that = this;
switch (_that) {
case _ContentTaharatSection():
return $default(_that.slug,_that.titleBn,_that.titleAr,_that.titleEn,_that.summaryBn,_that.farzList,_that.sunnahList,_that.mustahabList,_that.makruhList,_that.breakersList,_that.steps,_that.specialCases,_that.faqs,_that.references,_that.reviewStatus);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String slug,  String titleBn,  String titleAr,  String titleEn,  String summaryBn,  List<TaharatItem>? farzList,  List<TaharatItem>? sunnahList,  List<String>? mustahabList,  List<String>? makruhList,  List<TaharatItem>? breakersList,  List<TaharatStep>? steps,  List<TaharatSpecialCase>? specialCases,  List<ContentPrayerFAQ> faqs,  List<ContentReference> references,  ContentReviewStatus? reviewStatus)?  $default,) {final _that = this;
switch (_that) {
case _ContentTaharatSection() when $default != null:
return $default(_that.slug,_that.titleBn,_that.titleAr,_that.titleEn,_that.summaryBn,_that.farzList,_that.sunnahList,_that.mustahabList,_that.makruhList,_that.breakersList,_that.steps,_that.specialCases,_that.faqs,_that.references,_that.reviewStatus);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ContentTaharatSection implements ContentTaharatSection {
  const _ContentTaharatSection({required this.slug, required this.titleBn, required this.titleAr, required this.titleEn, required this.summaryBn,  List<TaharatItem>? farzList,  List<TaharatItem>? sunnahList,  List<String>? mustahabList,  List<String>? makruhList,  List<TaharatItem>? breakersList,  List<TaharatStep>? steps,  List<TaharatSpecialCase>? specialCases,  List<ContentPrayerFAQ> faqs = const <ContentPrayerFAQ>[],  List<ContentReference> references = const <ContentReference>[], this.reviewStatus = ContentReviewStatus.verified}): _farzList = farzList,_sunnahList = sunnahList,_mustahabList = mustahabList,_makruhList = makruhList,_breakersList = breakersList,_steps = steps,_specialCases = specialCases,_faqs = faqs,_references = references;
  factory _ContentTaharatSection.fromJson(Map<String, dynamic> json) => _$ContentTaharatSectionFromJson(json);

@override final  String slug;
@override final  String titleBn;
@override final  String titleAr;
@override final  String titleEn;
@override final  String summaryBn;
 final  List<TaharatItem>? _farzList;
@override List<TaharatItem>? get farzList {
  final value = _farzList;
  if (value == null) return null;
  if (_farzList is EqualUnmodifiableListView) return _farzList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<TaharatItem>? _sunnahList;
@override List<TaharatItem>? get sunnahList {
  final value = _sunnahList;
  if (value == null) return null;
  if (_sunnahList is EqualUnmodifiableListView) return _sunnahList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<String>? _mustahabList;
@override List<String>? get mustahabList {
  final value = _mustahabList;
  if (value == null) return null;
  if (_mustahabList is EqualUnmodifiableListView) return _mustahabList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<String>? _makruhList;
@override List<String>? get makruhList {
  final value = _makruhList;
  if (value == null) return null;
  if (_makruhList is EqualUnmodifiableListView) return _makruhList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<TaharatItem>? _breakersList;
@override List<TaharatItem>? get breakersList {
  final value = _breakersList;
  if (value == null) return null;
  if (_breakersList is EqualUnmodifiableListView) return _breakersList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<TaharatStep>? _steps;
@override List<TaharatStep>? get steps {
  final value = _steps;
  if (value == null) return null;
  if (_steps is EqualUnmodifiableListView) return _steps;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<TaharatSpecialCase>? _specialCases;
@override List<TaharatSpecialCase>? get specialCases {
  final value = _specialCases;
  if (value == null) return null;
  if (_specialCases is EqualUnmodifiableListView) return _specialCases;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<ContentPrayerFAQ> _faqs;
@override@JsonKey() List<ContentPrayerFAQ> get faqs {
  if (_faqs is EqualUnmodifiableListView) return _faqs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_faqs);
}

 final  List<ContentReference> _references;
@override@JsonKey() List<ContentReference> get references {
  if (_references is EqualUnmodifiableListView) return _references;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_references);
}

@override@JsonKey() final  ContentReviewStatus? reviewStatus;

/// Create a copy of ContentTaharatSection
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ContentTaharatSectionCopyWith<_ContentTaharatSection> get copyWith => __$ContentTaharatSectionCopyWithImpl<_ContentTaharatSection>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ContentTaharatSectionToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ContentTaharatSection&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.titleBn, titleBn) || other.titleBn == titleBn)&&(identical(other.titleAr, titleAr) || other.titleAr == titleAr)&&(identical(other.titleEn, titleEn) || other.titleEn == titleEn)&&(identical(other.summaryBn, summaryBn) || other.summaryBn == summaryBn)&&const DeepCollectionEquality().equals(other.farzList, _farzList)&&const DeepCollectionEquality().equals(other.sunnahList, _sunnahList)&&const DeepCollectionEquality().equals(other.mustahabList, _mustahabList)&&const DeepCollectionEquality().equals(other.makruhList, _makruhList)&&const DeepCollectionEquality().equals(other.breakersList, _breakersList)&&const DeepCollectionEquality().equals(other.steps, _steps)&&const DeepCollectionEquality().equals(other.specialCases, _specialCases)&&const DeepCollectionEquality().equals(other.faqs, _faqs)&&const DeepCollectionEquality().equals(other.references, _references)&&(identical(other.reviewStatus, reviewStatus) || other.reviewStatus == reviewStatus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,slug,titleBn,titleAr,titleEn,summaryBn,const DeepCollectionEquality().hash(_farzList),const DeepCollectionEquality().hash(_sunnahList),const DeepCollectionEquality().hash(_mustahabList),const DeepCollectionEquality().hash(_makruhList),const DeepCollectionEquality().hash(_breakersList),const DeepCollectionEquality().hash(_steps),const DeepCollectionEquality().hash(_specialCases),const DeepCollectionEquality().hash(_faqs),const DeepCollectionEquality().hash(_references),reviewStatus);
}

@override
String toString() {
    return 'ContentTaharatSection(slug: $slug, titleBn: $titleBn, titleAr: $titleAr, titleEn: $titleEn, summaryBn: $summaryBn, farzList: $farzList, sunnahList: $sunnahList, mustahabList: $mustahabList, makruhList: $makruhList, breakersList: $breakersList, steps: $steps, specialCases: $specialCases, faqs: $faqs, references: $references, reviewStatus: $reviewStatus)';
}


}

/// @nodoc
abstract mixin class _$ContentTaharatSectionCopyWith<$Res> implements $ContentTaharatSectionCopyWith<$Res> {
  factory _$ContentTaharatSectionCopyWith(_ContentTaharatSection value, $Res Function(_ContentTaharatSection) _then) = __$ContentTaharatSectionCopyWithImpl;
@override @useResult
$Res call({
 String slug, String titleBn, String titleAr, String titleEn, String summaryBn, List<TaharatItem>? farzList, List<TaharatItem>? sunnahList, List<String>? mustahabList, List<String>? makruhList, List<TaharatItem>? breakersList, List<TaharatStep>? steps, List<TaharatSpecialCase>? specialCases, List<ContentPrayerFAQ> faqs, List<ContentReference> references, ContentReviewStatus? reviewStatus
});




}
/// @nodoc
class __$ContentTaharatSectionCopyWithImpl<$Res>
    implements _$ContentTaharatSectionCopyWith<$Res> {
  __$ContentTaharatSectionCopyWithImpl(this._self, this._then);

  final _ContentTaharatSection _self;
  final $Res Function(_ContentTaharatSection) _then;

/// Create a copy of ContentTaharatSection
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? slug = null,Object? titleBn = null,Object? titleAr = null,Object? titleEn = null,Object? summaryBn = null,Object? farzList = freezed,Object? sunnahList = freezed,Object? mustahabList = freezed,Object? makruhList = freezed,Object? breakersList = freezed,Object? steps = freezed,Object? specialCases = freezed,Object? faqs = null,Object? references = null,Object? reviewStatus = freezed,}) {
  return _then(_ContentTaharatSection(
slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,titleBn: null == titleBn ? _self.titleBn : titleBn // ignore: cast_nullable_to_non_nullable
as String,titleAr: null == titleAr ? _self.titleAr : titleAr // ignore: cast_nullable_to_non_nullable
as String,titleEn: null == titleEn ? _self.titleEn : titleEn // ignore: cast_nullable_to_non_nullable
as String,summaryBn: null == summaryBn ? _self.summaryBn : summaryBn // ignore: cast_nullable_to_non_nullable
as String,farzList: freezed == farzList ? _self._farzList : farzList // ignore: cast_nullable_to_non_nullable
as List<TaharatItem>?,sunnahList: freezed == sunnahList ? _self._sunnahList : sunnahList // ignore: cast_nullable_to_non_nullable
as List<TaharatItem>?,mustahabList: freezed == mustahabList ? _self._mustahabList : mustahabList // ignore: cast_nullable_to_non_nullable
as List<String>?,makruhList: freezed == makruhList ? _self._makruhList : makruhList // ignore: cast_nullable_to_non_nullable
as List<String>?,breakersList: freezed == breakersList ? _self._breakersList : breakersList // ignore: cast_nullable_to_non_nullable
as List<TaharatItem>?,steps: freezed == steps ? _self._steps : steps // ignore: cast_nullable_to_non_nullable
as List<TaharatStep>?,specialCases: freezed == specialCases ? _self._specialCases : specialCases // ignore: cast_nullable_to_non_nullable
as List<TaharatSpecialCase>?,faqs: null == faqs ? _self._faqs : faqs // ignore: cast_nullable_to_non_nullable
as List<ContentPrayerFAQ>,references: null == references ? _self._references : references // ignore: cast_nullable_to_non_nullable
as List<ContentReference>,reviewStatus: freezed == reviewStatus ? _self.reviewStatus : reviewStatus // ignore: cast_nullable_to_non_nullable
as ContentReviewStatus?,
  ));
}


}

// dart format on
