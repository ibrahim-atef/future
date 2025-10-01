// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AuthState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialAuth,
    required TResult Function() loadingLogin,
    required TResult Function(LoginResponseModel data) successLogin,
    required TResult Function(ApiErrorModel apiErrorModel) errorLogin,
    required TResult Function() loadingLogout,
    required TResult Function() successLogout,
    required TResult Function(ApiErrorModel apiErrorModel) errorLogout,
    required TResult Function() loadingRegisterStep1,
    required TResult Function(RegisterResponseModel data) successRegisterStep1,
    required TResult Function(ApiErrorModel apiErrorModel) errorRegisterStep1,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initialAuth,
    TResult? Function()? loadingLogin,
    TResult? Function(LoginResponseModel data)? successLogin,
    TResult? Function(ApiErrorModel apiErrorModel)? errorLogin,
    TResult? Function()? loadingLogout,
    TResult? Function()? successLogout,
    TResult? Function(ApiErrorModel apiErrorModel)? errorLogout,
    TResult? Function()? loadingRegisterStep1,
    TResult? Function(RegisterResponseModel data)? successRegisterStep1,
    TResult? Function(ApiErrorModel apiErrorModel)? errorRegisterStep1,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialAuth,
    TResult Function()? loadingLogin,
    TResult Function(LoginResponseModel data)? successLogin,
    TResult Function(ApiErrorModel apiErrorModel)? errorLogin,
    TResult Function()? loadingLogout,
    TResult Function()? successLogout,
    TResult Function(ApiErrorModel apiErrorModel)? errorLogout,
    TResult Function()? loadingRegisterStep1,
    TResult Function(RegisterResponseModel data)? successRegisterStep1,
    TResult Function(ApiErrorModel apiErrorModel)? errorRegisterStep1,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitialAuth value) initialAuth,
    required TResult Function(LoadingLogin value) loadingLogin,
    required TResult Function(SuccessLogin value) successLogin,
    required TResult Function(ErrorLogin value) errorLogin,
    required TResult Function(LoadingLogout value) loadingLogout,
    required TResult Function(SuccessLogout value) successLogout,
    required TResult Function(ErrorLogout value) errorLogout,
    required TResult Function(LoadingRegisterStep1 value) loadingRegisterStep1,
    required TResult Function(SuccessRegisterStep1 value) successRegisterStep1,
    required TResult Function(ErrorRegisterStep1 value) errorRegisterStep1,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitialAuth value)? initialAuth,
    TResult? Function(LoadingLogin value)? loadingLogin,
    TResult? Function(SuccessLogin value)? successLogin,
    TResult? Function(ErrorLogin value)? errorLogin,
    TResult? Function(LoadingLogout value)? loadingLogout,
    TResult? Function(SuccessLogout value)? successLogout,
    TResult? Function(ErrorLogout value)? errorLogout,
    TResult? Function(LoadingRegisterStep1 value)? loadingRegisterStep1,
    TResult? Function(SuccessRegisterStep1 value)? successRegisterStep1,
    TResult? Function(ErrorRegisterStep1 value)? errorRegisterStep1,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialAuth value)? initialAuth,
    TResult Function(LoadingLogin value)? loadingLogin,
    TResult Function(SuccessLogin value)? successLogin,
    TResult Function(ErrorLogin value)? errorLogin,
    TResult Function(LoadingLogout value)? loadingLogout,
    TResult Function(SuccessLogout value)? successLogout,
    TResult Function(ErrorLogout value)? errorLogout,
    TResult Function(LoadingRegisterStep1 value)? loadingRegisterStep1,
    TResult Function(SuccessRegisterStep1 value)? successRegisterStep1,
    TResult Function(ErrorRegisterStep1 value)? errorRegisterStep1,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthStateCopyWith<$Res> {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) then) =
      _$AuthStateCopyWithImpl<$Res, AuthState>;
}

/// @nodoc
class _$AuthStateCopyWithImpl<$Res, $Val extends AuthState>
    implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitialAuthImplCopyWith<$Res> {
  factory _$$InitialAuthImplCopyWith(
          _$InitialAuthImpl value, $Res Function(_$InitialAuthImpl) then) =
      __$$InitialAuthImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialAuthImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$InitialAuthImpl>
    implements _$$InitialAuthImplCopyWith<$Res> {
  __$$InitialAuthImplCopyWithImpl(
      _$InitialAuthImpl _value, $Res Function(_$InitialAuthImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialAuthImpl implements _InitialAuth {
  const _$InitialAuthImpl();

  @override
  String toString() {
    return 'AuthState.initialAuth()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialAuthImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialAuth,
    required TResult Function() loadingLogin,
    required TResult Function(LoginResponseModel data) successLogin,
    required TResult Function(ApiErrorModel apiErrorModel) errorLogin,
    required TResult Function() loadingLogout,
    required TResult Function() successLogout,
    required TResult Function(ApiErrorModel apiErrorModel) errorLogout,
    required TResult Function() loadingRegisterStep1,
    required TResult Function(RegisterResponseModel data) successRegisterStep1,
    required TResult Function(ApiErrorModel apiErrorModel) errorRegisterStep1,
  }) {
    return initialAuth();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initialAuth,
    TResult? Function()? loadingLogin,
    TResult? Function(LoginResponseModel data)? successLogin,
    TResult? Function(ApiErrorModel apiErrorModel)? errorLogin,
    TResult? Function()? loadingLogout,
    TResult? Function()? successLogout,
    TResult? Function(ApiErrorModel apiErrorModel)? errorLogout,
    TResult? Function()? loadingRegisterStep1,
    TResult? Function(RegisterResponseModel data)? successRegisterStep1,
    TResult? Function(ApiErrorModel apiErrorModel)? errorRegisterStep1,
  }) {
    return initialAuth?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialAuth,
    TResult Function()? loadingLogin,
    TResult Function(LoginResponseModel data)? successLogin,
    TResult Function(ApiErrorModel apiErrorModel)? errorLogin,
    TResult Function()? loadingLogout,
    TResult Function()? successLogout,
    TResult Function(ApiErrorModel apiErrorModel)? errorLogout,
    TResult Function()? loadingRegisterStep1,
    TResult Function(RegisterResponseModel data)? successRegisterStep1,
    TResult Function(ApiErrorModel apiErrorModel)? errorRegisterStep1,
    required TResult orElse(),
  }) {
    if (initialAuth != null) {
      return initialAuth();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitialAuth value) initialAuth,
    required TResult Function(LoadingLogin value) loadingLogin,
    required TResult Function(SuccessLogin value) successLogin,
    required TResult Function(ErrorLogin value) errorLogin,
    required TResult Function(LoadingLogout value) loadingLogout,
    required TResult Function(SuccessLogout value) successLogout,
    required TResult Function(ErrorLogout value) errorLogout,
    required TResult Function(LoadingRegisterStep1 value) loadingRegisterStep1,
    required TResult Function(SuccessRegisterStep1 value) successRegisterStep1,
    required TResult Function(ErrorRegisterStep1 value) errorRegisterStep1,
  }) {
    return initialAuth(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitialAuth value)? initialAuth,
    TResult? Function(LoadingLogin value)? loadingLogin,
    TResult? Function(SuccessLogin value)? successLogin,
    TResult? Function(ErrorLogin value)? errorLogin,
    TResult? Function(LoadingLogout value)? loadingLogout,
    TResult? Function(SuccessLogout value)? successLogout,
    TResult? Function(ErrorLogout value)? errorLogout,
    TResult? Function(LoadingRegisterStep1 value)? loadingRegisterStep1,
    TResult? Function(SuccessRegisterStep1 value)? successRegisterStep1,
    TResult? Function(ErrorRegisterStep1 value)? errorRegisterStep1,
  }) {
    return initialAuth?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialAuth value)? initialAuth,
    TResult Function(LoadingLogin value)? loadingLogin,
    TResult Function(SuccessLogin value)? successLogin,
    TResult Function(ErrorLogin value)? errorLogin,
    TResult Function(LoadingLogout value)? loadingLogout,
    TResult Function(SuccessLogout value)? successLogout,
    TResult Function(ErrorLogout value)? errorLogout,
    TResult Function(LoadingRegisterStep1 value)? loadingRegisterStep1,
    TResult Function(SuccessRegisterStep1 value)? successRegisterStep1,
    TResult Function(ErrorRegisterStep1 value)? errorRegisterStep1,
    required TResult orElse(),
  }) {
    if (initialAuth != null) {
      return initialAuth(this);
    }
    return orElse();
  }
}

