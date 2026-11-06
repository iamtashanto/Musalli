// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'history_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ContentHistoryEvent {

 String get year;@JsonKey(name: 'title_bn') String get titleBn;@JsonKey(name: 'title_en') String get titleEn;@JsonKey(name: 'description_bn') String get descriptionBn;@JsonKey(name: 'significance_bn') String? get significanceBn; String get slug;
/// Create a copy of ContentHistoryEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContentHistoryEventCopyWith<ContentHistoryEvent> get copyWith => _$ContentHistoryEventCopyWithImpl<ContentHistoryEvent>(this as ContentHistoryEvent, _$identity);

  /// Serializes this ContentHistoryEvent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ContentHistoryEvent;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContentHistoryEvent&&(identical(other.year, _this.year) || other.year == _this.year)&&(identical(other.titleBn, _this.titleBn) || other.titleBn == _this.titleBn)&&(identical(other.titleEn, _this.titleEn) || other.titleEn == _this.titleEn)&&(identical(other.descriptionBn, _this.descriptionBn) || other.descriptionBn == _this.descriptionBn)&&(identical(other.significanceBn, _this.significanceBn) || other.significanceBn == _this.significanceBn)&&(identical(other.slug, _this.slug) || other.slug == _this.slug));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ContentHistoryEvent;
  return Object.hash(runtimeType,_this.year,_this.titleBn,_this.titleEn,_this.descriptionBn,_this.significanceBn,_this.slug);
}

@override
String toString() {
  final _this = this as ContentHistoryEvent;
  return 'ContentHistoryEvent(year: ${_this.year}, titleBn: ${_this.titleBn}, titleEn: ${_this.titleEn}, descriptionBn: ${_this.descriptionBn}, significanceBn: ${_this.significanceBn}, slug: ${_this.slug})';
}


}

