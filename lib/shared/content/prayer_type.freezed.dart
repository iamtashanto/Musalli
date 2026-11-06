// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'prayer_type.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ContentGenderDifferences {

 List<String> get male; List<String> get female; String? get note;
/// Create a copy of ContentGenderDifferences
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContentGenderDifferencesCopyWith<ContentGenderDifferences> get copyWith => _$ContentGenderDifferencesCopyWithImpl<ContentGenderDifferences>(this as ContentGenderDifferences, _$identity);

  /// Serializes this ContentGenderDifferences to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ContentGenderDifferences;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContentGenderDifferences&&const DeepCollectionEquality().equals(other.male, _this.male)&&const DeepCollectionEquality().equals(other.female, _this.female)&&(identical(other.note, _this.note) || other.note == _this.note));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ContentGenderDifferences;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.male),const DeepCollectionEquality().hash(_this.female),_this.note);
}

@override
String toString() {
  final _this = this as ContentGenderDifferences;
  return 'ContentGenderDifferences(male: ${_this.male}, female: ${_this.female}, note: ${_this.note})';
}


}

/// @nodoc
abstract mixin class $ContentGenderDifferencesCopyWith<$Res>  {
  factory $ContentGenderDifferencesCopyWith(ContentGenderDifferences value, $Res Function(ContentGenderDifferences) _then) = _$ContentGenderDifferencesCopyWithImpl;
@useResult
$Res call({
 List<String> male, List<String> female, String? note
});




}
/// @nodoc
class _$ContentGenderDifferencesCopyWithImpl<$Res>
    implements $ContentGenderDifferencesCopyWith<$Res> {
  _$ContentGenderDifferencesCopyWithImpl(this._self, this._then);

  final ContentGenderDifferences _self;
  final $Res Function(ContentGenderDifferences) _then;

/// Create a copy of ContentGenderDifferences
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? male = null,Object? female = null,Object? note = freezed,}) {
  return _then(ContentGenderDifferences(
male: null == male ? _self.male : male // ignore: cast_nullable_to_non_nullable
as List<String>,female: null == female ? _self.female : female // ignore: cast_nullable_to_non_nullable
as List<String>,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ContentGenderDifferences].
extension ContentGenderDifferencesPatterns on ContentGenderDifferences {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ContentGenderDifferences value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ContentGenderDifferences() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ContentGenderDifferences value)  $default,){
final _that = this;
switch (_that) {
case _ContentGenderDifferences():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ContentGenderDifferences value)?  $default,){
final _that = this;
switch (_that) {
case _ContentGenderDifferences() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<String> male,  List<String> female,  String? note)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ContentGenderDifferences() when $default != null:
return $default(_that.male,_that.female,_that.note);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<String> male,  List<String> female,  String? note)  $default,) {final _that = this;
switch (_that) {
case _ContentGenderDifferences():
return $default(_that.male,_that.female,_that.note);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<String> male,  List<String> female,  String? note)?  $default,) {final _that = this;
switch (_that) {
case _ContentGenderDifferences() when $default != null:
return $default(_that.male,_that.female,_that.note);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ContentGenderDifferences implements ContentGenderDifferences {
  const _ContentGenderDifferences({ List<String> male = const <String>[],  List<String> female = const <String>[], this.note}): _male = male,_female = female;
  factory _ContentGenderDifferences.fromJson(Map<String, dynamic> json) => _$ContentGenderDifferencesFromJson(json);

 final  List<String> _male;
@override@JsonKey() List<String> get male {
  if (_male is EqualUnmodifiableListView) return _male;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_male);
}

 final  List<String> _female;
@override@JsonKey() List<String> get female {
  if (_female is EqualUnmodifiableListView) return _female;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_female);
}

@override final  String? note;

/// Create a copy of ContentGenderDifferences
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ContentGenderDifferencesCopyWith<_ContentGenderDifferences> get copyWith => __$ContentGenderDifferencesCopyWithImpl<_ContentGenderDifferences>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ContentGenderDifferencesToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ContentGenderDifferences&&const DeepCollectionEquality().equals(other.male, _male)&&const DeepCollectionEquality().equals(other.female, _female)&&(identical(other.note, note) || other.note == note));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_male),const DeepCollectionEquality().hash(_female),note);
}

@override
String toString() {
    return 'ContentGenderDifferences(male: $male, female: $female, note: $note)';
}


}