abstract class _InitialAuth implements AuthState {
  const factory _InitialAuth() = _$InitialAuthImpl;
}

/// @nodoc
abstract class _$$LoadingLoginImplCopyWith<$Res> {
  factory _$$LoadingLoginImplCopyWith(
          _$LoadingLoginImpl value, $Res Function(_$LoadingLoginImpl) then) =
      __$$LoadingLoginImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingLoginImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$LoadingLoginImpl>
    implements _$$LoadingLoginImplCopyWith<$Res> {
  __$$LoadingLoginImplCopyWithImpl(
      _$LoadingLoginImpl _value, $Res Function(_$LoadingLoginImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingLoginImpl implements LoadingLogin {
  const _$LoadingLoginImpl();

  @override
  String toString() {
    return 'AuthState.loadingLogin()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingLoginImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialAuth,
    required TResult Function() loadingLogin,
    required TResult Function(LoginResponseModel data) successLogin,
    required TResult Function(ApiErrorModel apiErrorModel) errorLogin,
    required TResult Function() loadingLogout,
    required TResult Function() successLogout,
    required TResult Function(ApiErrorModel apiErrorModel) errorLogout,
    required TResult Function() loadingRegisterStep1,
    required TResult Function(RegisterResponseModel data) successRegisterStep1,
    required TResult Function(ApiErrorModel apiErrorModel) errorRegisterStep1,
  }) {
    return loadingLogin();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initialAuth,
    TResult? Function()? loadingLogin,
    TResult? Function(LoginResponseModel data)? successLogin,
    TResult? Function(ApiErrorModel apiErrorModel)? errorLogin,
    TResult? Function()? loadingLogout,
    TResult? Function()? successLogout,
    TResult? Function(ApiErrorModel apiErrorModel)? errorLogout,
    TResult? Function()? loadingRegisterStep1,
    TResult? Function(RegisterResponseModel data)? successRegisterStep1,
    TResult? Function(ApiErrorModel apiErrorModel)? errorRegisterStep1,
  }) {
    return loadingLogin?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialAuth,
    TResult Function()? loadingLogin,
    TResult Function(LoginResponseModel data)? successLogin,
    TResult Function(ApiErrorModel apiErrorModel)? errorLogin,
    TResult Function()? loadingLogout,
    TResult Function()? successLogout,
    TResult Function(ApiErrorModel apiErrorModel)? errorLogout,
    TResult Function()? loadingRegisterStep1,
    TResult Function(RegisterResponseModel data)? successRegisterStep1,
    TResult Function(ApiErrorModel apiErrorModel)? errorRegisterStep1,
    required TResult orElse(),
  }) {
    if (loadingLogin != null) {
      return loadingLogin();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitialAuth value) initialAuth,
    required TResult Function(LoadingLogin value) loadingLogin,
    required TResult Function(SuccessLogin value) successLogin,
    required TResult Function(ErrorLogin value) errorLogin,
    required TResult Function(LoadingLogout value) loadingLogout,
    required TResult Function(SuccessLogout value) successLogout,
    required TResult Function(ErrorLogout value) errorLogout,
    required TResult Function(LoadingRegisterStep1 value) loadingRegisterStep1,
    required TResult Function(SuccessRegisterStep1 value) successRegisterStep1,
    required TResult Function(ErrorRegisterStep1 value) errorRegisterStep1,
  }) {
    return loadingLogin(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitialAuth value)? initialAuth,
    TResult? Function(LoadingLogin value)? loadingLogin,
    TResult? Function(SuccessLogin value)? successLogin,
    TResult? Function(ErrorLogin value)? errorLogin,
    TResult? Function(LoadingLogout value)? loadingLogout,
    TResult? Function(SuccessLogout value)? successLogout,
    TResult? Function(ErrorLogout value)? errorLogout,
    TResult? Function(LoadingRegisterStep1 value)? loadingRegisterStep1,
    TResult? Function(SuccessRegisterStep1 value)? successRegisterStep1,
    TResult? Function(ErrorRegisterStep1 value)? errorRegisterStep1,
  }) {
    return loadingLogin?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialAuth value)? initialAuth,
    TResult Function(LoadingLogin value)? loadingLogin,
    TResult Function(SuccessLogin value)? successLogin,
    TResult Function(ErrorLogin value)? errorLogin,
    TResult Function(LoadingLogout value)? loadingLogout,
    TResult Function(SuccessLogout value)? successLogout,
    TResult Function(ErrorLogout value)? errorLogout,
    TResult Function(LoadingRegisterStep1 value)? loadingRegisterStep1,
    TResult Function(SuccessRegisterStep1 value)? successRegisterStep1,
    TResult Function(ErrorRegisterStep1 value)? errorRegisterStep1,
    required TResult orElse(),
  }) {
    if (loadingLogin != null) {
      return loadingLogin(this);
    }
    return orElse();
  }
}

abstract class LoadingLogin implements AuthState {
  const factory LoadingLogin() = _$LoadingLoginImpl;
}

/// @nodoc
abstract class _$$SuccessLoginImplCopyWith<$Res> {
  factory _$$SuccessLoginImplCopyWith(
          _$SuccessLoginImpl value, $Res Function(_$SuccessLoginImpl) then) =
      __$$SuccessLoginImplCopyWithImpl<$Res>;
  @useResult
  $Res call({LoginResponseModel data});
}

/// @nodoc
class __$$SuccessLoginImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$SuccessLoginImpl>
    implements _$$SuccessLoginImplCopyWith<$Res> {
  __$$SuccessLoginImplCopyWithImpl(
      _$SuccessLoginImpl _value, $Res Function(_$SuccessLoginImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_$SuccessLoginImpl(
      null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as LoginResponseModel,
    ));
  }
}

/// @nodoc

class _$SuccessLoginImpl implements SuccessLogin {
  const _$SuccessLoginImpl(this.data);

  @override
  final LoginResponseModel data;

