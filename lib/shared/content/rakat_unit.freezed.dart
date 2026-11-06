// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rakat_unit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ContentRakatUnit {

 String get label; int get count; ContentRulingStatus get status; ContentSalahConfig get config;
/// Create a copy of ContentRakatUnit
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContentRakatUnitCopyWith<ContentRakatUnit> get copyWith => _$ContentRakatUnitCopyWithImpl<ContentRakatUnit>(this as ContentRakatUnit, _$identity);

  /// Serializes this ContentRakatUnit to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ContentRakatUnit;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContentRakatUnit&&(identical(other.label, _this.label) || other.label == _this.label)&&(identical(other.count, _this.count) || other.count == _this.count)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.config, _this.config) || other.config == _this.config));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ContentRakatUnit;
  return Object.hash(runtimeType,_this.label,_this.count,_this.status,_this.config);
}

@override
String toString() {
  final _this = this as ContentRakatUnit;
  return 'ContentRakatUnit(label: ${_this.label}, count: ${_this.count}, status: ${_this.status}, config: ${_this.config})';
}


}

/// @nodoc
abstract mixin class $ContentRakatUnitCopyWith<$Res>  {
  factory $ContentRakatUnitCopyWith(ContentRakatUnit value, $Res Function(ContentRakatUnit) _then) = _$ContentRakatUnitCopyWithImpl;
@useResult
$Res call({
 String label, int count, ContentRulingStatus status, ContentSalahConfig config
});


$ContentSalahConfigCopyWith<$Res> get config;

}
/// @nodoc
class _$ContentRakatUnitCopyWithImpl<$Res>
    implements $ContentRakatUnitCopyWith<$Res> {
  _$ContentRakatUnitCopyWithImpl(this._self, this._then);

  final ContentRakatUnit _self;
  final $Res Function(ContentRakatUnit) _then;

/// Create a copy of ContentRakatUnit
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? label = null,Object? count = null,Object? status = null,Object? config = null,}) {
  return _then(ContentRakatUnit(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ContentRulingStatus,config: null == config ? _self.config : config // ignore: cast_nullable_to_non_nullable
as ContentSalahConfig,
  ));
}
/// Create a copy of ContentRakatUnit
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ContentSalahConfigCopyWith<$Res> get config {
  
  return $ContentSalahConfigCopyWith<$Res>(_self.config, (value) {
    return _then(_self.copyWith(config: value));
  });
}
}


/// Adds pattern-matching-related methods to [ContentRakatUnit].
extension ContentRakatUnitPatterns on ContentRakatUnit {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ContentRakatUnit value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ContentRakatUnit() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ContentRakatUnit value)  $default,){
final _that = this;
switch (_that) {
case _ContentRakatUnit():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ContentRakatUnit value)?  $default,){
final _that = this;
switch (_that) {
case _ContentRakatUnit() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String label,  int count,  ContentRulingStatus status,  ContentSalahConfig config)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ContentRakatUnit() when $default != null:
return $default(_that.label,_that.count,_that.status,_that.config);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String label,  int count,  ContentRulingStatus status,  ContentSalahConfig config)  $default,) {final _that = this;
switch (_that) {
case _ContentRakatUnit():
return $default(_that.label,_that.count,_that.status,_that.config);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String label,  int count,  ContentRulingStatus status,  ContentSalahConfig config)?  $default,) {final _that = this;
switch (_that) {
case _ContentRakatUnit() when $default != null:
return $default(_that.label,_that.count,_that.status,_that.config);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ContentRakatUnit implements ContentRakatUnit {
  const _ContentRakatUnit({required this.label, required this.count, required this.status, required this.config});
  factory _ContentRakatUnit.fromJson(Map<String, dynamic> json) => _$ContentRakatUnitFromJson(json);

@override final  String label;
@override final  int count;
@override final  ContentRulingStatus status;
@override final  ContentSalahConfig config;

/// Create a copy of ContentRakatUnit
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ContentRakatUnitCopyWith<_ContentRakatUnit> get copyWith => __$ContentRakatUnitCopyWithImpl<_ContentRakatUnit>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ContentRakatUnitToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ContentRakatUnit&&(identical(other.label, label) || other.label == label)&&(identical(other.count, count) || other.count == count)&&(identical(other.status, status) || other.status == status)&&(identical(other.config, config) || other.config == config));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,label,count,status,config);
}

@override
String toString() {
    return 'ContentRakatUnit(label: $label, count: $count, status: $status, config: $config)';
}


}

/// @nodoc
abstract mixin class _$ContentRakatUnitCopyWith<$Res> implements $ContentRakatUnitCopyWith<$Res> {
  factory _$ContentRakatUnitCopyWith(_ContentRakatUnit value, $Res Function(_ContentRakatUnit) _then) = __$ContentRakatUnitCopyWithImpl;
@override @useResult
$Res call({
 String label, int count, ContentRulingStatus status, ContentSalahConfig config
});


@override $ContentSalahConfigCopyWith<$Res> get config;

}
/// @nodoc
class __$ContentRakatUnitCopyWithImpl<$Res>
    implements _$ContentRakatUnitCopyWith<$Res> {
  __$ContentRakatUnitCopyWithImpl(this._self, this._then);

  final _ContentRakatUnit _self;
  final $Res Function(_ContentRakatUnit) _then;

/// Create a copy of ContentRakatUnit
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? label = null,Object? count = null,Object? status = null,Object? config = null,}) {
  return _then(_ContentRakatUnit(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ContentRulingStatus,config: null == config ? _self.config : config // ignore: cast_nullable_to_non_nullable
as ContentSalahConfig,
  ));
}

/// Create a copy of ContentRakatUnit
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ContentSalahConfigCopyWith<$Res> get config {
  
  return $ContentSalahConfigCopyWith<$Res>(_self.config, (value) {
    return _then(_self.copyWith(config: value));
  });
}
}

// dart format on
