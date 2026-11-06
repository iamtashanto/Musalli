// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'salah_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$QunutConfig {

 bool get enabled; int get rakat; String get position;
/// Create a copy of QunutConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QunutConfigCopyWith<QunutConfig> get copyWith => _$QunutConfigCopyWithImpl<QunutConfig>(this as QunutConfig, _$identity);

  /// Serializes this QunutConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as QunutConfig;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QunutConfig&&(identical(other.enabled, _this.enabled) || other.enabled == _this.enabled)&&(identical(other.rakat, _this.rakat) || other.rakat == _this.rakat)&&(identical(other.position, _this.position) || other.position == _this.position));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as QunutConfig;
  return Object.hash(runtimeType,_this.enabled,_this.rakat,_this.position);
}

@override
String toString() {
  final _this = this as QunutConfig;
  return 'QunutConfig(enabled: ${_this.enabled}, rakat: ${_this.rakat}, position: ${_this.position})';
}


}

/// @nodoc
abstract mixin class $QunutConfigCopyWith<$Res>  {
  factory $QunutConfigCopyWith(QunutConfig value, $Res Function(QunutConfig) _then) = _$QunutConfigCopyWithImpl;
@useResult
$Res call({
 bool enabled, int rakat, String position
});




}
/// @nodoc
class _$QunutConfigCopyWithImpl<$Res>
    implements $QunutConfigCopyWith<$Res> {
  _$QunutConfigCopyWithImpl(this._self, this._then);

  final QunutConfig _self;
  final $Res Function(QunutConfig) _then;

/// Create a copy of QunutConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? enabled = null,Object? rakat = null,Object? position = null,}) {
  return _then(QunutConfig(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,rakat: null == rakat ? _self.rakat : rakat // ignore: cast_nullable_to_non_nullable
as int,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [QunutConfig].
extension QunutConfigPatterns on QunutConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QunutConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QunutConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QunutConfig value)  $default,){
final _that = this;
switch (_that) {
case _QunutConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QunutConfig value)?  $default,){
final _that = this;
switch (_that) {
case _QunutConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool enabled,  int rakat,  String position)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QunutConfig() when $default != null:
return $default(_that.enabled,_that.rakat,_that.position);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool enabled,  int rakat,  String position)  $default,) {final _that = this;
switch (_that) {
case _QunutConfig():
return $default(_that.enabled,_that.rakat,_that.position);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool enabled,  int rakat,  String position)?  $default,) {final _that = this;
switch (_that) {
case _QunutConfig() when $default != null:
return $default(_that.enabled,_that.rakat,_that.position);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QunutConfig implements QunutConfig {
  const _QunutConfig({required this.enabled, required this.rakat, this.position = 'before-ruku'});
  factory _QunutConfig.fromJson(Map<String, dynamic> json) => _$QunutConfigFromJson(json);

@override final  bool enabled;
@override final  int rakat;
@override@JsonKey() final  String position;

/// Create a copy of QunutConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QunutConfigCopyWith<_QunutConfig> get copyWith => __$QunutConfigCopyWithImpl<_QunutConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QunutConfigToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _QunutConfig&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.rakat, rakat) || other.rakat == rakat)&&(identical(other.position, position) || other.position == position));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,enabled,rakat,position);
}

@override
String toString() {
    return 'QunutConfig(enabled: $enabled, rakat: $rakat, position: $position)';
}


}

/// @nodoc
abstract mixin class _$QunutConfigCopyWith<$Res> implements $QunutConfigCopyWith<$Res> {
  factory _$QunutConfigCopyWith(_QunutConfig value, $Res Function(_QunutConfig) _then) = __$QunutConfigCopyWithImpl;
@override @useResult
$Res call({
 bool enabled, int rakat, String position
});




}
/// @nodoc
class __$QunutConfigCopyWithImpl<$Res>
    implements _$QunutConfigCopyWith<$Res> {
  __$QunutConfigCopyWithImpl(this._self, this._then);

  final _QunutConfig _self;
  final $Res Function(_QunutConfig) _then;

/// Create a copy of QunutConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? enabled = null,Object? rakat = null,Object? position = null,}) {
  return _then(_QunutConfig(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,rakat: null == rakat ? _self.rakat : rakat // ignore: cast_nullable_to_non_nullable
as int,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ExtraTakbir {

 int get count; String get position; int get rakat;
/// Create a copy of ExtraTakbir
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExtraTakbirCopyWith<ExtraTakbir> get copyWith => _$ExtraTakbirCopyWithImpl<ExtraTakbir>(this as ExtraTakbir, _$identity);

  /// Serializes this ExtraTakbir to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ExtraTakbir;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExtraTakbir&&(identical(other.count, _this.count) || other.count == _this.count)&&(identical(other.position, _this.position) || other.position == _this.position)&&(identical(other.rakat, _this.rakat) || other.rakat == _this.rakat));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ExtraTakbir;
  return Object.hash(runtimeType,_this.count,_this.position,_this.rakat);
}

@override
String toString() {
  final _this = this as ExtraTakbir;
  return 'ExtraTakbir(count: ${_this.count}, position: ${_this.position}, rakat: ${_this.rakat})';
}


}

/// @nodoc
abstract mixin class $ExtraTakbirCopyWith<$Res>  {
  factory $ExtraTakbirCopyWith(ExtraTakbir value, $Res Function(ExtraTakbir) _then) = _$ExtraTakbirCopyWithImpl;
@useResult
$Res call({
 int count, String position, int rakat
});




}
/// @nodoc
class _$ExtraTakbirCopyWithImpl<$Res>
    implements $ExtraTakbirCopyWith<$Res> {
  _$ExtraTakbirCopyWithImpl(this._self, this._then);

  final ExtraTakbir _self;
  final $Res Function(ExtraTakbir) _then;

/// Create a copy of ExtraTakbir
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? count = null,Object? position = null,Object? rakat = null,}) {
  return _then(ExtraTakbir(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as String,rakat: null == rakat ? _self.rakat : rakat // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ExtraTakbir].
extension ExtraTakbirPatterns on ExtraTakbir {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExtraTakbir value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExtraTakbir() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExtraTakbir value)  $default,){
final _that = this;
switch (_that) {
case _ExtraTakbir():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExtraTakbir value)?  $default,){
final _that = this;
switch (_that) {
case _ExtraTakbir() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int count,  String position,  int rakat)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExtraTakbir() when $default != null:
return $default(_that.count,_that.position,_that.rakat);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int count,  String position,  int rakat)  $default,) {final _that = this;
switch (_that) {
case _ExtraTakbir():
return $default(_that.count,_that.position,_that.rakat);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int count,  String position,  int rakat)?  $default,) {final _that = this;
switch (_that) {
case _ExtraTakbir() when $default != null:
return $default(_that.count,_that.position,_that.rakat);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExtraTakbir implements ExtraTakbir {
  const _ExtraTakbir({required this.count, required this.position, required this.rakat});
  factory _ExtraTakbir.fromJson(Map<String, dynamic> json) => _$ExtraTakbirFromJson(json);

@override final  int count;
@override final  String position;
@override final  int rakat;

/// Create a copy of ExtraTakbir
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExtraTakbirCopyWith<_ExtraTakbir> get copyWith => __$ExtraTakbirCopyWithImpl<_ExtraTakbir>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExtraTakbirToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExtraTakbir&&(identical(other.count, count) || other.count == count)&&(identical(other.position, position) || other.position == position)&&(identical(other.rakat, rakat) || other.rakat == rakat));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,count,position,rakat);
}

@override
String toString() {
    return 'ExtraTakbir(count: $count, position: $position, rakat: $rakat)';
}


}

/// @nodoc
abstract mixin class _$ExtraTakbirCopyWith<$Res> implements $ExtraTakbirCopyWith<$Res> {
  factory _$ExtraTakbirCopyWith(_ExtraTakbir value, $Res Function(_ExtraTakbir) _then) = __$ExtraTakbirCopyWithImpl;
@override @useResult
$Res call({
 int count, String position, int rakat
});




}
/// @nodoc
class __$ExtraTakbirCopyWithImpl<$Res>
    implements _$ExtraTakbirCopyWith<$Res> {
  __$ExtraTakbirCopyWithImpl(this._self, this._then);

  final _ExtraTakbir _self;
  final $Res Function(_ExtraTakbir) _then;

/// Create a copy of ExtraTakbir
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? count = null,Object? position = null,Object? rakat = null,}) {
  return _then(_ExtraTakbir(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as String,rakat: null == rakat ? _self.rakat : rakat // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$ContentTasbihDistribution {

 String get position; int get count; String get labelBn;
/// Create a copy of ContentTasbihDistribution
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContentTasbihDistributionCopyWith<ContentTasbihDistribution> get copyWith => _$ContentTasbihDistributionCopyWithImpl<ContentTasbihDistribution>(this as ContentTasbihDistribution, _$identity);

  /// Serializes this ContentTasbihDistribution to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ContentTasbihDistribution;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContentTasbihDistribution&&(identical(other.position, _this.position) || other.position == _this.position)&&(identical(other.count, _this.count) || other.count == _this.count)&&(identical(other.labelBn, _this.labelBn) || other.labelBn == _this.labelBn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ContentTasbihDistribution;
  return Object.hash(runtimeType,_this.position,_this.count,_this.labelBn);
}

@override
String toString() {
  final _this = this as ContentTasbihDistribution;
  return 'ContentTasbihDistribution(position: ${_this.position}, count: ${_this.count}, labelBn: ${_this.labelBn})';
}


}

/// @nodoc
abstract mixin class $ContentTasbihDistributionCopyWith<$Res>  {
  factory $ContentTasbihDistributionCopyWith(ContentTasbihDistribution value, $Res Function(ContentTasbihDistribution) _then) = _$ContentTasbihDistributionCopyWithImpl;
@useResult
$Res call({
 String position, int count, String labelBn
});




}
/// @nodoc
class _$ContentTasbihDistributionCopyWithImpl<$Res>
    implements $ContentTasbihDistributionCopyWith<$Res> {
  _$ContentTasbihDistributionCopyWithImpl(this._self, this._then);

  final ContentTasbihDistribution _self;
  final $Res Function(ContentTasbihDistribution) _then;

/// Create a copy of ContentTasbihDistribution
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? position = null,Object? count = null,Object? labelBn = null,}) {
  return _then(ContentTasbihDistribution(
position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,labelBn: null == labelBn ? _self.labelBn : labelBn // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ContentTasbihDistribution].
extension ContentTasbihDistributionPatterns on ContentTasbihDistribution {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ContentTasbihDistribution value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ContentTasbihDistribution() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ContentTasbihDistribution value)  $default,){
final _that = this;
switch (_that) {
case _ContentTasbihDistribution():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ContentTasbihDistribution value)?  $default,){
final _that = this;
switch (_that) {
case _ContentTasbihDistribution() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String position,  int count,  String labelBn)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ContentTasbihDistribution() when $default != null:
return $default(_that.position,_that.count,_that.labelBn);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String position,  int count,  String labelBn)  $default,) {final _that = this;
switch (_that) {
case _ContentTasbihDistribution():
return $default(_that.position,_that.count,_that.labelBn);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String position,  int count,  String labelBn)?  $default,) {final _that = this;
switch (_that) {
case _ContentTasbihDistribution() when $default != null:
return $default(_that.position,_that.count,_that.labelBn);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ContentTasbihDistribution implements ContentTasbihDistribution {
  const _ContentTasbihDistribution({required this.position, required this.count, required this.labelBn});
  factory _ContentTasbihDistribution.fromJson(Map<String, dynamic> json) => _$ContentTasbihDistributionFromJson(json);

@override final  String position;
@override final  int count;
@override final  String labelBn;

/// Create a copy of ContentTasbihDistribution
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ContentTasbihDistributionCopyWith<_ContentTasbihDistribution> get copyWith => __$ContentTasbihDistributionCopyWithImpl<_ContentTasbihDistribution>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ContentTasbihDistributionToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ContentTasbihDistribution&&(identical(other.position, position) || other.position == position)&&(identical(other.count, count) || other.count == count)&&(identical(other.labelBn, labelBn) || other.labelBn == labelBn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,position,count,labelBn);
}

@override
String toString() {
    return 'ContentTasbihDistribution(position: $position, count: $count, labelBn: $labelBn)';
}


}

/// @nodoc
abstract mixin class _$ContentTasbihDistributionCopyWith<$Res> implements $ContentTasbihDistributionCopyWith<$Res> {
  factory _$ContentTasbihDistributionCopyWith(_ContentTasbihDistribution value, $Res Function(_ContentTasbihDistribution) _then) = __$ContentTasbihDistributionCopyWithImpl;
@override @useResult
$Res call({
 String position, int count, String labelBn
});




}
/// @nodoc
class __$ContentTasbihDistributionCopyWithImpl<$Res>
    implements _$ContentTasbihDistributionCopyWith<$Res> {
  __$ContentTasbihDistributionCopyWithImpl(this._self, this._then);

  final _ContentTasbihDistribution _self;
  final $Res Function(_ContentTasbihDistribution) _then;

/// Create a copy of ContentTasbihDistribution
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? position = null,Object? count = null,Object? labelBn = null,}) {
  return _then(_ContentTasbihDistribution(
position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,labelBn: null == labelBn ? _self.labelBn : labelBn // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ContentSalahConfig {

 int get rakats; List<int>? get rakatRange; List<int> get qiratRakats; int? get firstSittingAfter;@JsonKey(fromJson: _qunutFromJson, toJson: _qunutToJson) QunutConfig? get hasQunut; List<ExtraTakbir>? get extraTakbirs; List<ContentTasbihDistribution>? get tasbihDistribution; String? get tasbihFormula; bool get isJanaza; List<int> get jahr; int get sajdaCount; bool get endsWithSalam;
/// Create a copy of ContentSalahConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContentSalahConfigCopyWith<ContentSalahConfig> get copyWith => _$ContentSalahConfigCopyWithImpl<ContentSalahConfig>(this as ContentSalahConfig, _$identity);

  /// Serializes this ContentSalahConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ContentSalahConfig;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContentSalahConfig&&(identical(other.rakats, _this.rakats) || other.rakats == _this.rakats)&&const DeepCollectionEquality().equals(other.rakatRange, _this.rakatRange)&&const DeepCollectionEquality().equals(other.qiratRakats, _this.qiratRakats)&&(identical(other.firstSittingAfter, _this.firstSittingAfter) || other.firstSittingAfter == _this.firstSittingAfter)&&(identical(other.hasQunut, _this.hasQunut) || other.hasQunut == _this.hasQunut)&&const DeepCollectionEquality().equals(other.extraTakbirs, _this.extraTakbirs)&&const DeepCollectionEquality().equals(other.tasbihDistribution, _this.tasbihDistribution)&&(identical(other.tasbihFormula, _this.tasbihFormula) || other.tasbihFormula == _this.tasbihFormula)&&(identical(other.isJanaza, _this.isJanaza) || other.isJanaza == _this.isJanaza)&&const DeepCollectionEquality().equals(other.jahr, _this.jahr)&&(identical(other.sajdaCount, _this.sajdaCount) || other.sajdaCount == _this.sajdaCount)&&(identical(other.endsWithSalam, _this.endsWithSalam) || other.endsWithSalam == _this.endsWithSalam));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ContentSalahConfig;
  return Object.hash(runtimeType,_this.rakats,const DeepCollectionEquality().hash(_this.rakatRange),const DeepCollectionEquality().hash(_this.qiratRakats),_this.firstSittingAfter,_this.hasQunut,const DeepCollectionEquality().hash(_this.extraTakbirs),const DeepCollectionEquality().hash(_this.tasbihDistribution),_this.tasbihFormula,_this.isJanaza,const DeepCollectionEquality().hash(_this.jahr),_this.sajdaCount,_this.endsWithSalam);
}

@override
String toString() {
  final _this = this as ContentSalahConfig;
  return 'ContentSalahConfig(rakats: ${_this.rakats}, rakatRange: ${_this.rakatRange}, qiratRakats: ${_this.qiratRakats}, firstSittingAfter: ${_this.firstSittingAfter}, hasQunut: ${_this.hasQunut}, extraTakbirs: ${_this.extraTakbirs}, tasbihDistribution: ${_this.tasbihDistribution}, tasbihFormula: ${_this.tasbihFormula}, isJanaza: ${_this.isJanaza}, jahr: ${_this.jahr}, sajdaCount: ${_this.sajdaCount}, endsWithSalam: ${_this.endsWithSalam})';
}


}

/// @nodoc
abstract mixin class $ContentSalahConfigCopyWith<$Res>  {
  factory $ContentSalahConfigCopyWith(ContentSalahConfig value, $Res Function(ContentSalahConfig) _then) = _$ContentSalahConfigCopyWithImpl;
@useResult
$Res call({
 int rakats, List<int>? rakatRange, List<int> qiratRakats, int? firstSittingAfter,@JsonKey(fromJson: _qunutFromJson, toJson: _qunutToJson) QunutConfig? hasQunut, List<ExtraTakbir>? extraTakbirs, List<ContentTasbihDistribution>? tasbihDistribution, String? tasbihFormula, bool isJanaza, List<int> jahr, int sajdaCount, bool endsWithSalam
});


$QunutConfigCopyWith<$Res>? get hasQunut;

}
/// @nodoc
class _$ContentSalahConfigCopyWithImpl<$Res>
    implements $ContentSalahConfigCopyWith<$Res> {
  _$ContentSalahConfigCopyWithImpl(this._self, this._then);

  final ContentSalahConfig _self;
  final $Res Function(ContentSalahConfig) _then;

/// Create a copy of ContentSalahConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? rakats = null,Object? rakatRange = freezed,Object? qiratRakats = null,Object? firstSittingAfter = freezed,Object? hasQunut = freezed,Object? extraTakbirs = freezed,Object? tasbihDistribution = freezed,Object? tasbihFormula = freezed,Object? isJanaza = null,Object? jahr = null,Object? sajdaCount = null,Object? endsWithSalam = null,}) {
  return _then(ContentSalahConfig(
rakats: null == rakats ? _self.rakats : rakats // ignore: cast_nullable_to_non_nullable
as int,rakatRange: freezed == rakatRange ? _self.rakatRange : rakatRange // ignore: cast_nullable_to_non_nullable
as List<int>?,qiratRakats: null == qiratRakats ? _self.qiratRakats : qiratRakats // ignore: cast_nullable_to_non_nullable
as List<int>,firstSittingAfter: freezed == firstSittingAfter ? _self.firstSittingAfter : firstSittingAfter // ignore: cast_nullable_to_non_nullable
as int?,hasQunut: freezed == hasQunut ? _self.hasQunut : hasQunut // ignore: cast_nullable_to_non_nullable
as QunutConfig?,extraTakbirs: freezed == extraTakbirs ? _self.extraTakbirs : extraTakbirs // ignore: cast_nullable_to_non_nullable
as List<ExtraTakbir>?,tasbihDistribution: freezed == tasbihDistribution ? _self.tasbihDistribution : tasbihDistribution // ignore: cast_nullable_to_non_nullable
as List<ContentTasbihDistribution>?,tasbihFormula: freezed == tasbihFormula ? _self.tasbihFormula : tasbihFormula // ignore: cast_nullable_to_non_nullable
as String?,isJanaza: null == isJanaza ? _self.isJanaza : isJanaza // ignore: cast_nullable_to_non_nullable
as bool,jahr: null == jahr ? _self.jahr : jahr // ignore: cast_nullable_to_non_nullable
as List<int>,sajdaCount: null == sajdaCount ? _self.sajdaCount : sajdaCount // ignore: cast_nullable_to_non_nullable
as int,endsWithSalam: null == endsWithSalam ? _self.endsWithSalam : endsWithSalam // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of ContentSalahConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QunutConfigCopyWith<$Res>? get hasQunut {
    if (_self.hasQunut == null) {
    return null;
  }

  return $QunutConfigCopyWith<$Res>(_self.hasQunut!, (value) {
    return _then(_self.copyWith(hasQunut: value));
  });
}
}


/// Adds pattern-matching-related methods to [ContentSalahConfig].
extension ContentSalahConfigPatterns on ContentSalahConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ContentSalahConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ContentSalahConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ContentSalahConfig value)  $default,){
final _that = this;
switch (_that) {
case _ContentSalahConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ContentSalahConfig value)?  $default,){
final _that = this;
switch (_that) {
case _ContentSalahConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int rakats,  List<int>? rakatRange,  List<int> qiratRakats,  int? firstSittingAfter, @JsonKey(fromJson: _qunutFromJson, toJson: _qunutToJson)  QunutConfig? hasQunut,  List<ExtraTakbir>? extraTakbirs,  List<ContentTasbihDistribution>? tasbihDistribution,  String? tasbihFormula,  bool isJanaza,  List<int> jahr,  int sajdaCount,  bool endsWithSalam)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ContentSalahConfig() when $default != null:
return $default(_that.rakats,_that.rakatRange,_that.qiratRakats,_that.firstSittingAfter,_that.hasQunut,_that.extraTakbirs,_that.tasbihDistribution,_that.tasbihFormula,_that.isJanaza,_that.jahr,_that.sajdaCount,_that.endsWithSalam);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int rakats,  List<int>? rakatRange,  List<int> qiratRakats,  int? firstSittingAfter, @JsonKey(fromJson: _qunutFromJson, toJson: _qunutToJson)  QunutConfig? hasQunut,  List<ExtraTakbir>? extraTakbirs,  List<ContentTasbihDistribution>? tasbihDistribution,  String? tasbihFormula,  bool isJanaza,  List<int> jahr,  int sajdaCount,  bool endsWithSalam)  $default,) {final _that = this;
switch (_that) {
case _ContentSalahConfig():
return $default(_that.rakats,_that.rakatRange,_that.qiratRakats,_that.firstSittingAfter,_that.hasQunut,_that.extraTakbirs,_that.tasbihDistribution,_that.tasbihFormula,_that.isJanaza,_that.jahr,_that.sajdaCount,_that.endsWithSalam);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int rakats,  List<int>? rakatRange,  List<int> qiratRakats,  int? firstSittingAfter, @JsonKey(fromJson: _qunutFromJson, toJson: _qunutToJson)  QunutConfig? hasQunut,  List<ExtraTakbir>? extraTakbirs,  List<ContentTasbihDistribution>? tasbihDistribution,  String? tasbihFormula,  bool isJanaza,  List<int> jahr,  int sajdaCount,  bool endsWithSalam)?  $default,) {final _that = this;
switch (_that) {
case _ContentSalahConfig() when $default != null:
return $default(_that.rakats,_that.rakatRange,_that.qiratRakats,_that.firstSittingAfter,_that.hasQunut,_that.extraTakbirs,_that.tasbihDistribution,_that.tasbihFormula,_that.isJanaza,_that.jahr,_that.sajdaCount,_that.endsWithSalam);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ContentSalahConfig implements ContentSalahConfig {
  const _ContentSalahConfig({required this.rakats,  List<int>? rakatRange,  List<int> qiratRakats = const <int>[], this.firstSittingAfter, @JsonKey(fromJson: _qunutFromJson, toJson: _qunutToJson) this.hasQunut,  List<ExtraTakbir>? extraTakbirs,  List<ContentTasbihDistribution>? tasbihDistribution, this.tasbihFormula, this.isJanaza = false,  List<int> jahr = const <int>[], this.sajdaCount = 2, this.endsWithSalam = true}): _rakatRange = rakatRange,_qiratRakats = qiratRakats,_extraTakbirs = extraTakbirs,_tasbihDistribution = tasbihDistribution,_jahr = jahr;
  factory _ContentSalahConfig.fromJson(Map<String, dynamic> json) => _$ContentSalahConfigFromJson(json);

@override final  int rakats;
 final  List<int>? _rakatRange;
@override List<int>? get rakatRange {
  final value = _rakatRange;
  if (value == null) return null;
  if (_rakatRange is EqualUnmodifiableListView) return _rakatRange;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<int> _qiratRakats;
@override@JsonKey() List<int> get qiratRakats {
  if (_qiratRakats is EqualUnmodifiableListView) return _qiratRakats;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_qiratRakats);
}

@override final  int? firstSittingAfter;
@override@JsonKey(fromJson: _qunutFromJson, toJson: _qunutToJson) final  QunutConfig? hasQunut;
 final  List<ExtraTakbir>? _extraTakbirs;
@override List<ExtraTakbir>? get extraTakbirs {
  final value = _extraTakbirs;
  if (value == null) return null;
  if (_extraTakbirs is EqualUnmodifiableListView) return _extraTakbirs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<ContentTasbihDistribution>? _tasbihDistribution;
@override List<ContentTasbihDistribution>? get tasbihDistribution {
  final value = _tasbihDistribution;
  if (value == null) return null;
  if (_tasbihDistribution is EqualUnmodifiableListView) return _tasbihDistribution;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  String? tasbihFormula;
@override@JsonKey() final  bool isJanaza;
 final  List<int> _jahr;
@override@JsonKey() List<int> get jahr {
  if (_jahr is EqualUnmodifiableListView) return _jahr;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_jahr);
}

@override@JsonKey() final  int sajdaCount;
@override@JsonKey() final  bool endsWithSalam;

/// Create a copy of ContentSalahConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ContentSalahConfigCopyWith<_ContentSalahConfig> get copyWith => __$ContentSalahConfigCopyWithImpl<_ContentSalahConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ContentSalahConfigToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ContentSalahConfig&&(identical(other.rakats, rakats) || other.rakats == rakats)&&const DeepCollectionEquality().equals(other.rakatRange, _rakatRange)&&const DeepCollectionEquality().equals(other.qiratRakats, _qiratRakats)&&(identical(other.firstSittingAfter, firstSittingAfter) || other.firstSittingAfter == firstSittingAfter)&&(identical(other.hasQunut, hasQunut) || other.hasQunut == hasQunut)&&const DeepCollectionEquality().equals(other.extraTakbirs, _extraTakbirs)&&const DeepCollectionEquality().equals(other.tasbihDistribution, _tasbihDistribution)&&(identical(other.tasbihFormula, tasbihFormula) || other.tasbihFormula == tasbihFormula)&&(identical(other.isJanaza, isJanaza) || other.isJanaza == isJanaza)&&const DeepCollectionEquality().equals(other.jahr, _jahr)&&(identical(other.sajdaCount, sajdaCount) || other.sajdaCount == sajdaCount)&&(identical(other.endsWithSalam, endsWithSalam) || other.endsWithSalam == endsWithSalam));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,rakats,const DeepCollectionEquality().hash(_rakatRange),const DeepCollectionEquality().hash(_qiratRakats),firstSittingAfter,hasQunut,const DeepCollectionEquality().hash(_extraTakbirs),const DeepCollectionEquality().hash(_tasbihDistribution),tasbihFormula,isJanaza,const DeepCollectionEquality().hash(_jahr),sajdaCount,endsWithSalam);
}

@override
String toString() {
    return 'ContentSalahConfig(rakats: $rakats, rakatRange: $rakatRange, qiratRakats: $qiratRakats, firstSittingAfter: $firstSittingAfter, hasQunut: $hasQunut, extraTakbirs: $extraTakbirs, tasbihDistribution: $tasbihDistribution, tasbihFormula: $tasbihFormula, isJanaza: $isJanaza, jahr: $jahr, sajdaCount: $sajdaCount, endsWithSalam: $endsWithSalam)';
}


}

/// @nodoc
abstract mixin class _$ContentSalahConfigCopyWith<$Res> implements $ContentSalahConfigCopyWith<$Res> {
  factory _$ContentSalahConfigCopyWith(_ContentSalahConfig value, $Res Function(_ContentSalahConfig) _then) = __$ContentSalahConfigCopyWithImpl;
@override @useResult
$Res call({
 int rakats, List<int>? rakatRange, List<int> qiratRakats, int? firstSittingAfter,@JsonKey(fromJson: _qunutFromJson, toJson: _qunutToJson) QunutConfig? hasQunut, List<ExtraTakbir>? extraTakbirs, List<ContentTasbihDistribution>? tasbihDistribution, String? tasbihFormula, bool isJanaza, List<int> jahr, int sajdaCount, bool endsWithSalam
});


@override $QunutConfigCopyWith<$Res>? get hasQunut;

}
/// @nodoc
class __$ContentSalahConfigCopyWithImpl<$Res>
    implements _$ContentSalahConfigCopyWith<$Res> {
  __$ContentSalahConfigCopyWithImpl(this._self, this._then);

  final _ContentSalahConfig _self;
  final $Res Function(_ContentSalahConfig) _then;

/// Create a copy of ContentSalahConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? rakats = null,Object? rakatRange = freezed,Object? qiratRakats = null,Object? firstSittingAfter = freezed,Object? hasQunut = freezed,Object? extraTakbirs = freezed,Object? tasbihDistribution = freezed,Object? tasbihFormula = freezed,Object? isJanaza = null,Object? jahr = null,Object? sajdaCount = null,Object? endsWithSalam = null,}) {
  return _then(_ContentSalahConfig(
rakats: null == rakats ? _self.rakats : rakats // ignore: cast_nullable_to_non_nullable
as int,rakatRange: freezed == rakatRange ? _self._rakatRange : rakatRange // ignore: cast_nullable_to_non_nullable
as List<int>?,qiratRakats: null == qiratRakats ? _self._qiratRakats : qiratRakats // ignore: cast_nullable_to_non_nullable
as List<int>,firstSittingAfter: freezed == firstSittingAfter ? _self.firstSittingAfter : firstSittingAfter // ignore: cast_nullable_to_non_nullable
as int?,hasQunut: freezed == hasQunut ? _self.hasQunut : hasQunut // ignore: cast_nullable_to_non_nullable
as QunutConfig?,extraTakbirs: freezed == extraTakbirs ? _self._extraTakbirs : extraTakbirs // ignore: cast_nullable_to_non_nullable
as List<ExtraTakbir>?,tasbihDistribution: freezed == tasbihDistribution ? _self._tasbihDistribution : tasbihDistribution // ignore: cast_nullable_to_non_nullable
as List<ContentTasbihDistribution>?,tasbihFormula: freezed == tasbihFormula ? _self.tasbihFormula : tasbihFormula // ignore: cast_nullable_to_non_nullable
as String?,isJanaza: null == isJanaza ? _self.isJanaza : isJanaza // ignore: cast_nullable_to_non_nullable
as bool,jahr: null == jahr ? _self._jahr : jahr // ignore: cast_nullable_to_non_nullable
as List<int>,sajdaCount: null == sajdaCount ? _self.sajdaCount : sajdaCount // ignore: cast_nullable_to_non_nullable
as int,endsWithSalam: null == endsWithSalam ? _self.endsWithSalam : endsWithSalam // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of ContentSalahConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QunutConfigCopyWith<$Res>? get hasQunut {
    if (_self.hasQunut == null) {
    return null;
  }

  return $QunutConfigCopyWith<$Res>(_self.hasQunut!, (value) {
    return _then(_self.copyWith(hasQunut: value));
  });
}
}

// dart format on