  @override
  String toString() {
    return 'AuthState.successLogin(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessLoginImpl &&
            (identical(other.data, data) || other.data == data));
  }

  @override
  int get hashCode => Object.hash(runtimeType, data);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessLoginImplCopyWith<_$SuccessLoginImpl> get copyWith =>
      __$$SuccessLoginImplCopyWithImpl<_$SuccessLoginImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialAuth,
    required TResult Function() loadingLogin,
    required TResult Function(LoginResponseModel data) successLogin,
    required TResult Function(ApiErrorModel apiErrorModel) errorLogin,
    required TResult Function() loadingLogout,
    required TResult Function() successLogout,
    required TResult Function(ApiErrorModel apiErrorModel) errorLogout,
    required TResult Function() loadingRegisterStep1,
    required TResult Function(RegisterResponseModel data) successRegisterStep1,
    required TResult Function(ApiErrorModel apiErrorModel) errorRegisterStep1,
  }) {
    return successLogin(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initialAuth,
    TResult? Function()? loadingLogin,
    TResult? Function(LoginResponseModel data)? successLogin,
    TResult? Function(ApiErrorModel apiErrorModel)? errorLogin,
    TResult? Function()? loadingLogout,
    TResult? Function()? successLogout,
    TResult? Function(ApiErrorModel apiErrorModel)? errorLogout,
    TResult? Function()? loadingRegisterStep1,
    TResult? Function(RegisterResponseModel data)? successRegisterStep1,
    TResult? Function(ApiErrorModel apiErrorModel)? errorRegisterStep1,
  }) {
    return successLogin?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialAuth,
    TResult Function()? loadingLogin,
    TResult Function(LoginResponseModel data)? successLogin,
    TResult Function(ApiErrorModel apiErrorModel)? errorLogin,
    TResult Function()? loadingLogout,
    TResult Function()? successLogout,
    TResult Function(ApiErrorModel apiErrorModel)? errorLogout,
    TResult Function()? loadingRegisterStep1,
    TResult Function(RegisterResponseModel data)? successRegisterStep1,
    TResult Function(ApiErrorModel apiErrorModel)? errorRegisterStep1,
    required TResult orElse(),
  }) {
    if (successLogin != null) {
      return successLogin(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitialAuth value) initialAuth,
    required TResult Function(LoadingLogin value) loadingLogin,
    required TResult Function(SuccessLogin value) successLogin,
    required TResult Function(ErrorLogin value) errorLogin,
    required TResult Function(LoadingLogout value) loadingLogout,
    required TResult Function(SuccessLogout value) successLogout,
    required TResult Function(ErrorLogout value) errorLogout,
    required TResult Function(LoadingRegisterStep1 value) loadingRegisterStep1,
    required TResult Function(SuccessRegisterStep1 value) successRegisterStep1,
    required TResult Function(ErrorRegisterStep1 value) errorRegisterStep1,
  }) {
    return successLogin(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitialAuth value)? initialAuth,
    TResult? Function(LoadingLogin value)? loadingLogin,
    TResult? Function(SuccessLogin value)? successLogin,
    TResult? Function(ErrorLogin value)? errorLogin,
    TResult? Function(LoadingLogout value)? loadingLogout,
    TResult? Function(SuccessLogout value)? successLogout,
    TResult? Function(ErrorLogout value)? errorLogout,
    TResult? Function(LoadingRegisterStep1 value)? loadingRegisterStep1,
    TResult? Function(SuccessRegisterStep1 value)? successRegisterStep1,
    TResult? Function(ErrorRegisterStep1 value)? errorRegisterStep1,
  }) {
    return successLogin?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialAuth value)? initialAuth,
    TResult Function(LoadingLogin value)? loadingLogin,
    TResult Function(SuccessLogin value)? successLogin,
    TResult Function(ErrorLogin value)? errorLogin,
    TResult Function(LoadingLogout value)? loadingLogout,
    TResult Function(SuccessLogout value)? successLogout,
    TResult Function(ErrorLogout value)? errorLogout,
    TResult Function(LoadingRegisterStep1 value)? loadingRegisterStep1,
    TResult Function(SuccessRegisterStep1 value)? successRegisterStep1,
    TResult Function(ErrorRegisterStep1 value)? errorRegisterStep1,
    required TResult orElse(),
  }) {
    if (successLogin != null) {
      return successLogin(this);
    }
    return orElse();
  }
}

abstract class SuccessLogin implements AuthState {
  const factory SuccessLogin(final LoginResponseModel data) =
      _$SuccessLoginImpl;

  LoginResponseModel get data;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SuccessLoginImplCopyWith<_$SuccessLoginImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorLoginImplCopyWith<$Res> {
  factory _$$ErrorLoginImplCopyWith(
          _$ErrorLoginImpl value, $Res Function(_$ErrorLoginImpl) then) =
      __$$ErrorLoginImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ApiErrorModel apiErrorModel});
}

/// @nodoc
class __$$ErrorLoginImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$ErrorLoginImpl>
    implements _$$ErrorLoginImplCopyWith<$Res> {
  __$$ErrorLoginImplCopyWithImpl(
      _$ErrorLoginImpl _value, $Res Function(_$ErrorLoginImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? apiErrorModel = null,
  }) {
    return _then(_$ErrorLoginImpl(
      null == apiErrorModel
          ? _value.apiErrorModel
          : apiErrorModel // ignore: cast_nullable_to_non_nullable
              as ApiErrorModel,
    ));
  }
}

/// @nodoc

class _$ErrorLoginImpl implements ErrorLogin {
  const _$ErrorLoginImpl(this.apiErrorModel);

  @override
  final ApiErrorModel apiErrorModel;

