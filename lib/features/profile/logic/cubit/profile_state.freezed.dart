// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ProfileState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialProfile,
    required TResult Function() loadingGetProfile,
    required TResult Function(GetProfileResponseModel data) successGetProfile,
    required TResult Function(ApiErrorModel apiErrorModel) errorGetProfile,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initialProfile,
    TResult? Function()? loadingGetProfile,
    TResult? Function(GetProfileResponseModel data)? successGetProfile,
    TResult? Function(ApiErrorModel apiErrorModel)? errorGetProfile,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialProfile,
    TResult Function()? loadingGetProfile,
    TResult Function(GetProfileResponseModel data)? successGetProfile,
    TResult Function(ApiErrorModel apiErrorModel)? errorGetProfile,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitialProfile value) initialProfile,
    required TResult Function(LoadingGetProfile value) loadingGetProfile,
    required TResult Function(SuccessGetProfile value) successGetProfile,
    required TResult Function(ErrorGetProfile value) errorGetProfile,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitialProfile value)? initialProfile,
    TResult? Function(LoadingGetProfile value)? loadingGetProfile,
    TResult? Function(SuccessGetProfile value)? successGetProfile,
    TResult? Function(ErrorGetProfile value)? errorGetProfile,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialProfile value)? initialProfile,
    TResult Function(LoadingGetProfile value)? loadingGetProfile,
    TResult Function(SuccessGetProfile value)? successGetProfile,
    TResult Function(ErrorGetProfile value)? errorGetProfile,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileStateCopyWith<$Res> {
  factory $ProfileStateCopyWith(
          ProfileState value, $Res Function(ProfileState) then) =
      _$ProfileStateCopyWithImpl<$Res, ProfileState>;
}

/// @nodoc
class _$ProfileStateCopyWithImpl<$Res, $Val extends ProfileState>
    implements $ProfileStateCopyWith<$Res> {
  _$ProfileStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$InitialProfileImplCopyWith<$Res> {
  factory _$$InitialProfileImplCopyWith(_$InitialProfileImpl value,
          $Res Function(_$InitialProfileImpl) then) =
      __$$InitialProfileImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialProfileImplCopyWithImpl<$Res>
    extends _$ProfileStateCopyWithImpl<$Res, _$InitialProfileImpl>
    implements _$$InitialProfileImplCopyWith<$Res> {
  __$$InitialProfileImplCopyWithImpl(
      _$InitialProfileImpl _value, $Res Function(_$InitialProfileImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$InitialProfileImpl implements _InitialProfile {
  const _$InitialProfileImpl();

  @override
  String toString() {
    return 'ProfileState.initialProfile()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialProfileImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialProfile,
    required TResult Function() loadingGetProfile,
    required TResult Function(GetProfileResponseModel data) successGetProfile,
    required TResult Function(ApiErrorModel apiErrorModel) errorGetProfile,
  }) {
    return initialProfile();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initialProfile,
    TResult? Function()? loadingGetProfile,
    TResult? Function(GetProfileResponseModel data)? successGetProfile,
    TResult? Function(ApiErrorModel apiErrorModel)? errorGetProfile,
  }) {
    return initialProfile?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialProfile,
    TResult Function()? loadingGetProfile,
    TResult Function(GetProfileResponseModel data)? successGetProfile,
    TResult Function(ApiErrorModel apiErrorModel)? errorGetProfile,
    required TResult orElse(),
  }) {
    if (initialProfile != null) {
      return initialProfile();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitialProfile value) initialProfile,
    required TResult Function(LoadingGetProfile value) loadingGetProfile,
    required TResult Function(SuccessGetProfile value) successGetProfile,
    required TResult Function(ErrorGetProfile value) errorGetProfile,
  }) {
    return initialProfile(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitialProfile value)? initialProfile,
    TResult? Function(LoadingGetProfile value)? loadingGetProfile,
    TResult? Function(SuccessGetProfile value)? successGetProfile,
    TResult? Function(ErrorGetProfile value)? errorGetProfile,
  }) {
    return initialProfile?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialProfile value)? initialProfile,
    TResult Function(LoadingGetProfile value)? loadingGetProfile,
    TResult Function(SuccessGetProfile value)? successGetProfile,
    TResult Function(ErrorGetProfile value)? errorGetProfile,
    required TResult orElse(),
  }) {
    if (initialProfile != null) {
      return initialProfile(this);
    }
    return orElse();
  }
}

abstract class _InitialProfile implements ProfileState {
  const factory _InitialProfile() = _$InitialProfileImpl;
}