/// @nodoc
abstract mixin class _$ContentGenderDifferencesCopyWith<$Res> implements $ContentGenderDifferencesCopyWith<$Res> {
  factory _$ContentGenderDifferencesCopyWith(_ContentGenderDifferences value, $Res Function(_ContentGenderDifferences) _then) = __$ContentGenderDifferencesCopyWithImpl;
@override @useResult
$Res call({
 List<String> male, List<String> female, String? note
});




}
/// @nodoc
class __$ContentGenderDifferencesCopyWithImpl<$Res>
    implements _$ContentGenderDifferencesCopyWith<$Res> {
  __$ContentGenderDifferencesCopyWithImpl(this._self, this._then);

  final _ContentGenderDifferences _self;
  final $Res Function(_ContentGenderDifferences) _then;

/// Create a copy of ContentGenderDifferences
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? male = null,Object? female = null,Object? note = freezed,}) {
  return _then(_ContentGenderDifferences(
male: null == male ? _self._male : male // ignore: cast_nullable_to_non_nullable
as List<String>,female: null == female ? _self._female : female // ignore: cast_nullable_to_non_nullable
as List<String>,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ContentPrayerStepDetail {

 int get stepNumber; String get rakatLabel; List<int>? get rakatsApplicable; String get titleBn; String get descriptionBn; String? get recitationId; ContentRecitation? get recitationCustom; String? get maleRule; String? get femaleRule; String? get tips;
/// Create a copy of ContentPrayerStepDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContentPrayerStepDetailCopyWith<ContentPrayerStepDetail> get copyWith => _$ContentPrayerStepDetailCopyWithImpl<ContentPrayerStepDetail>(this as ContentPrayerStepDetail, _$identity);

  /// Serializes this ContentPrayerStepDetail to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ContentPrayerStepDetail;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContentPrayerStepDetail&&(identical(other.stepNumber, _this.stepNumber) || other.stepNumber == _this.stepNumber)&&(identical(other.rakatLabel, _this.rakatLabel) || other.rakatLabel == _this.rakatLabel)&&const DeepCollectionEquality().equals(other.rakatsApplicable, _this.rakatsApplicable)&&(identical(other.titleBn, _this.titleBn) || other.titleBn == _this.titleBn)&&(identical(other.descriptionBn, _this.descriptionBn) || other.descriptionBn == _this.descriptionBn)&&(identical(other.recitationId, _this.recitationId) || other.recitationId == _this.recitationId)&&(identical(other.recitationCustom, _this.recitationCustom) || other.recitationCustom == _this.recitationCustom)&&(identical(other.maleRule, _this.maleRule) || other.maleRule == _this.maleRule)&&(identical(other.femaleRule, _this.femaleRule) || other.femaleRule == _this.femaleRule)&&(identical(other.tips, _this.tips) || other.tips == _this.tips));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ContentPrayerStepDetail;
  return Object.hash(runtimeType,_this.stepNumber,_this.rakatLabel,const DeepCollectionEquality().hash(_this.rakatsApplicable),_this.titleBn,_this.descriptionBn,_this.recitationId,_this.recitationCustom,_this.maleRule,_this.femaleRule,_this.tips);
}

@override
String toString() {
  final _this = this as ContentPrayerStepDetail;
  return 'ContentPrayerStepDetail(stepNumber: ${_this.stepNumber}, rakatLabel: ${_this.rakatLabel}, rakatsApplicable: ${_this.rakatsApplicable}, titleBn: ${_this.titleBn}, descriptionBn: ${_this.descriptionBn}, recitationId: ${_this.recitationId}, recitationCustom: ${_this.recitationCustom}, maleRule: ${_this.maleRule}, femaleRule: ${_this.femaleRule}, tips: ${_this.tips})';
}


}

/// @nodoc
abstract mixin class $ContentPrayerStepDetailCopyWith<$Res>  {
  factory $ContentPrayerStepDetailCopyWith(ContentPrayerStepDetail value, $Res Function(ContentPrayerStepDetail) _then) = _$ContentPrayerStepDetailCopyWithImpl;
@useResult
$Res call({
 int stepNumber, String rakatLabel, List<int>? rakatsApplicable, String titleBn, String descriptionBn, String? recitationId, ContentRecitation? recitationCustom, String? maleRule, String? femaleRule, String? tips
});


$ContentRecitationCopyWith<$Res>? get recitationCustom;

}
/// @nodoc
class _$ContentPrayerStepDetailCopyWithImpl<$Res>
    implements $ContentPrayerStepDetailCopyWith<$Res> {
  _$ContentPrayerStepDetailCopyWithImpl(this._self, this._then);

  final ContentPrayerStepDetail _self;
  final $Res Function(ContentPrayerStepDetail) _then;

/// Create a copy of ContentPrayerStepDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? stepNumber = null,Object? rakatLabel = null,Object? rakatsApplicable = freezed,Object? titleBn = null,Object? descriptionBn = null,Object? recitationId = freezed,Object? recitationCustom = freezed,Object? maleRule = freezed,Object? femaleRule = freezed,Object? tips = freezed,}) {
  return _then(ContentPrayerStepDetail(
stepNumber: null == stepNumber ? _self.stepNumber : stepNumber // ignore: cast_nullable_to_non_nullable
as int,rakatLabel: null == rakatLabel ? _self.rakatLabel : rakatLabel // ignore: cast_nullable_to_non_nullable
as String,rakatsApplicable: freezed == rakatsApplicable ? _self.rakatsApplicable : rakatsApplicable // ignore: cast_nullable_to_non_nullable
as List<int>?,titleBn: null == titleBn ? _self.titleBn : titleBn // ignore: cast_nullable_to_non_nullable
as String,descriptionBn: null == descriptionBn ? _self.descriptionBn : descriptionBn // ignore: cast_nullable_to_non_nullable
as String,recitationId: freezed == recitationId ? _self.recitationId : recitationId // ignore: cast_nullable_to_non_nullable
as String?,recitationCustom: freezed == recitationCustom ? _self.recitationCustom : recitationCustom // ignore: cast_nullable_to_non_nullable
as ContentRecitation?,maleRule: freezed == maleRule ? _self.maleRule : maleRule // ignore: cast_nullable_to_non_nullable
as String?,femaleRule: freezed == femaleRule ? _self.femaleRule : femaleRule // ignore: cast_nullable_to_non_nullable
as String?,tips: freezed == tips ? _self.tips : tips // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of ContentPrayerStepDetail
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
}
}


/// Adds pattern-matching-related methods to [ContentPrayerStepDetail].
extension ContentPrayerStepDetailPatterns on ContentPrayerStepDetail {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ContentPrayerStepDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ContentPrayerStepDetail() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ContentPrayerStepDetail value)  $default,){
final _that = this;
switch (_that) {
case _ContentPrayerStepDetail():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ContentPrayerStepDetail value)?  $default,){
final _that = this;
switch (_that) {
case _ContentPrayerStepDetail() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int stepNumber,  String rakatLabel,  List<int>? rakatsApplicable,  String titleBn,  String descriptionBn,  String? recitationId,  ContentRecitation? recitationCustom,  String? maleRule,  String? femaleRule,  String? tips)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ContentPrayerStepDetail() when $default != null:
return $default(_that.stepNumber,_that.rakatLabel,_that.rakatsApplicable,_that.titleBn,_that.descriptionBn,_that.recitationId,_that.recitationCustom,_that.maleRule,_that.femaleRule,_that.tips);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int stepNumber,  String rakatLabel,  List<int>? rakatsApplicable,  String titleBn,  String descriptionBn,  String? recitationId,  ContentRecitation? recitationCustom,  String? maleRule,  String? femaleRule,  String? tips)  $default,) {final _that = this;
switch (_that) {
case _ContentPrayerStepDetail():
return $default(_that.stepNumber,_that.rakatLabel,_that.rakatsApplicable,_that.titleBn,_that.descriptionBn,_that.recitationId,_that.recitationCustom,_that.maleRule,_that.femaleRule,_that.tips);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int stepNumber,  String rakatLabel,  List<int>? rakatsApplicable,  String titleBn,  String descriptionBn,  String? recitationId,  ContentRecitation? recitationCustom,  String? maleRule,  String? femaleRule,  String? tips)?  $default,) {final _that = this;
switch (_that) {
case _ContentPrayerStepDetail() when $default != null:
return $default(_that.stepNumber,_that.rakatLabel,_that.rakatsApplicable,_that.titleBn,_that.descriptionBn,_that.recitationId,_that.recitationCustom,_that.maleRule,_that.femaleRule,_that.tips);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ContentPrayerStepDetail implements ContentPrayerStepDetail {
  const _ContentPrayerStepDetail({required this.stepNumber, required this.rakatLabel,  List<int>? rakatsApplicable, required this.titleBn, required this.descriptionBn, this.recitationId, this.recitationCustom, this.maleRule, this.femaleRule, this.tips}): _rakatsApplicable = rakatsApplicable;
  factory _ContentPrayerStepDetail.fromJson(Map<String, dynamic> json) => _$ContentPrayerStepDetailFromJson(json);

@override final  int stepNumber;
@override final  String rakatLabel;
 final  List<int>? _rakatsApplicable;
@override List<int>? get rakatsApplicable {
  final value = _rakatsApplicable;
  if (value == null) return null;
  if (_rakatsApplicable is EqualUnmodifiableListView) return _rakatsApplicable;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  String titleBn;
@override final  String descriptionBn;
@override final  String? recitationId;
@override final  ContentRecitation? recitationCustom;
@override final  String? maleRule;
@override final  String? femaleRule;
@override final  String? tips;

/// Create a copy of ContentPrayerStepDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ContentPrayerStepDetailCopyWith<_ContentPrayerStepDetail> get copyWith => __$ContentPrayerStepDetailCopyWithImpl<_ContentPrayerStepDetail>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ContentPrayerStepDetailToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ContentPrayerStepDetail&&(identical(other.stepNumber, stepNumber) || other.stepNumber == stepNumber)&&(identical(other.rakatLabel, rakatLabel) || other.rakatLabel == rakatLabel)&&const DeepCollectionEquality().equals(other.rakatsApplicable, _rakatsApplicable)&&(identical(other.titleBn, titleBn) || other.titleBn == titleBn)&&(identical(other.descriptionBn, descriptionBn) || other.descriptionBn == descriptionBn)&&(identical(other.recitationId, recitationId) || other.recitationId == recitationId)&&(identical(other.recitationCustom, recitationCustom) || other.recitationCustom == recitationCustom)&&(identical(other.maleRule, maleRule) || other.maleRule == maleRule)&&(identical(other.femaleRule, femaleRule) || other.femaleRule == femaleRule)&&(identical(other.tips, tips) || other.tips == tips));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,stepNumber,rakatLabel,const DeepCollectionEquality().hash(_rakatsApplicable),titleBn,descriptionBn,recitationId,recitationCustom,maleRule,femaleRule,tips);
}

@override
String toString() {
    return 'ContentPrayerStepDetail(stepNumber: $stepNumber, rakatLabel: $rakatLabel, rakatsApplicable: $rakatsApplicable, titleBn: $titleBn, descriptionBn: $descriptionBn, recitationId: $recitationId, recitationCustom: $recitationCustom, maleRule: $maleRule, femaleRule: $femaleRule, tips: $tips)';
}


}

/// @nodoc
abstract mixin class _$ContentPrayerStepDetailCopyWith<$Res> implements $ContentPrayerStepDetailCopyWith<$Res> {
  factory _$ContentPrayerStepDetailCopyWith(_ContentPrayerStepDetail value, $Res Function(_ContentPrayerStepDetail) _then) = __$ContentPrayerStepDetailCopyWithImpl;
@override @useResult
$Res call({
 int stepNumber, String rakatLabel, List<int>? rakatsApplicable, String titleBn, String descriptionBn, String? recitationId, ContentRecitation? recitationCustom, String? maleRule, String? femaleRule, String? tips
});


@override $ContentRecitationCopyWith<$Res>? get recitationCustom;

}
/// @nodoc
class __$ContentPrayerStepDetailCopyWithImpl<$Res>
    implements _$ContentPrayerStepDetailCopyWith<$Res> {
  __$ContentPrayerStepDetailCopyWithImpl(this._self, this._then);

  final _ContentPrayerStepDetail _self;
  final $Res Function(_ContentPrayerStepDetail) _then;

/// Create a copy of ContentPrayerStepDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? stepNumber = null,Object? rakatLabel = null,Object? rakatsApplicable = freezed,Object? titleBn = null,Object? descriptionBn = null,Object? recitationId = freezed,Object? recitationCustom = freezed,Object? maleRule = freezed,Object? femaleRule = freezed,Object? tips = freezed,}) {
  return _then(_ContentPrayerStepDetail(
stepNumber: null == stepNumber ? _self.stepNumber : stepNumber // ignore: cast_nullable_to_non_nullable
as int,rakatLabel: null == rakatLabel ? _self.rakatLabel : rakatLabel // ignore: cast_nullable_to_non_nullable
as String,rakatsApplicable: freezed == rakatsApplicable ? _self._rakatsApplicable : rakatsApplicable // ignore: cast_nullable_to_non_nullable
as List<int>?,titleBn: null == titleBn ? _self.titleBn : titleBn // ignore: cast_nullable_to_non_nullable
as String,descriptionBn: null == descriptionBn ? _self.descriptionBn : descriptionBn // ignore: cast_nullable_to_non_nullable
as String,recitationId: freezed == recitationId ? _self.recitationId : recitationId // ignore: cast_nullable_to_non_nullable
as String?,recitationCustom: freezed == recitationCustom ? _self.recitationCustom : recitationCustom // ignore: cast_nullable_to_non_nullable
as ContentRecitation?,maleRule: freezed == maleRule ? _self.maleRule : maleRule // ignore: cast_nullable_to_non_nullable
as String?,femaleRule: freezed == femaleRule ? _self.femaleRule : femaleRule // ignore: cast_nullable_to_non_nullable
as String?,tips: freezed == tips ? _self.tips : tips // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of ContentPrayerStepDetail
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
}
}


/// @nodoc
mixin _$ContentPrayerFAQ {

 String get question; String get answer;
/// Create a copy of ContentPrayerFAQ
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContentPrayerFAQCopyWith<ContentPrayerFAQ> get copyWith => _$ContentPrayerFAQCopyWithImpl<ContentPrayerFAQ>(this as ContentPrayerFAQ, _$identity);

  /// Serializes this ContentPrayerFAQ to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ContentPrayerFAQ;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContentPrayerFAQ&&(identical(other.question, _this.question) || other.question == _this.question)&&(identical(other.answer, _this.answer) || other.answer == _this.answer));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ContentPrayerFAQ;
  return Object.hash(runtimeType,_this.question,_this.answer);
}

@override
String toString() {
  final _this = this as ContentPrayerFAQ;
  return 'ContentPrayerFAQ(question: ${_this.question}, answer: ${_this.answer})';
}


}

/// @nodoc
abstract mixin class $ContentPrayerFAQCopyWith<$Res>  {
  factory $ContentPrayerFAQCopyWith(ContentPrayerFAQ value, $Res Function(ContentPrayerFAQ) _then) = _$ContentPrayerFAQCopyWithImpl;
@useResult
$Res call({
 String question, String answer
});




}
/// @nodoc
class _$ContentPrayerFAQCopyWithImpl<$Res>
    implements $ContentPrayerFAQCopyWith<$Res> {
  _$ContentPrayerFAQCopyWithImpl(this._self, this._then);

  final ContentPrayerFAQ _self;
  final $Res Function(ContentPrayerFAQ) _then;

/// Create a copy of ContentPrayerFAQ
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? question = null,Object? answer = null,}) {
  return _then(ContentPrayerFAQ(
question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,answer: null == answer ? _self.answer : answer // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ContentPrayerFAQ].
extension ContentPrayerFAQPatterns on ContentPrayerFAQ {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ContentPrayerFAQ value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ContentPrayerFAQ() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ContentPrayerFAQ value)  $default,){
final _that = this;
switch (_that) {
case _ContentPrayerFAQ():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ContentPrayerFAQ value)?  $default,){
final _that = this;
switch (_that) {
case _ContentPrayerFAQ() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String question,  String answer)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ContentPrayerFAQ() when $default != null:
return $default(_that.question,_that.answer);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String question,  String answer)  $default,) {final _that = this;
switch (_that) {
case _ContentPrayerFAQ():
return $default(_that.question,_that.answer);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String question,  String answer)?  $default,) {final _that = this;
switch (_that) {
case _ContentPrayerFAQ() when $default != null:
return $default(_that.question,_that.answer);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ContentPrayerFAQ implements ContentPrayerFAQ {
  const _ContentPrayerFAQ({required this.question, required this.answer});
  factory _ContentPrayerFAQ.fromJson(Map<String, dynamic> json) => _$ContentPrayerFAQFromJson(json);

@override final  String question;
@override final  String answer;

/// Create a copy of ContentPrayerFAQ
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ContentPrayerFAQCopyWith<_ContentPrayerFAQ> get copyWith => __$ContentPrayerFAQCopyWithImpl<_ContentPrayerFAQ>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ContentPrayerFAQToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ContentPrayerFAQ&&(identical(other.question, question) || other.question == question)&&(identical(other.answer, answer) || other.answer == answer));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,question,answer);
}

@override
String toString() {
    return 'ContentPrayerFAQ(question: $question, answer: $answer)';
}


}

/// @nodoc
abstract mixin class _$ContentPrayerFAQCopyWith<$Res> implements $ContentPrayerFAQCopyWith<$Res> {
  factory _$ContentPrayerFAQCopyWith(_ContentPrayerFAQ value, $Res Function(_ContentPrayerFAQ) _then) = __$ContentPrayerFAQCopyWithImpl;
@override @useResult
$Res call({
 String question, String answer
});




}
/// @nodoc
class __$ContentPrayerFAQCopyWithImpl<$Res>
    implements _$ContentPrayerFAQCopyWith<$Res> {
  __$ContentPrayerFAQCopyWithImpl(this._self, this._then);

  final _ContentPrayerFAQ _self;
  final $Res Function(_ContentPrayerFAQ) _then;

/// Create a copy of ContentPrayerFAQ
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? question = null,Object? answer = null,}) {
  return _then(_ContentPrayerFAQ(
question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,answer: null == answer ? _self.answer : answer // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ContentSpecialRule {

 String get title; String get description; ContentReference? get reference;
/// Create a copy of ContentSpecialRule
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContentSpecialRuleCopyWith<ContentSpecialRule> get copyWith => _$ContentSpecialRuleCopyWithImpl<ContentSpecialRule>(this as ContentSpecialRule, _$identity);

  /// Serializes this ContentSpecialRule to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ContentSpecialRule;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContentSpecialRule&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.reference, _this.reference) || other.reference == _this.reference));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ContentSpecialRule;
  return Object.hash(runtimeType,_this.title,_this.description,_this.reference);
}

@override
String toString() {
  final _this = this as ContentSpecialRule;
  return 'ContentSpecialRule(title: ${_this.title}, description: ${_this.description}, reference: ${_this.reference})';
}


}

/// @nodoc
abstract mixin class $ContentSpecialRuleCopyWith<$Res>  {
  factory $ContentSpecialRuleCopyWith(ContentSpecialRule value, $Res Function(ContentSpecialRule) _then) = _$ContentSpecialRuleCopyWithImpl;
@useResult
$Res call({
 String title, String description, ContentReference? reference
});


$ContentReferenceCopyWith<$Res>? get reference;

}
/// @nodoc
class _$ContentSpecialRuleCopyWithImpl<$Res>
    implements $ContentSpecialRuleCopyWith<$Res> {
  _$ContentSpecialRuleCopyWithImpl(this._self, this._then);

  final ContentSpecialRule _self;
  final $Res Function(ContentSpecialRule) _then;

/// Create a copy of ContentSpecialRule
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? description = null,Object? reference = freezed,}) {
  return _then(ContentSpecialRule(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,reference: freezed == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as ContentReference?,
  ));
}
/// Create a copy of ContentSpecialRule
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


/// Adds pattern-matching-related methods to [ContentSpecialRule].
extension ContentSpecialRulePatterns on ContentSpecialRule {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ContentSpecialRule value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ContentSpecialRule() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ContentSpecialRule value)  $default,){
final _that = this;
switch (_that) {
case _ContentSpecialRule():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ContentSpecialRule value)?  $default,){
final _that = this;
switch (_that) {
case _ContentSpecialRule() when $default != null:
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
case _ContentSpecialRule() when $default != null:
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
case _ContentSpecialRule():
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
case _ContentSpecialRule() when $default != null:
return $default(_that.title,_that.description,_that.reference);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ContentSpecialRule implements ContentSpecialRule {
  const _ContentSpecialRule({required this.title, required this.description, this.reference});
  factory _ContentSpecialRule.fromJson(Map<String, dynamic> json) => _$ContentSpecialRuleFromJson(json);

@override final  String title;
@override final  String description;
@override final  ContentReference? reference;

/// Create a copy of ContentSpecialRule
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ContentSpecialRuleCopyWith<_ContentSpecialRule> get copyWith => __$ContentSpecialRuleCopyWithImpl<_ContentSpecialRule>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ContentSpecialRuleToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ContentSpecialRule&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.reference, reference) || other.reference == reference));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,title,description,reference);
}