  @override
  String toString() {
    return 'AuthState.errorLogin(apiErrorModel: $apiErrorModel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorLoginImpl &&
            (identical(other.apiErrorModel, apiErrorModel) ||
                other.apiErrorModel == apiErrorModel));
  }

  @override
  int get hashCode => Object.hash(runtimeType, apiErrorModel);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorLoginImplCopyWith<_$ErrorLoginImpl> get copyWith =>
      __$$ErrorLoginImplCopyWithImpl<_$ErrorLoginImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialAuth,
    required TResult Function() loadingLogin,
    required TResult Function(LoginResponseModel data) successLogin,
    required TResult Function(ApiErrorModel apiErrorModel) errorLogin,
    required TResult Function() loadingLogout,
    required TResult Function() successLogout,
    required TResult Function(ApiErrorModel apiErrorModel) errorLogout,
    required TResult Function() loadingRegisterStep1,
    required TResult Function(RegisterResponseModel data) successRegisterStep1,
    required TResult Function(ApiErrorModel apiErrorModel) errorRegisterStep1,
  }) {
    return errorLogin(apiErrorModel);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initialAuth,
    TResult? Function()? loadingLogin,
    TResult? Function(LoginResponseModel data)? successLogin,
    TResult? Function(ApiErrorModel apiErrorModel)? errorLogin,
    TResult? Function()? loadingLogout,
    TResult? Function()? successLogout,
    TResult? Function(ApiErrorModel apiErrorModel)? errorLogout,
    TResult? Function()? loadingRegisterStep1,
    TResult? Function(RegisterResponseModel data)? successRegisterStep1,
    TResult? Function(ApiErrorModel apiErrorModel)? errorRegisterStep1,
  }) {
    return errorLogin?.call(apiErrorModel);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialAuth,
    TResult Function()? loadingLogin,
    TResult Function(LoginResponseModel data)? successLogin,
    TResult Function(ApiErrorModel apiErrorModel)? errorLogin,
    TResult Function()? loadingLogout,
    TResult Function()? successLogout,
    TResult Function(ApiErrorModel apiErrorModel)? errorLogout,
    TResult Function()? loadingRegisterStep1,
    TResult Function(RegisterResponseModel data)? successRegisterStep1,
    TResult Function(ApiErrorModel apiErrorModel)? errorRegisterStep1,
    required TResult orElse(),
  }) {
    if (errorLogin != null) {
      return errorLogin(apiErrorModel);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitialAuth value) initialAuth,
    required TResult Function(LoadingLogin value) loadingLogin,
    required TResult Function(SuccessLogin value) successLogin,
    required TResult Function(ErrorLogin value) errorLogin,
    required TResult Function(LoadingLogout value) loadingLogout,
    required TResult Function(SuccessLogout value) successLogout,
    required TResult Function(ErrorLogout value) errorLogout,
    required TResult Function(LoadingRegisterStep1 value) loadingRegisterStep1,
    required TResult Function(SuccessRegisterStep1 value) successRegisterStep1,
    required TResult Function(ErrorRegisterStep1 value) errorRegisterStep1,
  }) {
    return errorLogin(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitialAuth value)? initialAuth,
    TResult? Function(LoadingLogin value)? loadingLogin,
    TResult? Function(SuccessLogin value)? successLogin,
    TResult? Function(ErrorLogin value)? errorLogin,
    TResult? Function(LoadingLogout value)? loadingLogout,
    TResult? Function(SuccessLogout value)? successLogout,
    TResult? Function(ErrorLogout value)? errorLogout,
    TResult? Function(LoadingRegisterStep1 value)? loadingRegisterStep1,
    TResult? Function(SuccessRegisterStep1 value)? successRegisterStep1,
    TResult? Function(ErrorRegisterStep1 value)? errorRegisterStep1,
  }) {
    return errorLogin?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialAuth value)? initialAuth,
    TResult Function(LoadingLogin value)? loadingLogin,
    TResult Function(SuccessLogin value)? successLogin,
    TResult Function(ErrorLogin value)? errorLogin,
    TResult Function(LoadingLogout value)? loadingLogout,
    TResult Function(SuccessLogout value)? successLogout,
    TResult Function(ErrorLogout value)? errorLogout,
    TResult Function(LoadingRegisterStep1 value)? loadingRegisterStep1,
    TResult Function(SuccessRegisterStep1 value)? successRegisterStep1,
    TResult Function(ErrorRegisterStep1 value)? errorRegisterStep1,
    required TResult orElse(),
  }) {
    if (errorLogin != null) {
      return errorLogin(this);
    }
    return orElse();
  }
}

abstract class ErrorLogin implements AuthState {
  const factory ErrorLogin(final ApiErrorModel apiErrorModel) =
      _$ErrorLoginImpl;

  ApiErrorModel get apiErrorModel;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorLoginImplCopyWith<_$ErrorLoginImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadingLogoutImplCopyWith<$Res> {
  factory _$$LoadingLogoutImplCopyWith(
          _$LoadingLogoutImpl value, $Res Function(_$LoadingLogoutImpl) then) =
      __$$LoadingLogoutImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingLogoutImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$LoadingLogoutImpl>
    implements _$$LoadingLogoutImplCopyWith<$Res> {
  __$$LoadingLogoutImplCopyWithImpl(
      _$LoadingLogoutImpl _value, $Res Function(_$LoadingLogoutImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingLogoutImpl implements LoadingLogout {
  const _$LoadingLogoutImpl();

  @override
  String toString() {
    return 'AuthState.loadingLogout()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingLogoutImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialAuth,
    required TResult Function() loadingLogin,
    required TResult Function(LoginResponseModel data) successLogin,
    required TResult Function(ApiErrorModel apiErrorModel) errorLogin,
    required TResult Function() loadingLogout,
    required TResult Function() successLogout,
    required TResult Function(ApiErrorModel apiErrorModel) errorLogout,
    required TResult Function() loadingRegisterStep1,
    required TResult Function(RegisterResponseModel data) successRegisterStep1,
    required TResult Function(ApiErrorModel apiErrorModel) errorRegisterStep1,
  }) {
    return loadingLogout();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initialAuth,
    TResult? Function()? loadingLogin,
    TResult? Function(LoginResponseModel data)? successLogin,
    TResult? Function(ApiErrorModel apiErrorModel)? errorLogin,
    TResult? Function()? loadingLogout,
    TResult? Function()? successLogout,
    TResult? Function(ApiErrorModel apiErrorModel)? errorLogout,
    TResult? Function()? loadingRegisterStep1,
    TResult? Function(RegisterResponseModel data)? successRegisterStep1,
    TResult? Function(ApiErrorModel apiErrorModel)? errorRegisterStep1,
  }) {
    return loadingLogout?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialAuth,
    TResult Function()? loadingLogin,
    TResult Function(LoginResponseModel data)? successLogin,
    TResult Function(ApiErrorModel apiErrorModel)? errorLogin,
    TResult Function()? loadingLogout,
    TResult Function()? successLogout,
    TResult Function(ApiErrorModel apiErrorModel)? errorLogout,
    TResult Function()? loadingRegisterStep1,
    TResult Function(RegisterResponseModel data)? successRegisterStep1,
    TResult Function(ApiErrorModel apiErrorModel)? errorRegisterStep1,
    required TResult orElse(),
  }) {
    if (loadingLogout != null) {
      return loadingLogout();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitialAuth value) initialAuth,
    required TResult Function(LoadingLogin value) loadingLogin,
    required TResult Function(SuccessLogin value) successLogin,
    required TResult Function(ErrorLogin value) errorLogin,
    required TResult Function(LoadingLogout value) loadingLogout,
    required TResult Function(SuccessLogout value) successLogout,
    required TResult Function(ErrorLogout value) errorLogout,
    required TResult Function(LoadingRegisterStep1 value) loadingRegisterStep1,
    required TResult Function(SuccessRegisterStep1 value) successRegisterStep1,
    required TResult Function(ErrorRegisterStep1 value) errorRegisterStep1,
  }) {
    return loadingLogout(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitialAuth value)? initialAuth,
    TResult? Function(LoadingLogin value)? loadingLogin,
    TResult? Function(SuccessLogin value)? successLogin,
    TResult? Function(ErrorLogin value)? errorLogin,
    TResult? Function(LoadingLogout value)? loadingLogout,
    TResult? Function(SuccessLogout value)? successLogout,
    TResult? Function(ErrorLogout value)? errorLogout,
    TResult? Function(LoadingRegisterStep1 value)? loadingRegisterStep1,
    TResult? Function(SuccessRegisterStep1 value)? successRegisterStep1,
    TResult? Function(ErrorRegisterStep1 value)? errorRegisterStep1,
  }) {
    return loadingLogout?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialAuth value)? initialAuth,
    TResult Function(LoadingLogin value)? loadingLogin,
    TResult Function(SuccessLogin value)? successLogin,
    TResult Function(ErrorLogin value)? errorLogin,
    TResult Function(LoadingLogout value)? loadingLogout,
    TResult Function(SuccessLogout value)? successLogout,
    TResult Function(ErrorLogout value)? errorLogout,
    TResult Function(LoadingRegisterStep1 value)? loadingRegisterStep1,
    TResult Function(SuccessRegisterStep1 value)? successRegisterStep1,
    TResult Function(ErrorRegisterStep1 value)? errorRegisterStep1,
    required TResult orElse(),
  }) {
    if (loadingLogout != null) {
      return loadingLogout(this);
    }
    return orElse();
  }
}