/// @nodoc
abstract class _$$LoadingGetProfileImplCopyWith<$Res> {
  factory _$$LoadingGetProfileImplCopyWith(_$LoadingGetProfileImpl value,
          $Res Function(_$LoadingGetProfileImpl) then) =
      __$$LoadingGetProfileImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingGetProfileImplCopyWithImpl<$Res>
    extends _$ProfileStateCopyWithImpl<$Res, _$LoadingGetProfileImpl>
    implements _$$LoadingGetProfileImplCopyWith<$Res> {
  __$$LoadingGetProfileImplCopyWithImpl(_$LoadingGetProfileImpl _value,
      $Res Function(_$LoadingGetProfileImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$LoadingGetProfileImpl implements LoadingGetProfile {
  const _$LoadingGetProfileImpl();

  @override
  String toString() {
    return 'ProfileState.loadingGetProfile()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingGetProfileImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialProfile,
    required TResult Function() loadingGetProfile,
    required TResult Function(GetProfileResponseModel data) successGetProfile,
    required TResult Function(ApiErrorModel apiErrorModel) errorGetProfile,
  }) {
    return loadingGetProfile();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initialProfile,
    TResult? Function()? loadingGetProfile,
    TResult? Function(GetProfileResponseModel data)? successGetProfile,
    TResult? Function(ApiErrorModel apiErrorModel)? errorGetProfile,
  }) {
    return loadingGetProfile?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialProfile,
    TResult Function()? loadingGetProfile,
    TResult Function(GetProfileResponseModel data)? successGetProfile,
    TResult Function(ApiErrorModel apiErrorModel)? errorGetProfile,
    required TResult orElse(),
  }) {
    if (loadingGetProfile != null) {
      return loadingGetProfile();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitialProfile value) initialProfile,
    required TResult Function(LoadingGetProfile value) loadingGetProfile,
    required TResult Function(SuccessGetProfile value) successGetProfile,
    required TResult Function(ErrorGetProfile value) errorGetProfile,
  }) {
    return loadingGetProfile(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitialProfile value)? initialProfile,
    TResult? Function(LoadingGetProfile value)? loadingGetProfile,
    TResult? Function(SuccessGetProfile value)? successGetProfile,
    TResult? Function(ErrorGetProfile value)? errorGetProfile,
  }) {
    return loadingGetProfile?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialProfile value)? initialProfile,
    TResult Function(LoadingGetProfile value)? loadingGetProfile,
    TResult Function(SuccessGetProfile value)? successGetProfile,
    TResult Function(ErrorGetProfile value)? errorGetProfile,
    required TResult orElse(),
  }) {
    if (loadingGetProfile != null) {
      return loadingGetProfile(this);
    }
    return orElse();
  }
}

abstract class LoadingGetProfile implements ProfileState {
  const factory LoadingGetProfile() = _$LoadingGetProfileImpl;
}

/// @nodoc
abstract class _$$SuccessGetProfileImplCopyWith<$Res> {
  factory _$$SuccessGetProfileImplCopyWith(_$SuccessGetProfileImpl value,
          $Res Function(_$SuccessGetProfileImpl) then) =
      __$$SuccessGetProfileImplCopyWithImpl<$Res>;
  @useResult
  $Res call({GetProfileResponseModel data});
}

/// @nodoc
class __$$SuccessGetProfileImplCopyWithImpl<$Res>
    extends _$ProfileStateCopyWithImpl<$Res, _$SuccessGetProfileImpl>
    implements _$$SuccessGetProfileImplCopyWith<$Res> {
  __$$SuccessGetProfileImplCopyWithImpl(_$SuccessGetProfileImpl _value,
      $Res Function(_$SuccessGetProfileImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_$SuccessGetProfileImpl(
      null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as GetProfileResponseModel,
    ));
  }
}

/// @nodoc

class _$SuccessGetProfileImpl implements SuccessGetProfile {
  const _$SuccessGetProfileImpl(this.data);

  @override
  final GetProfileResponseModel data;

  @override
  String toString() {
    return 'ProfileState.successGetProfile(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessGetProfileImpl &&
            (identical(other.data, data) || other.data == data));
  }

  @override
  int get hashCode => Object.hash(runtimeType, data);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessGetProfileImplCopyWith<_$SuccessGetProfileImpl> get copyWith =>
      __$$SuccessGetProfileImplCopyWithImpl<_$SuccessGetProfileImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialProfile,
    required TResult Function() loadingGetProfile,
    required TResult Function(GetProfileResponseModel data) successGetProfile,
    required TResult Function(ApiErrorModel apiErrorModel) errorGetProfile,
  }) {
    return successGetProfile(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initialProfile,
    TResult? Function()? loadingGetProfile,
    TResult? Function(GetProfileResponseModel data)? successGetProfile,
    TResult? Function(ApiErrorModel apiErrorModel)? errorGetProfile,
  }) {
    return successGetProfile?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialProfile,
    TResult Function()? loadingGetProfile,
    TResult Function(GetProfileResponseModel data)? successGetProfile,
    TResult Function(ApiErrorModel apiErrorModel)? errorGetProfile,
    required TResult orElse(),
  }) {
    if (successGetProfile != null) {
      return successGetProfile(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitialProfile value) initialProfile,
    required TResult Function(LoadingGetProfile value) loadingGetProfile,
    required TResult Function(SuccessGetProfile value) successGetProfile,
    required TResult Function(ErrorGetProfile value) errorGetProfile,
  }) {
    return successGetProfile(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitialProfile value)? initialProfile,
    TResult? Function(LoadingGetProfile value)? loadingGetProfile,
    TResult? Function(SuccessGetProfile value)? successGetProfile,
    TResult? Function(ErrorGetProfile value)? errorGetProfile,
  }) {
    return successGetProfile?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialProfile value)? initialProfile,
    TResult Function(LoadingGetProfile value)? loadingGetProfile,
    TResult Function(SuccessGetProfile value)? successGetProfile,
    TResult Function(ErrorGetProfile value)? errorGetProfile,
    required TResult orElse(),
  }) {
    if (successGetProfile != null) {
      return successGetProfile(this);
    }
    return orElse();
  }
}