@override
String toString() {
    return 'ContentSpecialRule(title: $title, description: $description, reference: $reference)';
}


}

/// @nodoc
abstract mixin class _$ContentSpecialRuleCopyWith<$Res> implements $ContentSpecialRuleCopyWith<$Res> {
  factory _$ContentSpecialRuleCopyWith(_ContentSpecialRule value, $Res Function(_ContentSpecialRule) _then) = __$ContentSpecialRuleCopyWithImpl;
@override @useResult
$Res call({
 String title, String description, ContentReference? reference
});


@override $ContentReferenceCopyWith<$Res>? get reference;

}
/// @nodoc
class __$ContentSpecialRuleCopyWithImpl<$Res>
    implements _$ContentSpecialRuleCopyWith<$Res> {
  __$ContentSpecialRuleCopyWithImpl(this._self, this._then);

  final _ContentSpecialRule _self;
  final $Res Function(_ContentSpecialRule) _then;

/// Create a copy of ContentSpecialRule
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? description = null,Object? reference = freezed,}) {
  return _then(_ContentSpecialRule(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,reference: freezed == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as ContentReference?,
  ));
}

/// Create a copy of ContentSpecialRule
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
mixin _$ContentPrayerType {

 String get slug; String get nameBn; String get nameAr; String get nameEn; ContentPrayerCategory get category; ContentPrayerGroup get group; String get timeDescriptionBn; List<ContentRakatUnit> get rakatUnits; int get totalRakats; ContentRecitation get niyyat; ContentFazilat? get fazilat; List<ContentPrayerStepDetail> get steps; ContentGenderDifferences? get genderDifferences; List<String> get commonMistakes; List<ContentPrayerFAQ> get faqs; List<ContentReference> get references; List<String>? get relatedPrayers; List<String>? get relatedRulings; String get simulatorConfigId; List<ContentSpecialRule>? get specialRules; ContentReviewStatus? get reviewStatus;
/// Create a copy of ContentPrayerType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContentPrayerTypeCopyWith<ContentPrayerType> get copyWith => _$ContentPrayerTypeCopyWithImpl<ContentPrayerType>(this as ContentPrayerType, _$identity);

  /// Serializes this ContentPrayerType to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ContentPrayerType;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContentPrayerType&&(identical(other.slug, _this.slug) || other.slug == _this.slug)&&(identical(other.nameBn, _this.nameBn) || other.nameBn == _this.nameBn)&&(identical(other.nameAr, _this.nameAr) || other.nameAr == _this.nameAr)&&(identical(other.nameEn, _this.nameEn) || other.nameEn == _this.nameEn)&&(identical(other.category, _this.category) || other.category == _this.category)&&(identical(other.group, _this.group) || other.group == _this.group)&&(identical(other.timeDescriptionBn, _this.timeDescriptionBn) || other.timeDescriptionBn == _this.timeDescriptionBn)&&const DeepCollectionEquality().equals(other.rakatUnits, _this.rakatUnits)&&(identical(other.totalRakats, _this.totalRakats) || other.totalRakats == _this.totalRakats)&&(identical(other.niyyat, _this.niyyat) || other.niyyat == _this.niyyat)&&(identical(other.fazilat, _this.fazilat) || other.fazilat == _this.fazilat)&&const DeepCollectionEquality().equals(other.steps, _this.steps)&&(identical(other.genderDifferences, _this.genderDifferences) || other.genderDifferences == _this.genderDifferences)&&const DeepCollectionEquality().equals(other.commonMistakes, _this.commonMistakes)&&const DeepCollectionEquality().equals(other.faqs, _this.faqs)&&const DeepCollectionEquality().equals(other.references, _this.references)&&const DeepCollectionEquality().equals(other.relatedPrayers, _this.relatedPrayers)&&const DeepCollectionEquality().equals(other.relatedRulings, _this.relatedRulings)&&(identical(other.simulatorConfigId, _this.simulatorConfigId) || other.simulatorConfigId == _this.simulatorConfigId)&&const DeepCollectionEquality().equals(other.specialRules, _this.specialRules)&&(identical(other.reviewStatus, _this.reviewStatus) || other.reviewStatus == _this.reviewStatus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ContentPrayerType;
  return Object.hashAll([runtimeType,_this.slug,_this.nameBn,_this.nameAr,_this.nameEn,_this.category,_this.group,_this.timeDescriptionBn,const DeepCollectionEquality().hash(_this.rakatUnits),_this.totalRakats,_this.niyyat,_this.fazilat,const DeepCollectionEquality().hash(_this.steps),_this.genderDifferences,const DeepCollectionEquality().hash(_this.commonMistakes),const DeepCollectionEquality().hash(_this.faqs),const DeepCollectionEquality().hash(_this.references),const DeepCollectionEquality().hash(_this.relatedPrayers),const DeepCollectionEquality().hash(_this.relatedRulings),_this.simulatorConfigId,const DeepCollectionEquality().hash(_this.specialRules),_this.reviewStatus]);
}