abstract class LoadingLogout implements AuthState {
  const factory LoadingLogout() = _$LoadingLogoutImpl;
}

/// @nodoc
abstract class _$$SuccessLogoutImplCopyWith<$Res> {
  factory _$$SuccessLogoutImplCopyWith(
          _$SuccessLogoutImpl value, $Res Function(_$SuccessLogoutImpl) then) =
      __$$SuccessLogoutImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SuccessLogoutImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$SuccessLogoutImpl>
    implements _$$SuccessLogoutImplCopyWith<$Res> {
  __$$SuccessLogoutImplCopyWithImpl(
      _$SuccessLogoutImpl _value, $Res Function(_$SuccessLogoutImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SuccessLogoutImpl implements SuccessLogout {
  const _$SuccessLogoutImpl();

  @override
  String toString() {
    return 'AuthState.successLogout()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SuccessLogoutImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialAuth,
    required TResult Function() loadingLogin,
    required TResult Function(LoginResponseModel data) successLogin,
    required TResult Function(ApiErrorModel apiErrorModel) errorLogin,
    required TResult Function() loadingLogout,
    required TResult Function() successLogout,
    required TResult Function(ApiErrorModel apiErrorModel) errorLogout,
    required TResult Function() loadingRegisterStep1,
    required TResult Function(RegisterResponseModel data) successRegisterStep1,
    required TResult Function(ApiErrorModel apiErrorModel) errorRegisterStep1,
  }) {
    return successLogout();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initialAuth,
    TResult? Function()? loadingLogin,
    TResult? Function(LoginResponseModel data)? successLogin,
    TResult? Function(ApiErrorModel apiErrorModel)? errorLogin,
    TResult? Function()? loadingLogout,
    TResult? Function()? successLogout,
    TResult? Function(ApiErrorModel apiErrorModel)? errorLogout,
    TResult? Function()? loadingRegisterStep1,
    TResult? Function(RegisterResponseModel data)? successRegisterStep1,
    TResult? Function(ApiErrorModel apiErrorModel)? errorRegisterStep1,
  }) {
    return successLogout?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialAuth,
    TResult Function()? loadingLogin,
    TResult Function(LoginResponseModel data)? successLogin,
    TResult Function(ApiErrorModel apiErrorModel)? errorLogin,
    TResult Function()? loadingLogout,
    TResult Function()? successLogout,
    TResult Function(ApiErrorModel apiErrorModel)? errorLogout,
    TResult Function()? loadingRegisterStep1,
    TResult Function(RegisterResponseModel data)? successRegisterStep1,
    TResult Function(ApiErrorModel apiErrorModel)? errorRegisterStep1,
    required TResult orElse(),
  }) {
    if (successLogout != null) {
      return successLogout();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitialAuth value) initialAuth,
    required TResult Function(LoadingLogin value) loadingLogin,
    required TResult Function(SuccessLogin value) successLogin,
    required TResult Function(ErrorLogin value) errorLogin,
    required TResult Function(LoadingLogout value) loadingLogout,
    required TResult Function(SuccessLogout value) successLogout,
    required TResult Function(ErrorLogout value) errorLogout,
    required TResult Function(LoadingRegisterStep1 value) loadingRegisterStep1,
    required TResult Function(SuccessRegisterStep1 value) successRegisterStep1,
    required TResult Function(ErrorRegisterStep1 value) errorRegisterStep1,
  }) {
    return successLogout(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitialAuth value)? initialAuth,
    TResult? Function(LoadingLogin value)? loadingLogin,
    TResult? Function(SuccessLogin value)? successLogin,
    TResult? Function(ErrorLogin value)? errorLogin,
    TResult? Function(LoadingLogout value)? loadingLogout,
    TResult? Function(SuccessLogout value)? successLogout,
    TResult? Function(ErrorLogout value)? errorLogout,
    TResult? Function(LoadingRegisterStep1 value)? loadingRegisterStep1,
    TResult? Function(SuccessRegisterStep1 value)? successRegisterStep1,
    TResult? Function(ErrorRegisterStep1 value)? errorRegisterStep1,
  }) {
    return successLogout?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialAuth value)? initialAuth,
    TResult Function(LoadingLogin value)? loadingLogin,
    TResult Function(SuccessLogin value)? successLogin,
    TResult Function(ErrorLogin value)? errorLogin,
    TResult Function(LoadingLogout value)? loadingLogout,
    TResult Function(SuccessLogout value)? successLogout,
    TResult Function(ErrorLogout value)? errorLogout,
    TResult Function(LoadingRegisterStep1 value)? loadingRegisterStep1,
    TResult Function(SuccessRegisterStep1 value)? successRegisterStep1,
    TResult Function(ErrorRegisterStep1 value)? errorRegisterStep1,
    required TResult orElse(),
  }) {
    if (successLogout != null) {
      return successLogout(this);
    }
    return orElse();
  }
}

abstract class SuccessLogout implements AuthState {
  const factory SuccessLogout() = _$SuccessLogoutImpl;
}

/// @nodoc
abstract class _$$ErrorLogoutImplCopyWith<$Res> {
  factory _$$ErrorLogoutImplCopyWith(
          _$ErrorLogoutImpl value, $Res Function(_$ErrorLogoutImpl) then) =
      __$$ErrorLogoutImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ApiErrorModel apiErrorModel});
}

/// @nodoc
class __$$ErrorLogoutImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$ErrorLogoutImpl>
    implements _$$ErrorLogoutImplCopyWith<$Res> {
  __$$ErrorLogoutImplCopyWithImpl(
      _$ErrorLogoutImpl _value, $Res Function(_$ErrorLogoutImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? apiErrorModel = null,
  }) {
    return _then(_$ErrorLogoutImpl(
      null == apiErrorModel
          ? _value.apiErrorModel
          : apiErrorModel // ignore: cast_nullable_to_non_nullable
              as ApiErrorModel,
    ));
  }
}

/// @nodoc

class _$ErrorLogoutImpl implements ErrorLogout {
  const _$ErrorLogoutImpl(this.apiErrorModel);

  @override
  final ApiErrorModel apiErrorModel;