abstract class SuccessGetProfile implements ProfileState {
  const factory SuccessGetProfile(final GetProfileResponseModel data) =
      _$SuccessGetProfileImpl;

  GetProfileResponseModel get data;
  @JsonKey(ignore: true)
  _$$SuccessGetProfileImplCopyWith<_$SuccessGetProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorGetProfileImplCopyWith<$Res> {
  factory _$$ErrorGetProfileImplCopyWith(_$ErrorGetProfileImpl value,
          $Res Function(_$ErrorGetProfileImpl) then) =
      __$$ErrorGetProfileImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ApiErrorModel apiErrorModel});
}

/// @nodoc
class __$$ErrorGetProfileImplCopyWithImpl<$Res>
    extends _$ProfileStateCopyWithImpl<$Res, _$ErrorGetProfileImpl>
    implements _$$ErrorGetProfileImplCopyWith<$Res> {
  __$$ErrorGetProfileImplCopyWithImpl(
      _$ErrorGetProfileImpl _value, $Res Function(_$ErrorGetProfileImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? apiErrorModel = null,
  }) {
    return _then(_$ErrorGetProfileImpl(
      null == apiErrorModel
          ? _value.apiErrorModel
          : apiErrorModel // ignore: cast_nullable_to_non_nullable
              as ApiErrorModel,
    ));
  }
}

/// @nodoc

class _$ErrorGetProfileImpl implements ErrorGetProfile {
  const _$ErrorGetProfileImpl(this.apiErrorModel);

  @override
  final ApiErrorModel apiErrorModel;

  @override
  String toString() {
    return 'ProfileState.errorGetProfile(apiErrorModel: $apiErrorModel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorGetProfileImpl &&
            (identical(other.apiErrorModel, apiErrorModel) ||
                other.apiErrorModel == apiErrorModel));
  }

  @override
  int get hashCode => Object.hash(runtimeType, apiErrorModel);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorGetProfileImplCopyWith<_$ErrorGetProfileImpl> get copyWith =>
      __$$ErrorGetProfileImplCopyWithImpl<_$ErrorGetProfileImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialProfile,
    required TResult Function() loadingGetProfile,
    required TResult Function(GetProfileResponseModel data) successGetProfile,
    required TResult Function(ApiErrorModel apiErrorModel) errorGetProfile,
  }) {
    return errorGetProfile(apiErrorModel);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initialProfile,
    TResult? Function()? loadingGetProfile,
    TResult? Function(GetProfileResponseModel data)? successGetProfile,
    TResult? Function(ApiErrorModel apiErrorModel)? errorGetProfile,
  }) {
    return errorGetProfile?.call(apiErrorModel);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialProfile,
    TResult Function()? loadingGetProfile,
    TResult Function(GetProfileResponseModel data)? successGetProfile,
    TResult Function(ApiErrorModel apiErrorModel)? errorGetProfile,
    required TResult orElse(),
  }) {
    if (errorGetProfile != null) {
      return errorGetProfile(apiErrorModel);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitialProfile value) initialProfile,
    required TResult Function(LoadingGetProfile value) loadingGetProfile,
    required TResult Function(SuccessGetProfile value) successGetProfile,
    required TResult Function(ErrorGetProfile value) errorGetProfile,
  }) {
    return errorGetProfile(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitialProfile value)? initialProfile,
    TResult? Function(LoadingGetProfile value)? loadingGetProfile,
    TResult? Function(SuccessGetProfile value)? successGetProfile,
    TResult? Function(ErrorGetProfile value)? errorGetProfile,
  }) {
    return errorGetProfile?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialProfile value)? initialProfile,
    TResult Function(LoadingGetProfile value)? loadingGetProfile,
    TResult Function(SuccessGetProfile value)? successGetProfile,
    TResult Function(ErrorGetProfile value)? errorGetProfile,
    required TResult orElse(),
  }) {
    if (errorGetProfile != null) {
      return errorGetProfile(this);
    }
    return orElse();
  }
}

abstract class ErrorGetProfile implements ProfileState {
  const factory ErrorGetProfile(final ApiErrorModel apiErrorModel) =
      _$ErrorGetProfileImpl;

  ApiErrorModel get apiErrorModel;
  @JsonKey(ignore: true)
  _$$ErrorGetProfileImplCopyWith<_$ErrorGetProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