@override
String toString() {
  final _this = this as ContentPrayerType;
  return 'ContentPrayerType(slug: ${_this.slug}, nameBn: ${_this.nameBn}, nameAr: ${_this.nameAr}, nameEn: ${_this.nameEn}, category: ${_this.category}, group: ${_this.group}, timeDescriptionBn: ${_this.timeDescriptionBn}, rakatUnits: ${_this.rakatUnits}, totalRakats: ${_this.totalRakats}, niyyat: ${_this.niyyat}, fazilat: ${_this.fazilat}, steps: ${_this.steps}, genderDifferences: ${_this.genderDifferences}, commonMistakes: ${_this.commonMistakes}, faqs: ${_this.faqs}, references: ${_this.references}, relatedPrayers: ${_this.relatedPrayers}, relatedRulings: ${_this.relatedRulings}, simulatorConfigId: ${_this.simulatorConfigId}, specialRules: ${_this.specialRules}, reviewStatus: ${_this.reviewStatus})';
}


}

/// @nodoc
abstract mixin class $ContentPrayerTypeCopyWith<$Res>  {
  factory $ContentPrayerTypeCopyWith(ContentPrayerType value, $Res Function(ContentPrayerType) _then) = _$ContentPrayerTypeCopyWithImpl;
@useResult
$Res call({
 String slug, String nameBn, String nameAr, String nameEn, ContentPrayerCategory category, ContentPrayerGroup group, String timeDescriptionBn, List<ContentRakatUnit> rakatUnits, int totalRakats, ContentRecitation niyyat, ContentFazilat? fazilat, List<ContentPrayerStepDetail> steps, ContentGenderDifferences? genderDifferences, List<String> commonMistakes, List<ContentPrayerFAQ> faqs, List<ContentReference> references, List<String>? relatedPrayers, List<String>? relatedRulings, String simulatorConfigId, List<ContentSpecialRule>? specialRules, ContentReviewStatus? reviewStatus
});


$ContentRecitationCopyWith<$Res> get niyyat;$ContentFazilatCopyWith<$Res>? get fazilat;$ContentGenderDifferencesCopyWith<$Res>? get genderDifferences;

}
/// @nodoc
class _$ContentPrayerTypeCopyWithImpl<$Res>
    implements $ContentPrayerTypeCopyWith<$Res> {
  _$ContentPrayerTypeCopyWithImpl(this._self, this._then);

  final ContentPrayerType _self;
  final $Res Function(ContentPrayerType) _then;

/// Create a copy of ContentPrayerType
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? slug = null,Object? nameBn = null,Object? nameAr = null,Object? nameEn = null,Object? category = null,Object? group = null,Object? timeDescriptionBn = null,Object? rakatUnits = null,Object? totalRakats = null,Object? niyyat = null,Object? fazilat = freezed,Object? steps = null,Object? genderDifferences = freezed,Object? commonMistakes = null,Object? faqs = null,Object? references = null,Object? relatedPrayers = freezed,Object? relatedRulings = freezed,Object? simulatorConfigId = null,Object? specialRules = freezed,Object? reviewStatus = freezed,}) {
  return _then(ContentPrayerType(
slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,nameBn: null == nameBn ? _self.nameBn : nameBn // ignore: cast_nullable_to_non_nullable
as String,nameAr: null == nameAr ? _self.nameAr : nameAr // ignore: cast_nullable_to_non_nullable
as String,nameEn: null == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as ContentPrayerCategory,group: null == group ? _self.group : group // ignore: cast_nullable_to_non_nullable
as ContentPrayerGroup,timeDescriptionBn: null == timeDescriptionBn ? _self.timeDescriptionBn : timeDescriptionBn // ignore: cast_nullable_to_non_nullable
as String,rakatUnits: null == rakatUnits ? _self.rakatUnits : rakatUnits // ignore: cast_nullable_to_non_nullable
as List<ContentRakatUnit>,totalRakats: null == totalRakats ? _self.totalRakats : totalRakats // ignore: cast_nullable_to_non_nullable
as int,niyyat: null == niyyat ? _self.niyyat : niyyat // ignore: cast_nullable_to_non_nullable
as ContentRecitation,fazilat: freezed == fazilat ? _self.fazilat : fazilat // ignore: cast_nullable_to_non_nullable
as ContentFazilat?,steps: null == steps ? _self.steps : steps // ignore: cast_nullable_to_non_nullable
as List<ContentPrayerStepDetail>,genderDifferences: freezed == genderDifferences ? _self.genderDifferences : genderDifferences // ignore: cast_nullable_to_non_nullable
as ContentGenderDifferences?,commonMistakes: null == commonMistakes ? _self.commonMistakes : commonMistakes // ignore: cast_nullable_to_non_nullable
as List<String>,faqs: null == faqs ? _self.faqs : faqs // ignore: cast_nullable_to_non_nullable
as List<ContentPrayerFAQ>,references: null == references ? _self.references : references // ignore: cast_nullable_to_non_nullable
as List<ContentReference>,relatedPrayers: freezed == relatedPrayers ? _self.relatedPrayers : relatedPrayers // ignore: cast_nullable_to_non_nullable
as List<String>?,relatedRulings: freezed == relatedRulings ? _self.relatedRulings : relatedRulings // ignore: cast_nullable_to_non_nullable
as List<String>?,simulatorConfigId: null == simulatorConfigId ? _self.simulatorConfigId : simulatorConfigId // ignore: cast_nullable_to_non_nullable
as String,specialRules: freezed == specialRules ? _self.specialRules : specialRules // ignore: cast_nullable_to_non_nullable
as List<ContentSpecialRule>?,reviewStatus: freezed == reviewStatus ? _self.reviewStatus : reviewStatus // ignore: cast_nullable_to_non_nullable
as ContentReviewStatus?,
  ));
}
/// Create a copy of ContentPrayerType
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ContentRecitationCopyWith<$Res> get niyyat {
  
  return $ContentRecitationCopyWith<$Res>(_self.niyyat, (value) {
    return _then(_self.copyWith(niyyat: value));
  });
}/// Create a copy of ContentPrayerType
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
}/// Create a copy of ContentPrayerType
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