/// @nodoc
abstract mixin class $ContentHistoryEventCopyWith<$Res>  {
  factory $ContentHistoryEventCopyWith(ContentHistoryEvent value, $Res Function(ContentHistoryEvent) _then) = _$ContentHistoryEventCopyWithImpl;
@useResult
$Res call({
 String year,@JsonKey(name: 'title_bn') String titleBn,@JsonKey(name: 'title_en') String titleEn,@JsonKey(name: 'description_bn') String descriptionBn,@JsonKey(name: 'significance_bn') String? significanceBn, String slug
});




}
/// @nodoc
class _$ContentHistoryEventCopyWithImpl<$Res>
    implements $ContentHistoryEventCopyWith<$Res> {
  _$ContentHistoryEventCopyWithImpl(this._self, this._then);

  final ContentHistoryEvent _self;
  final $Res Function(ContentHistoryEvent) _then;

/// Create a copy of ContentHistoryEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? year = null,Object? titleBn = null,Object? titleEn = null,Object? descriptionBn = null,Object? significanceBn = freezed,Object? slug = null,}) {
  return _then(ContentHistoryEvent(
year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as String,titleBn: null == titleBn ? _self.titleBn : titleBn // ignore: cast_nullable_to_non_nullable
as String,titleEn: null == titleEn ? _self.titleEn : titleEn // ignore: cast_nullable_to_non_nullable
as String,descriptionBn: null == descriptionBn ? _self.descriptionBn : descriptionBn // ignore: cast_nullable_to_non_nullable
as String,significanceBn: freezed == significanceBn ? _self.significanceBn : significanceBn // ignore: cast_nullable_to_non_nullable
as String?,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ContentHistoryEvent].
extension ContentHistoryEventPatterns on ContentHistoryEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ContentHistoryEvent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ContentHistoryEvent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ContentHistoryEvent value)  $default,){
final _that = this;
switch (_that) {
case _ContentHistoryEvent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ContentHistoryEvent value)?  $default,){
final _that = this;
switch (_that) {
case _ContentHistoryEvent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String year, @JsonKey(name: 'title_bn')  String titleBn, @JsonKey(name: 'title_en')  String titleEn, @JsonKey(name: 'description_bn')  String descriptionBn, @JsonKey(name: 'significance_bn')  String? significanceBn,  String slug)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ContentHistoryEvent() when $default != null:
return $default(_that.year,_that.titleBn,_that.titleEn,_that.descriptionBn,_that.significanceBn,_that.slug);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String year, @JsonKey(name: 'title_bn')  String titleBn, @JsonKey(name: 'title_en')  String titleEn, @JsonKey(name: 'description_bn')  String descriptionBn, @JsonKey(name: 'significance_bn')  String? significanceBn,  String slug)  $default,) {final _that = this;
switch (_that) {
case _ContentHistoryEvent():
return $default(_that.year,_that.titleBn,_that.titleEn,_that.descriptionBn,_that.significanceBn,_that.slug);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String year, @JsonKey(name: 'title_bn')  String titleBn, @JsonKey(name: 'title_en')  String titleEn, @JsonKey(name: 'description_bn')  String descriptionBn, @JsonKey(name: 'significance_bn')  String? significanceBn,  String slug)?  $default,) {final _that = this;
switch (_that) {
case _ContentHistoryEvent() when $default != null:
return $default(_that.year,_that.titleBn,_that.titleEn,_that.descriptionBn,_that.significanceBn,_that.slug);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ContentHistoryEvent implements ContentHistoryEvent {
  const _ContentHistoryEvent({required this.year, @JsonKey(name: 'title_bn') required this.titleBn, @JsonKey(name: 'title_en') this.titleEn = '', @JsonKey(name: 'description_bn') required this.descriptionBn, @JsonKey(name: 'significance_bn') this.significanceBn, this.slug = ''});
  factory _ContentHistoryEvent.fromJson(Map<String, dynamic> json) => _$ContentHistoryEventFromJson(json);

@override final  String year;
@override@JsonKey(name: 'title_bn') final  String titleBn;
@override@JsonKey(name: 'title_en') final  String titleEn;
@override@JsonKey(name: 'description_bn') final  String descriptionBn;
@override@JsonKey(name: 'significance_bn') final  String? significanceBn;
@override@JsonKey() final  String slug;

/// Create a copy of ContentHistoryEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ContentHistoryEventCopyWith<_ContentHistoryEvent> get copyWith => __$ContentHistoryEventCopyWithImpl<_ContentHistoryEvent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ContentHistoryEventToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ContentHistoryEvent&&(identical(other.year, year) || other.year == year)&&(identical(other.titleBn, titleBn) || other.titleBn == titleBn)&&(identical(other.titleEn, titleEn) || other.titleEn == titleEn)&&(identical(other.descriptionBn, descriptionBn) || other.descriptionBn == descriptionBn)&&(identical(other.significanceBn, significanceBn) || other.significanceBn == significanceBn)&&(identical(other.slug, slug) || other.slug == slug));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,year,titleBn,titleEn,descriptionBn,significanceBn,slug);
}

@override
String toString() {
    return 'ContentHistoryEvent(year: $year, titleBn: $titleBn, titleEn: $titleEn, descriptionBn: $descriptionBn, significanceBn: $significanceBn, slug: $slug)';
}


}

/// @nodoc
abstract mixin class _$ContentHistoryEventCopyWith<$Res> implements $ContentHistoryEventCopyWith<$Res> {
  factory _$ContentHistoryEventCopyWith(_ContentHistoryEvent value, $Res Function(_ContentHistoryEvent) _then) = __$ContentHistoryEventCopyWithImpl;
@override @useResult
$Res call({
 String year,@JsonKey(name: 'title_bn') String titleBn,@JsonKey(name: 'title_en') String titleEn,@JsonKey(name: 'description_bn') String descriptionBn,@JsonKey(name: 'significance_bn') String? significanceBn, String slug
});




}
/// @nodoc
class __$ContentHistoryEventCopyWithImpl<$Res>
    implements _$ContentHistoryEventCopyWith<$Res> {
  __$ContentHistoryEventCopyWithImpl(this._self, this._then);

  final _ContentHistoryEvent _self;
  final $Res Function(_ContentHistoryEvent) _then;

/// Create a copy of ContentHistoryEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? year = null,Object? titleBn = null,Object? titleEn = null,Object? descriptionBn = null,Object? significanceBn = freezed,Object? slug = null,}) {
  return _then(_ContentHistoryEvent(
year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as String,titleBn: null == titleBn ? _self.titleBn : titleBn // ignore: cast_nullable_to_non_nullable
as String,titleEn: null == titleEn ? _self.titleEn : titleEn // ignore: cast_nullable_to_non_nullable
as String,descriptionBn: null == descriptionBn ? _self.descriptionBn : descriptionBn // ignore: cast_nullable_to_non_nullable
as String,significanceBn: freezed == significanceBn ? _self.significanceBn : significanceBn // ignore: cast_nullable_to_non_nullable
as String?,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ContentHistoryEra {

 String get id;@JsonKey(name: 'name_bn') String get nameBn;@JsonKey(name: 'name_en') String get nameEn; String get period; String? get color; String? get icon;@JsonKey(name: 'description_bn') String get descriptionBn; List<ContentHistoryEvent> get events;
/// Create a copy of ContentHistoryEra
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContentHistoryEraCopyWith<ContentHistoryEra> get copyWith => _$ContentHistoryEraCopyWithImpl<ContentHistoryEra>(this as ContentHistoryEra, _$identity);

  /// Serializes this ContentHistoryEra to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ContentHistoryEra;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContentHistoryEra&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.nameBn, _this.nameBn) || other.nameBn == _this.nameBn)&&(identical(other.nameEn, _this.nameEn) || other.nameEn == _this.nameEn)&&(identical(other.period, _this.period) || other.period == _this.period)&&(identical(other.color, _this.color) || other.color == _this.color)&&(identical(other.icon, _this.icon) || other.icon == _this.icon)&&(identical(other.descriptionBn, _this.descriptionBn) || other.descriptionBn == _this.descriptionBn)&&const DeepCollectionEquality().equals(other.events, _this.events));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ContentHistoryEra;
  return Object.hash(runtimeType,_this.id,_this.nameBn,_this.nameEn,_this.period,_this.color,_this.icon,_this.descriptionBn,const DeepCollectionEquality().hash(_this.events));
}

@override
String toString() {
  final _this = this as ContentHistoryEra;
  return 'ContentHistoryEra(id: ${_this.id}, nameBn: ${_this.nameBn}, nameEn: ${_this.nameEn}, period: ${_this.period}, color: ${_this.color}, icon: ${_this.icon}, descriptionBn: ${_this.descriptionBn}, events: ${_this.events})';
}


}

/// @nodoc
abstract mixin class $ContentHistoryEraCopyWith<$Res>  {
  factory $ContentHistoryEraCopyWith(ContentHistoryEra value, $Res Function(ContentHistoryEra) _then) = _$ContentHistoryEraCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'name_bn') String nameBn,@JsonKey(name: 'name_en') String nameEn, String period, String? color, String? icon,@JsonKey(name: 'description_bn') String descriptionBn, List<ContentHistoryEvent> events
});




}
/// @nodoc
class _$ContentHistoryEraCopyWithImpl<$Res>
    implements $ContentHistoryEraCopyWith<$Res> {
  _$ContentHistoryEraCopyWithImpl(this._self, this._then);

  final ContentHistoryEra _self;
  final $Res Function(ContentHistoryEra) _then;

/// Create a copy of ContentHistoryEra
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? nameBn = null,Object? nameEn = null,Object? period = null,Object? color = freezed,Object? icon = freezed,Object? descriptionBn = null,Object? events = null,}) {
  return _then(ContentHistoryEra(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,nameBn: null == nameBn ? _self.nameBn : nameBn // ignore: cast_nullable_to_non_nullable
as String,nameEn: null == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,descriptionBn: null == descriptionBn ? _self.descriptionBn : descriptionBn // ignore: cast_nullable_to_non_nullable
as String,events: null == events ? _self.events : events // ignore: cast_nullable_to_non_nullable
as List<ContentHistoryEvent>,
  ));
}

}


