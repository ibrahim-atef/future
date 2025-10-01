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
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initialAuth,
    TResult? Function()? loadingLogin,
    TResult? Function(LoginResponseModel data)? successLogin,
    TResult? Function(ApiErrorModel apiErrorModel)? errorLogin,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initialAuth,
    TResult Function()? loadingLogin,
    TResult Function(LoginResponseModel data)? successLogin,
    TResult Function(ApiErrorModel apiErrorModel)? errorLogin,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InitialAuth value) initialAuth,
    required TResult Function(LoadingLogin value) loadingLogin,
    required TResult Function(SuccessLogin value) successLogin,
    required TResult Function(ErrorLogin value) errorLogin,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_InitialAuth value)? initialAuth,
    TResult? Function(LoadingLogin value)? loadingLogin,
    TResult? Function(SuccessLogin value)? successLogin,
    TResult? Function(ErrorLogin value)? errorLogin,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InitialAuth value)? initialAuth,
    TResult Function(LoadingLogin value)? loadingLogin,
    TResult Function(SuccessLogin value)? successLogin,
    TResult Function(ErrorLogin value)? errorLogin,
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