/// Adds pattern-matching-related methods to [ContentPrayerType].
extension ContentPrayerTypePatterns on ContentPrayerType {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ContentPrayerType value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ContentPrayerType() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ContentPrayerType value)  $default,){
final _that = this;
switch (_that) {
case _ContentPrayerType():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ContentPrayerType value)?  $default,){
final _that = this;
switch (_that) {
case _ContentPrayerType() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String slug,  String nameBn,  String nameAr,  String nameEn,  ContentPrayerCategory category,  ContentPrayerGroup group,  String timeDescriptionBn,  List<ContentRakatUnit> rakatUnits,  int totalRakats,  ContentRecitation niyyat,  ContentFazilat? fazilat,  List<ContentPrayerStepDetail> steps,  ContentGenderDifferences? genderDifferences,  List<String> commonMistakes,  List<ContentPrayerFAQ> faqs,  List<ContentReference> references,  List<String>? relatedPrayers,  List<String>? relatedRulings,  String simulatorConfigId,  List<ContentSpecialRule>? specialRules,  ContentReviewStatus? reviewStatus)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ContentPrayerType() when $default != null:
return $default(_that.slug,_that.nameBn,_that.nameAr,_that.nameEn,_that.category,_that.group,_that.timeDescriptionBn,_that.rakatUnits,_that.totalRakats,_that.niyyat,_that.fazilat,_that.steps,_that.genderDifferences,_that.commonMistakes,_that.faqs,_that.references,_that.relatedPrayers,_that.relatedRulings,_that.simulatorConfigId,_that.specialRules,_that.reviewStatus);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String slug,  String nameBn,  String nameAr,  String nameEn,  ContentPrayerCategory category,  ContentPrayerGroup group,  String timeDescriptionBn,  List<ContentRakatUnit> rakatUnits,  int totalRakats,  ContentRecitation niyyat,  ContentFazilat? fazilat,  List<ContentPrayerStepDetail> steps,  ContentGenderDifferences? genderDifferences,  List<String> commonMistakes,  List<ContentPrayerFAQ> faqs,  List<ContentReference> references,  List<String>? relatedPrayers,  List<String>? relatedRulings,  String simulatorConfigId,  List<ContentSpecialRule>? specialRules,  ContentReviewStatus? reviewStatus)  $default,) {final _that = this;
switch (_that) {
case _ContentPrayerType():
return $default(_that.slug,_that.nameBn,_that.nameAr,_that.nameEn,_that.category,_that.group,_that.timeDescriptionBn,_that.rakatUnits,_that.totalRakats,_that.niyyat,_that.fazilat,_that.steps,_that.genderDifferences,_that.commonMistakes,_that.faqs,_that.references,_that.relatedPrayers,_that.relatedRulings,_that.simulatorConfigId,_that.specialRules,_that.reviewStatus);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String slug,  String nameBn,  String nameAr,  String nameEn,  ContentPrayerCategory category,  ContentPrayerGroup group,  String timeDescriptionBn,  List<ContentRakatUnit> rakatUnits,  int totalRakats,  ContentRecitation niyyat,  ContentFazilat? fazilat,  List<ContentPrayerStepDetail> steps,  ContentGenderDifferences? genderDifferences,  List<String> commonMistakes,  List<ContentPrayerFAQ> faqs,  List<ContentReference> references,  List<String>? relatedPrayers,  List<String>? relatedRulings,  String simulatorConfigId,  List<ContentSpecialRule>? specialRules,  ContentReviewStatus? reviewStatus)?  $default,) {final _that = this;
switch (_that) {
case _ContentPrayerType() when $default != null:
return $default(_that.slug,_that.nameBn,_that.nameAr,_that.nameEn,_that.category,_that.group,_that.timeDescriptionBn,_that.rakatUnits,_that.totalRakats,_that.niyyat,_that.fazilat,_that.steps,_that.genderDifferences,_that.commonMistakes,_that.faqs,_that.references,_that.relatedPrayers,_that.relatedRulings,_that.simulatorConfigId,_that.specialRules,_that.reviewStatus);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ContentPrayerType implements ContentPrayerType {
  const _ContentPrayerType({required this.slug, required this.nameBn, required this.nameAr, required this.nameEn, required this.category, required this.group, required this.timeDescriptionBn,  List<ContentRakatUnit> rakatUnits = const <ContentRakatUnit>[], required this.totalRakats, required this.niyyat, this.fazilat,  List<ContentPrayerStepDetail> steps = const <ContentPrayerStepDetail>[], this.genderDifferences,  List<String> commonMistakes = const <String>[],  List<ContentPrayerFAQ> faqs = const <ContentPrayerFAQ>[],  List<ContentReference> references = const <ContentReference>[],  List<String>? relatedPrayers,  List<String>? relatedRulings, this.simulatorConfigId = '',  List<ContentSpecialRule>? specialRules, this.reviewStatus = ContentReviewStatus.verified}): _rakatUnits = rakatUnits,_steps = steps,_commonMistakes = commonMistakes,_faqs = faqs,_references = references,_relatedPrayers = relatedPrayers,_relatedRulings = relatedRulings,_specialRules = specialRules;
  factory _ContentPrayerType.fromJson(Map<String, dynamic> json) => _$ContentPrayerTypeFromJson(json);

@override final  String slug;
@override final  String nameBn;
@override final  String nameAr;
@override final  String nameEn;
@override final  ContentPrayerCategory category;
@override final  ContentPrayerGroup group;
@override final  String timeDescriptionBn;
 final  List<ContentRakatUnit> _rakatUnits;
@override@JsonKey() List<ContentRakatUnit> get rakatUnits {
  if (_rakatUnits is EqualUnmodifiableListView) return _rakatUnits;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rakatUnits);
}

@override final  int totalRakats;
@override final  ContentRecitation niyyat;
@override final  ContentFazilat? fazilat;
 final  List<ContentPrayerStepDetail> _steps;
@override@JsonKey() List<ContentPrayerStepDetail> get steps {
  if (_steps is EqualUnmodifiableListView) return _steps;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_steps);
}

@override final  ContentGenderDifferences? genderDifferences;
 final  List<String> _commonMistakes;
@override@JsonKey() List<String> get commonMistakes {
  if (_commonMistakes is EqualUnmodifiableListView) return _commonMistakes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_commonMistakes);
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

 final  List<String>? _relatedPrayers;
@override List<String>? get relatedPrayers {
  final value = _relatedPrayers;
  if (value == null) return null;
  if (_relatedPrayers is EqualUnmodifiableListView) return _relatedPrayers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<String>? _relatedRulings;
@override List<String>? get relatedRulings {
  final value = _relatedRulings;
  if (value == null) return null;
  if (_relatedRulings is EqualUnmodifiableListView) return _relatedRulings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey() final  String simulatorConfigId;
 final  List<ContentSpecialRule>? _specialRules;
@override List<ContentSpecialRule>? get specialRules {
  final value = _specialRules;
  if (value == null) return null;
  if (_specialRules is EqualUnmodifiableListView) return _specialRules;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey() final  ContentReviewStatus? reviewStatus;

/// Create a copy of ContentPrayerType
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ContentPrayerTypeCopyWith<_ContentPrayerType> get copyWith => __$ContentPrayerTypeCopyWithImpl<_ContentPrayerType>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ContentPrayerTypeToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ContentPrayerType&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.nameBn, nameBn) || other.nameBn == nameBn)&&(identical(other.nameAr, nameAr) || other.nameAr == nameAr)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.category, category) || other.category == category)&&(identical(other.group, group) || other.group == group)&&(identical(other.timeDescriptionBn, timeDescriptionBn) || other.timeDescriptionBn == timeDescriptionBn)&&const DeepCollectionEquality().equals(other.rakatUnits, _rakatUnits)&&(identical(other.totalRakats, totalRakats) || other.totalRakats == totalRakats)&&(identical(other.niyyat, niyyat) || other.niyyat == niyyat)&&(identical(other.fazilat, fazilat) || other.fazilat == fazilat)&&const DeepCollectionEquality().equals(other.steps, _steps)&&(identical(other.genderDifferences, genderDifferences) || other.genderDifferences == genderDifferences)&&const DeepCollectionEquality().equals(other.commonMistakes, _commonMistakes)&&const DeepCollectionEquality().equals(other.faqs, _faqs)&&const DeepCollectionEquality().equals(other.references, _references)&&const DeepCollectionEquality().equals(other.relatedPrayers, _relatedPrayers)&&const DeepCollectionEquality().equals(other.relatedRulings, _relatedRulings)&&(identical(other.simulatorConfigId, simulatorConfigId) || other.simulatorConfigId == simulatorConfigId)&&const DeepCollectionEquality().equals(other.specialRules, _specialRules)&&(identical(other.reviewStatus, reviewStatus) || other.reviewStatus == reviewStatus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hashAll([runtimeType,slug,nameBn,nameAr,nameEn,category,group,timeDescriptionBn,const DeepCollectionEquality().hash(_rakatUnits),totalRakats,niyyat,fazilat,const DeepCollectionEquality().hash(_steps),genderDifferences,const DeepCollectionEquality().hash(_commonMistakes),const DeepCollectionEquality().hash(_faqs),const DeepCollectionEquality().hash(_references),const DeepCollectionEquality().hash(_relatedPrayers),const DeepCollectionEquality().hash(_relatedRulings),simulatorConfigId,const DeepCollectionEquality().hash(_specialRules),reviewStatus]);
}