  @override
  String toString() {
    return 'AuthState.errorLogout(apiErrorModel: $apiErrorModel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorLogoutImpl &&
            (identical(other.apiErrorModel, apiErrorModel) ||
                other.apiErrorModel == apiErrorModel));
  }

  @override
  int get hashCode => Object.hash(runtimeType, apiErrorModel);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorLogoutImplCopyWith<_$ErrorLogoutImpl> get copyWith =>
      __$$ErrorLogoutImplCopyWithImpl<_$ErrorLogoutImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialAuth,
    required TResult Function() loadingLogin,
    required TResult Function(LoginResponseModel data) successLogin,
    required TResult Function(ApiErrorModel apiErrorModel) errorLogin,
    required TResult Function() loadingLogout,
    required TResult Function() successLogout,
    required TResult Function(ApiErrorModel apiErrorModel) errorLogout,
    required TResult Function() loadingRegisterStep1,
    required TResult Function(RegisterResponseModel data) successRegisterStep1,
    required TResult Function(ApiErrorModel apiErrorModel) errorRegisterStep1,
  }) {
    return errorLogout(apiErrorModel);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initialAuth,
    TResult? Function()? loadingLogin,
    TResult? Function(LoginResponseModel data)? successLogin,
    TResult? Function(ApiErrorModel apiErrorModel)? errorLogin,
    TResult? Function()? loadingLogout,
    TResult? Function()? successLogout,
    TResult? Function(ApiErrorModel apiErrorModel)? errorLogout,
    TResult? Function()? loadingRegisterStep1,
    TResult? Function(RegisterResponseModel data)? successRegisterStep1,
    TResult? Function(ApiErrorModel apiErrorModel)? errorRegisterStep1,
  }) {
    return errorLogout?.call(apiErrorModel);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialAuth,
    TResult Function()? loadingLogin,
    TResult Function(LoginResponseModel data)? successLogin,
    TResult Function(ApiErrorModel apiErrorModel)? errorLogin,
    TResult Function()? loadingLogout,
    TResult Function()? successLogout,
    TResult Function(ApiErrorModel apiErrorModel)? errorLogout,
    TResult Function()? loadingRegisterStep1,
    TResult Function(RegisterResponseModel data)? successRegisterStep1,
    TResult Function(ApiErrorModel apiErrorModel)? errorRegisterStep1,
    required TResult orElse(),
  }) {
    if (errorLogout != null) {
      return errorLogout(apiErrorModel);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitialAuth value) initialAuth,
    required TResult Function(LoadingLogin value) loadingLogin,
    required TResult Function(SuccessLogin value) successLogin,
    required TResult Function(ErrorLogin value) errorLogin,
    required TResult Function(LoadingLogout value) loadingLogout,
    required TResult Function(SuccessLogout value) successLogout,
    required TResult Function(ErrorLogout value) errorLogout,
    required TResult Function(LoadingRegisterStep1 value) loadingRegisterStep1,
    required TResult Function(SuccessRegisterStep1 value) successRegisterStep1,
    required TResult Function(ErrorRegisterStep1 value) errorRegisterStep1,
  }) {
    return errorLogout(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitialAuth value)? initialAuth,
    TResult? Function(LoadingLogin value)? loadingLogin,
    TResult? Function(SuccessLogin value)? successLogin,
    TResult? Function(ErrorLogin value)? errorLogin,
    TResult? Function(LoadingLogout value)? loadingLogout,
    TResult? Function(SuccessLogout value)? successLogout,
    TResult? Function(ErrorLogout value)? errorLogout,
    TResult? Function(LoadingRegisterStep1 value)? loadingRegisterStep1,
    TResult? Function(SuccessRegisterStep1 value)? successRegisterStep1,
    TResult? Function(ErrorRegisterStep1 value)? errorRegisterStep1,
  }) {
    return errorLogout?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialAuth value)? initialAuth,
    TResult Function(LoadingLogin value)? loadingLogin,
    TResult Function(SuccessLogin value)? successLogin,
    TResult Function(ErrorLogin value)? errorLogin,
    TResult Function(LoadingLogout value)? loadingLogout,
    TResult Function(SuccessLogout value)? successLogout,
    TResult Function(ErrorLogout value)? errorLogout,
    TResult Function(LoadingRegisterStep1 value)? loadingRegisterStep1,
    TResult Function(SuccessRegisterStep1 value)? successRegisterStep1,
    TResult Function(ErrorRegisterStep1 value)? errorRegisterStep1,
    required TResult orElse(),
  }) {
    if (errorLogout != null) {
      return errorLogout(this);
    }
    return orElse();
  }
}

abstract class ErrorLogout implements AuthState {
  const factory ErrorLogout(final ApiErrorModel apiErrorModel) =
      _$ErrorLogoutImpl;

  ApiErrorModel get apiErrorModel;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorLogoutImplCopyWith<_$ErrorLogoutImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadingRegisterStep1ImplCopyWith<$Res> {
  factory _$$LoadingRegisterStep1ImplCopyWith(_$LoadingRegisterStep1Impl value,
          $Res Function(_$LoadingRegisterStep1Impl) then) =
      __$$LoadingRegisterStep1ImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingRegisterStep1ImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$LoadingRegisterStep1Impl>
    implements _$$LoadingRegisterStep1ImplCopyWith<$Res> {
  __$$LoadingRegisterStep1ImplCopyWithImpl(_$LoadingRegisterStep1Impl _value,
      $Res Function(_$LoadingRegisterStep1Impl) _then)
      : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingRegisterStep1Impl implements LoadingRegisterStep1 {
  const _$LoadingRegisterStep1Impl();

  @override
  String toString() {
    return 'AuthState.loadingRegisterStep1()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadingRegisterStep1Impl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialAuth,
    required TResult Function() loadingLogin,
    required TResult Function(LoginResponseModel data) successLogin,
    required TResult Function(ApiErrorModel apiErrorModel) errorLogin,
    required TResult Function() loadingLogout,
    required TResult Function() successLogout,
    required TResult Function(ApiErrorModel apiErrorModel) errorLogout,
    required TResult Function() loadingRegisterStep1,
    required TResult Function(RegisterResponseModel data) successRegisterStep1,
    required TResult Function(ApiErrorModel apiErrorModel) errorRegisterStep1,
  }) {
    return loadingRegisterStep1();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initialAuth,
    TResult? Function()? loadingLogin,
    TResult? Function(LoginResponseModel data)? successLogin,
    TResult? Function(ApiErrorModel apiErrorModel)? errorLogin,
    TResult? Function()? loadingLogout,
    TResult? Function()? successLogout,
    TResult? Function(ApiErrorModel apiErrorModel)? errorLogout,
    TResult? Function()? loadingRegisterStep1,
    TResult? Function(RegisterResponseModel data)? successRegisterStep1,
    TResult? Function(ApiErrorModel apiErrorModel)? errorRegisterStep1,
  }) {
    return loadingRegisterStep1?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialAuth,
    TResult Function()? loadingLogin,
    TResult Function(LoginResponseModel data)? successLogin,
    TResult Function(ApiErrorModel apiErrorModel)? errorLogin,
    TResult Function()? loadingLogout,
    TResult Function()? successLogout,
    TResult Function(ApiErrorModel apiErrorModel)? errorLogout,
    TResult Function()? loadingRegisterStep1,
    TResult Function(RegisterResponseModel data)? successRegisterStep1,
    TResult Function(ApiErrorModel apiErrorModel)? errorRegisterStep1,
    required TResult orElse(),
  }) {
    if (loadingRegisterStep1 != null) {
      return loadingRegisterStep1();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitialAuth value) initialAuth,
    required TResult Function(LoadingLogin value) loadingLogin,
    required TResult Function(SuccessLogin value) successLogin,
    required TResult Function(ErrorLogin value) errorLogin,
    required TResult Function(LoadingLogout value) loadingLogout,
    required TResult Function(SuccessLogout value) successLogout,
    required TResult Function(ErrorLogout value) errorLogout,
    required TResult Function(LoadingRegisterStep1 value) loadingRegisterStep1,
    required TResult Function(SuccessRegisterStep1 value) successRegisterStep1,
    required TResult Function(ErrorRegisterStep1 value) errorRegisterStep1,
  }) {
    return loadingRegisterStep1(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitialAuth value)? initialAuth,
    TResult? Function(LoadingLogin value)? loadingLogin,
    TResult? Function(SuccessLogin value)? successLogin,
    TResult? Function(ErrorLogin value)? errorLogin,
    TResult? Function(LoadingLogout value)? loadingLogout,
    TResult? Function(SuccessLogout value)? successLogout,
    TResult? Function(ErrorLogout value)? errorLogout,
    TResult? Function(LoadingRegisterStep1 value)? loadingRegisterStep1,
    TResult? Function(SuccessRegisterStep1 value)? successRegisterStep1,
    TResult? Function(ErrorRegisterStep1 value)? errorRegisterStep1,
  }) {
    return loadingRegisterStep1?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialAuth value)? initialAuth,
    TResult Function(LoadingLogin value)? loadingLogin,
    TResult Function(SuccessLogin value)? successLogin,
    TResult Function(ErrorLogin value)? errorLogin,
    TResult Function(LoadingLogout value)? loadingLogout,
    TResult Function(SuccessLogout value)? successLogout,
    TResult Function(ErrorLogout value)? errorLogout,
    TResult Function(LoadingRegisterStep1 value)? loadingRegisterStep1,
    TResult Function(SuccessRegisterStep1 value)? successRegisterStep1,
    TResult Function(ErrorRegisterStep1 value)? errorRegisterStep1,
    required TResult orElse(),
  }) {
    if (loadingRegisterStep1 != null) {
      return loadingRegisterStep1(this);
    }
    return orElse();
  }
}