/// Adds pattern-matching-related methods to [ContentHistoryEra].
extension ContentHistoryEraPatterns on ContentHistoryEra {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ContentHistoryEra value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ContentHistoryEra() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ContentHistoryEra value)  $default,){
final _that = this;
switch (_that) {
case _ContentHistoryEra():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ContentHistoryEra value)?  $default,){
final _that = this;
switch (_that) {
case _ContentHistoryEra() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'name_bn')  String nameBn, @JsonKey(name: 'name_en')  String nameEn,  String period,  String? color,  String? icon, @JsonKey(name: 'description_bn')  String descriptionBn,  List<ContentHistoryEvent> events)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ContentHistoryEra() when $default != null:
return $default(_that.id,_that.nameBn,_that.nameEn,_that.period,_that.color,_that.icon,_that.descriptionBn,_that.events);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'name_bn')  String nameBn, @JsonKey(name: 'name_en')  String nameEn,  String period,  String? color,  String? icon, @JsonKey(name: 'description_bn')  String descriptionBn,  List<ContentHistoryEvent> events)  $default,) {final _that = this;
switch (_that) {
case _ContentHistoryEra():
return $default(_that.id,_that.nameBn,_that.nameEn,_that.period,_that.color,_that.icon,_that.descriptionBn,_that.events);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'name_bn')  String nameBn, @JsonKey(name: 'name_en')  String nameEn,  String period,  String? color,  String? icon, @JsonKey(name: 'description_bn')  String descriptionBn,  List<ContentHistoryEvent> events)?  $default,) {final _that = this;
switch (_that) {
case _ContentHistoryEra() when $default != null:
return $default(_that.id,_that.nameBn,_that.nameEn,_that.period,_that.color,_that.icon,_that.descriptionBn,_that.events);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ContentHistoryEra implements ContentHistoryEra {
  const _ContentHistoryEra({required this.id, @JsonKey(name: 'name_bn') required this.nameBn, @JsonKey(name: 'name_en') this.nameEn = '', required this.period, this.color, this.icon, @JsonKey(name: 'description_bn') required this.descriptionBn,  List<ContentHistoryEvent> events = const <ContentHistoryEvent>[]}): _events = events;
  factory _ContentHistoryEra.fromJson(Map<String, dynamic> json) => _$ContentHistoryEraFromJson(json);

@override final  String id;
@override@JsonKey(name: 'name_bn') final  String nameBn;
@override@JsonKey(name: 'name_en') final  String nameEn;
@override final  String period;
@override final  String? color;
@override final  String? icon;
@override@JsonKey(name: 'description_bn') final  String descriptionBn;
 final  List<ContentHistoryEvent> _events;
@override@JsonKey() List<ContentHistoryEvent> get events {
  if (_events is EqualUnmodifiableListView) return _events;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_events);
}


/// Create a copy of ContentHistoryEra
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ContentHistoryEraCopyWith<_ContentHistoryEra> get copyWith => __$ContentHistoryEraCopyWithImpl<_ContentHistoryEra>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ContentHistoryEraToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ContentHistoryEra&&(identical(other.id, id) || other.id == id)&&(identical(other.nameBn, nameBn) || other.nameBn == nameBn)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.period, period) || other.period == period)&&(identical(other.color, color) || other.color == color)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.descriptionBn, descriptionBn) || other.descriptionBn == descriptionBn)&&const DeepCollectionEquality().equals(other.events, _events));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,nameBn,nameEn,period,color,icon,descriptionBn,const DeepCollectionEquality().hash(_events));
}