@override
String toString() {
    return 'ContentPrayerType(slug: $slug, nameBn: $nameBn, nameAr: $nameAr, nameEn: $nameEn, category: $category, group: $group, timeDescriptionBn: $timeDescriptionBn, rakatUnits: $rakatUnits, totalRakats: $totalRakats, niyyat: $niyyat, fazilat: $fazilat, steps: $steps, genderDifferences: $genderDifferences, commonMistakes: $commonMistakes, faqs: $faqs, references: $references, relatedPrayers: $relatedPrayers, relatedRulings: $relatedRulings, simulatorConfigId: $simulatorConfigId, specialRules: $specialRules, reviewStatus: $reviewStatus)';
}


}

/// @nodoc
abstract mixin class _$ContentPrayerTypeCopyWith<$Res> implements $ContentPrayerTypeCopyWith<$Res> {
  factory _$ContentPrayerTypeCopyWith(_ContentPrayerType value, $Res Function(_ContentPrayerType) _then) = __$ContentPrayerTypeCopyWithImpl;
@override @useResult
$Res call({
 String slug, String nameBn, String nameAr, String nameEn, ContentPrayerCategory category, ContentPrayerGroup group, String timeDescriptionBn, List<ContentRakatUnit> rakatUnits, int totalRakats, ContentRecitation niyyat, ContentFazilat? fazilat, List<ContentPrayerStepDetail> steps, ContentGenderDifferences? genderDifferences, List<String> commonMistakes, List<ContentPrayerFAQ> faqs, List<ContentReference> references, List<String>? relatedPrayers, List<String>? relatedRulings, String simulatorConfigId, List<ContentSpecialRule>? specialRules, ContentReviewStatus? reviewStatus
});


@override $ContentRecitationCopyWith<$Res> get niyyat;@override $ContentFazilatCopyWith<$Res>? get fazilat;@override $ContentGenderDifferencesCopyWith<$Res>? get genderDifferences;

}
/// @nodoc
class __$ContentPrayerTypeCopyWithImpl<$Res>
    implements _$ContentPrayerTypeCopyWith<$Res> {
  __$ContentPrayerTypeCopyWithImpl(this._self, this._then);

  final _ContentPrayerType _self;
  final $Res Function(_ContentPrayerType) _then;

/// Create a copy of ContentPrayerType
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? slug = null,Object? nameBn = null,Object? nameAr = null,Object? nameEn = null,Object? category = null,Object? group = null,Object? timeDescriptionBn = null,Object? rakatUnits = null,Object? totalRakats = null,Object? niyyat = null,Object? fazilat = freezed,Object? steps = null,Object? genderDifferences = freezed,Object? commonMistakes = null,Object? faqs = null,Object? references = null,Object? relatedPrayers = freezed,Object? relatedRulings = freezed,Object? simulatorConfigId = null,Object? specialRules = freezed,Object? reviewStatus = freezed,}) {
  return _then(_ContentPrayerType(
slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,nameBn: null == nameBn ? _self.nameBn : nameBn // ignore: cast_nullable_to_non_nullable
as String,nameAr: null == nameAr ? _self.nameAr : nameAr // ignore: cast_nullable_to_non_nullable
as String,nameEn: null == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as ContentPrayerCategory,group: null == group ? _self.group : group // ignore: cast_nullable_to_non_nullable
as ContentPrayerGroup,timeDescriptionBn: null == timeDescriptionBn ? _self.timeDescriptionBn : timeDescriptionBn // ignore: cast_nullable_to_non_nullable
as String,rakatUnits: null == rakatUnits ? _self._rakatUnits : rakatUnits // ignore: cast_nullable_to_non_nullable
as List<ContentRakatUnit>,totalRakats: null == totalRakats ? _self.totalRakats : totalRakats // ignore: cast_nullable_to_non_nullable
as int,niyyat: null == niyyat ? _self.niyyat : niyyat // ignore: cast_nullable_to_non_nullable
as ContentRecitation,fazilat: freezed == fazilat ? _self.fazilat : fazilat // ignore: cast_nullable_to_non_nullable
as ContentFazilat?,steps: null == steps ? _self._steps : steps // ignore: cast_nullable_to_non_nullable
as List<ContentPrayerStepDetail>,genderDifferences: freezed == genderDifferences ? _self.genderDifferences : genderDifferences // ignore: cast_nullable_to_non_nullable
as ContentGenderDifferences?,commonMistakes: null == commonMistakes ? _self._commonMistakes : commonMistakes // ignore: cast_nullable_to_non_nullable
as List<String>,faqs: null == faqs ? _self._faqs : faqs // ignore: cast_nullable_to_non_nullable
as List<ContentPrayerFAQ>,references: null == references ? _self._references : references // ignore: cast_nullable_to_non_nullable
as List<ContentReference>,relatedPrayers: freezed == relatedPrayers ? _self._relatedPrayers : relatedPrayers // ignore: cast_nullable_to_non_nullable
as List<String>?,relatedRulings: freezed == relatedRulings ? _self._relatedRulings : relatedRulings // ignore: cast_nullable_to_non_nullable
as List<String>?,simulatorConfigId: null == simulatorConfigId ? _self.simulatorConfigId : simulatorConfigId // ignore: cast_nullable_to_non_nullable
as String,specialRules: freezed == specialRules ? _self._specialRules : specialRules // ignore: cast_nullable_to_non_nullable
as List<ContentSpecialRule>?,reviewStatus: freezed == reviewStatus ? _self.reviewStatus : reviewStatus // ignore: cast_nullable_to_non_nullable
as ContentReviewStatus?,
  ));
}

/// Create a copy of ContentPrayerType
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ContentRecitationCopyWith<$Res> get niyyat {
  
  return $ContentRecitationCopyWith<$Res>(_self.niyyat, (value) {
    return _then(_self.copyWith(niyyat: value));
  });
}/// Create a copy of ContentPrayerType
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
}/// Create a copy of ContentPrayerType
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