abstract class LoadingRegisterStep1 implements AuthState {
  const factory LoadingRegisterStep1() = _$LoadingRegisterStep1Impl;
}

/// @nodoc
abstract class _$$SuccessRegisterStep1ImplCopyWith<$Res> {
  factory _$$SuccessRegisterStep1ImplCopyWith(_$SuccessRegisterStep1Impl value,
          $Res Function(_$SuccessRegisterStep1Impl) then) =
      __$$SuccessRegisterStep1ImplCopyWithImpl<$Res>;
  @useResult
  $Res call({RegisterResponseModel data});
}

/// @nodoc
class __$$SuccessRegisterStep1ImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$SuccessRegisterStep1Impl>
    implements _$$SuccessRegisterStep1ImplCopyWith<$Res> {
  __$$SuccessRegisterStep1ImplCopyWithImpl(_$SuccessRegisterStep1Impl _value,
      $Res Function(_$SuccessRegisterStep1Impl) _then)
      : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_$SuccessRegisterStep1Impl(
      null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as RegisterResponseModel,
    ));
  }
}

/// @nodoc

class _$SuccessRegisterStep1Impl implements SuccessRegisterStep1 {
  const _$SuccessRegisterStep1Impl(this.data);

  @override
  final RegisterResponseModel data;

  @override
  String toString() {
    return 'AuthState.successRegisterStep1(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessRegisterStep1Impl &&
            (identical(other.data, data) || other.data == data));
  }

  @override
  int get hashCode => Object.hash(runtimeType, data);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessRegisterStep1ImplCopyWith<_$SuccessRegisterStep1Impl>
      get copyWith =>
          __$$SuccessRegisterStep1ImplCopyWithImpl<_$SuccessRegisterStep1Impl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialAuth,
    required TResult Function() loadingLogin,
    required TResult Function(LoginResponseModel data) successLogin,
    required TResult Function(ApiErrorModel apiErrorModel) errorLogin,
    required TResult Function() loadingLogout,
    required TResult Function() successLogout,
    required TResult Function(ApiErrorModel apiErrorModel) errorLogout,
    required TResult Function() loadingRegisterStep1,
    required TResult Function(RegisterResponseModel data) successRegisterStep1,
    required TResult Function(ApiErrorModel apiErrorModel) errorRegisterStep1,
  }) {
    return successRegisterStep1(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initialAuth,
    TResult? Function()? loadingLogin,
    TResult? Function(LoginResponseModel data)? successLogin,
    TResult? Function(ApiErrorModel apiErrorModel)? errorLogin,
    TResult? Function()? loadingLogout,
    TResult? Function()? successLogout,
    TResult? Function(ApiErrorModel apiErrorModel)? errorLogout,
    TResult? Function()? loadingRegisterStep1,
    TResult? Function(RegisterResponseModel data)? successRegisterStep1,
    TResult? Function(ApiErrorModel apiErrorModel)? errorRegisterStep1,
  }) {
    return successRegisterStep1?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialAuth,
    TResult Function()? loadingLogin,
    TResult Function(LoginResponseModel data)? successLogin,
    TResult Function(ApiErrorModel apiErrorModel)? errorLogin,
    TResult Function()? loadingLogout,
    TResult Function()? successLogout,
    TResult Function(ApiErrorModel apiErrorModel)? errorLogout,
    TResult Function()? loadingRegisterStep1,
    TResult Function(RegisterResponseModel data)? successRegisterStep1,
    TResult Function(ApiErrorModel apiErrorModel)? errorRegisterStep1,
    required TResult orElse(),
  }) {
    if (successRegisterStep1 != null) {
      return successRegisterStep1(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitialAuth value) initialAuth,
    required TResult Function(LoadingLogin value) loadingLogin,
    required TResult Function(SuccessLogin value) successLogin,
    required TResult Function(ErrorLogin value) errorLogin,
    required TResult Function(LoadingLogout value) loadingLogout,
    required TResult Function(SuccessLogout value) successLogout,
    required TResult Function(ErrorLogout value) errorLogout,
    required TResult Function(LoadingRegisterStep1 value) loadingRegisterStep1,
    required TResult Function(SuccessRegisterStep1 value) successRegisterStep1,
    required TResult Function(ErrorRegisterStep1 value) errorRegisterStep1,
  }) {
    return successRegisterStep1(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitialAuth value)? initialAuth,
    TResult? Function(LoadingLogin value)? loadingLogin,
    TResult? Function(SuccessLogin value)? successLogin,
    TResult? Function(ErrorLogin value)? errorLogin,
    TResult? Function(LoadingLogout value)? loadingLogout,
    TResult? Function(SuccessLogout value)? successLogout,
    TResult? Function(ErrorLogout value)? errorLogout,
    TResult? Function(LoadingRegisterStep1 value)? loadingRegisterStep1,
    TResult? Function(SuccessRegisterStep1 value)? successRegisterStep1,
    TResult? Function(ErrorRegisterStep1 value)? errorRegisterStep1,
  }) {
    return successRegisterStep1?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialAuth value)? initialAuth,
    TResult Function(LoadingLogin value)? loadingLogin,
    TResult Function(SuccessLogin value)? successLogin,
    TResult Function(ErrorLogin value)? errorLogin,
    TResult Function(LoadingLogout value)? loadingLogout,
    TResult Function(SuccessLogout value)? successLogout,
    TResult Function(ErrorLogout value)? errorLogout,
    TResult Function(LoadingRegisterStep1 value)? loadingRegisterStep1,
    TResult Function(SuccessRegisterStep1 value)? successRegisterStep1,
    TResult Function(ErrorRegisterStep1 value)? errorRegisterStep1,
    required TResult orElse(),
  }) {
    if (successRegisterStep1 != null) {
      return successRegisterStep1(this);
    }
    return orElse();
  }
}