@override
String toString() {
    return 'ContentHistoryEra(id: $id, nameBn: $nameBn, nameEn: $nameEn, period: $period, color: $color, icon: $icon, descriptionBn: $descriptionBn, events: $events)';
}


}

/// @nodoc
abstract mixin class _$ContentHistoryEraCopyWith<$Res> implements $ContentHistoryEraCopyWith<$Res> {
  factory _$ContentHistoryEraCopyWith(_ContentHistoryEra value, $Res Function(_ContentHistoryEra) _then) = __$ContentHistoryEraCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'name_bn') String nameBn,@JsonKey(name: 'name_en') String nameEn, String period, String? color, String? icon,@JsonKey(name: 'description_bn') String descriptionBn, List<ContentHistoryEvent> events
});




}
/// @nodoc
class __$ContentHistoryEraCopyWithImpl<$Res>
    implements _$ContentHistoryEraCopyWith<$Res> {
  __$ContentHistoryEraCopyWithImpl(this._self, this._then);

  final _ContentHistoryEra _self;
  final $Res Function(_ContentHistoryEra) _then;

/// Create a copy of ContentHistoryEra
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? nameBn = null,Object? nameEn = null,Object? period = null,Object? color = freezed,Object? icon = freezed,Object? descriptionBn = null,Object? events = null,}) {
  return _then(_ContentHistoryEra(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,nameBn: null == nameBn ? _self.nameBn : nameBn // ignore: cast_nullable_to_non_nullable
as String,nameEn: null == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,descriptionBn: null == descriptionBn ? _self.descriptionBn : descriptionBn // ignore: cast_nullable_to_non_nullable
as String,events: null == events ? _self._events : events // ignore: cast_nullable_to_non_nullable
as List<ContentHistoryEvent>,
  ));
}


}

// dart format on