abstract class SuccessRegisterStep1 implements AuthState {
  const factory SuccessRegisterStep1(final RegisterResponseModel data) =
      _$SuccessRegisterStep1Impl;

  RegisterResponseModel get data;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SuccessRegisterStep1ImplCopyWith<_$SuccessRegisterStep1Impl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorRegisterStep1ImplCopyWith<$Res> {
  factory _$$ErrorRegisterStep1ImplCopyWith(_$ErrorRegisterStep1Impl value,
          $Res Function(_$ErrorRegisterStep1Impl) then) =
      __$$ErrorRegisterStep1ImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ApiErrorModel apiErrorModel});
}

/// @nodoc
class __$$ErrorRegisterStep1ImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$ErrorRegisterStep1Impl>
    implements _$$ErrorRegisterStep1ImplCopyWith<$Res> {
  __$$ErrorRegisterStep1ImplCopyWithImpl(_$ErrorRegisterStep1Impl _value,
      $Res Function(_$ErrorRegisterStep1Impl) _then)
      : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? apiErrorModel = null,
  }) {
    return _then(_$ErrorRegisterStep1Impl(
      null == apiErrorModel
          ? _value.apiErrorModel
          : apiErrorModel // ignore: cast_nullable_to_non_nullable
              as ApiErrorModel,
    ));
  }
}

/// @nodoc

class _$ErrorRegisterStep1Impl implements ErrorRegisterStep1 {
  const _$ErrorRegisterStep1Impl(this.apiErrorModel);

  @override
  final ApiErrorModel apiErrorModel;

  @override
  String toString() {
    return 'AuthState.errorRegisterStep1(apiErrorModel: $apiErrorModel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorRegisterStep1Impl &&
            (identical(other.apiErrorModel, apiErrorModel) ||
                other.apiErrorModel == apiErrorModel));
  }

  @override
  int get hashCode => Object.hash(runtimeType, apiErrorModel);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorRegisterStep1ImplCopyWith<_$ErrorRegisterStep1Impl> get copyWith =>
      __$$ErrorRegisterStep1ImplCopyWithImpl<_$ErrorRegisterStep1Impl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initialAuth,
    required TResult Function() loadingLogin,
    required TResult Function(LoginResponseModel data) successLogin,
    required TResult Function(ApiErrorModel apiErrorModel) errorLogin,
    required TResult Function() loadingLogout,
    required TResult Function() successLogout,
    required TResult Function(ApiErrorModel apiErrorModel) errorLogout,
    required TResult Function() loadingRegisterStep1,
    required TResult Function(RegisterResponseModel data) successRegisterStep1,
    required TResult Function(ApiErrorModel apiErrorModel) errorRegisterStep1,
  }) {
    return errorRegisterStep1(apiErrorModel);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initialAuth,
    TResult? Function()? loadingLogin,
    TResult? Function(LoginResponseModel data)? successLogin,
    TResult? Function(ApiErrorModel apiErrorModel)? errorLogin,
    TResult? Function()? loadingLogout,
    TResult? Function()? successLogout,
    TResult? Function(ApiErrorModel apiErrorModel)? errorLogout,
    TResult? Function()? loadingRegisterStep1,
    TResult? Function(RegisterResponseModel data)? successRegisterStep1,
    TResult? Function(ApiErrorModel apiErrorModel)? errorRegisterStep1,
  }) {
    return errorRegisterStep1?.call(apiErrorModel);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialAuth,
    TResult Function()? loadingLogin,
    TResult Function(LoginResponseModel data)? successLogin,
    TResult Function(ApiErrorModel apiErrorModel)? errorLogin,
    TResult Function()? loadingLogout,
    TResult Function()? successLogout,
    TResult Function(ApiErrorModel apiErrorModel)? errorLogout,
    TResult Function()? loadingRegisterStep1,
    TResult Function(RegisterResponseModel data)? successRegisterStep1,
    TResult Function(ApiErrorModel apiErrorModel)? errorRegisterStep1,
    required TResult orElse(),
  }) {
    if (errorRegisterStep1 != null) {
      return errorRegisterStep1(apiErrorModel);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitialAuth value) initialAuth,
    required TResult Function(LoadingLogin value) loadingLogin,
    required TResult Function(SuccessLogin value) successLogin,
    required TResult Function(ErrorLogin value) errorLogin,
    required TResult Function(LoadingLogout value) loadingLogout,
    required TResult Function(SuccessLogout value) successLogout,
    required TResult Function(ErrorLogout value) errorLogout,
    required TResult Function(LoadingRegisterStep1 value) loadingRegisterStep1,
    required TResult Function(SuccessRegisterStep1 value) successRegisterStep1,
    required TResult Function(ErrorRegisterStep1 value) errorRegisterStep1,
  }) {
    return errorRegisterStep1(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitialAuth value)? initialAuth,
    TResult? Function(LoadingLogin value)? loadingLogin,
    TResult? Function(SuccessLogin value)? successLogin,
    TResult? Function(ErrorLogin value)? errorLogin,
    TResult? Function(LoadingLogout value)? loadingLogout,
    TResult? Function(SuccessLogout value)? successLogout,
    TResult? Function(ErrorLogout value)? errorLogout,
    TResult? Function(LoadingRegisterStep1 value)? loadingRegisterStep1,
    TResult? Function(SuccessRegisterStep1 value)? successRegisterStep1,
    TResult? Function(ErrorRegisterStep1 value)? errorRegisterStep1,
  }) {
    return errorRegisterStep1?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialAuth value)? initialAuth,
    TResult Function(LoadingLogin value)? loadingLogin,
    TResult Function(SuccessLogin value)? successLogin,
    TResult Function(ErrorLogin value)? errorLogin,
    TResult Function(LoadingLogout value)? loadingLogout,
    TResult Function(SuccessLogout value)? successLogout,
    TResult Function(ErrorLogout value)? errorLogout,
    TResult Function(LoadingRegisterStep1 value)? loadingRegisterStep1,
    TResult Function(SuccessRegisterStep1 value)? successRegisterStep1,
    TResult Function(ErrorRegisterStep1 value)? errorRegisterStep1,
    required TResult orElse(),
  }) {
    if (errorRegisterStep1 != null) {
      return errorRegisterStep1(this);
    }
    return orElse();
  }
}

abstract class ErrorRegisterStep1 implements AuthState {
  const factory ErrorRegisterStep1(final ApiErrorModel apiErrorModel) =
      _$ErrorRegisterStep1Impl;

  ApiErrorModel get apiErrorModel;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorRegisterStep1ImplCopyWith<_$ErrorRegisterStep1Impl> get copyWith =>
      throw _privateConstructorUsedError;
}
