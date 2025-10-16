// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quiz_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$QuizState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() startQuizLoading,
    required TResult Function(StartQuizResponseModel data) startQuizSuccess,
    required TResult Function(ApiErrorModel apiErrorModel) startQuizError,
    required TResult Function() sendQuizResultLoading,
    required TResult Function(QuizResultResponseModel data)
        sendQuizResultSuccess,
    required TResult Function(ApiErrorModel apiErrorModel) sendQuizResultError,
    required TResult Function(int remainingSeconds) quizTimerTick,
    required TResult Function() quizTimeUp,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? startQuizLoading,
    TResult? Function(StartQuizResponseModel data)? startQuizSuccess,
    TResult? Function(ApiErrorModel apiErrorModel)? startQuizError,
    TResult? Function()? sendQuizResultLoading,
    TResult? Function(QuizResultResponseModel data)? sendQuizResultSuccess,
    TResult? Function(ApiErrorModel apiErrorModel)? sendQuizResultError,
    TResult? Function(int remainingSeconds)? quizTimerTick,
    TResult? Function()? quizTimeUp,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? startQuizLoading,
    TResult Function(StartQuizResponseModel data)? startQuizSuccess,
    TResult Function(ApiErrorModel apiErrorModel)? startQuizError,
    TResult Function()? sendQuizResultLoading,
    TResult Function(QuizResultResponseModel data)? sendQuizResultSuccess,
    TResult Function(ApiErrorModel apiErrorModel)? sendQuizResultError,
    TResult Function(int remainingSeconds)? quizTimerTick,
    TResult Function()? quizTimeUp,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(StartQuizLoading value) startQuizLoading,
    required TResult Function(StartQuizSuccess value) startQuizSuccess,
    required TResult Function(StartQuizError value) startQuizError,
    required TResult Function(SendQuizResultLoading value)
        sendQuizResultLoading,
    required TResult Function(SendQuizResultSuccess value)
        sendQuizResultSuccess,
    required TResult Function(SendQuizResultError value) sendQuizResultError,
    required TResult Function(QuizTimerTick value) quizTimerTick,
    required TResult Function(QuizTimeUp value) quizTimeUp,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(StartQuizLoading value)? startQuizLoading,
    TResult? Function(StartQuizSuccess value)? startQuizSuccess,
    TResult? Function(StartQuizError value)? startQuizError,
    TResult? Function(SendQuizResultLoading value)? sendQuizResultLoading,
    TResult? Function(SendQuizResultSuccess value)? sendQuizResultSuccess,
    TResult? Function(SendQuizResultError value)? sendQuizResultError,
    TResult? Function(QuizTimerTick value)? quizTimerTick,
    TResult? Function(QuizTimeUp value)? quizTimeUp,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(StartQuizLoading value)? startQuizLoading,
    TResult Function(StartQuizSuccess value)? startQuizSuccess,
    TResult Function(StartQuizError value)? startQuizError,
    TResult Function(SendQuizResultLoading value)? sendQuizResultLoading,
    TResult Function(SendQuizResultSuccess value)? sendQuizResultSuccess,
    TResult Function(SendQuizResultError value)? sendQuizResultError,
    TResult Function(QuizTimerTick value)? quizTimerTick,
    TResult Function(QuizTimeUp value)? quizTimeUp,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuizStateCopyWith<$Res> {
  factory $QuizStateCopyWith(QuizState value, $Res Function(QuizState) then) =
      _$QuizStateCopyWithImpl<$Res, QuizState>;
}

/// @nodoc
class _$QuizStateCopyWithImpl<$Res, $Val extends QuizState>
    implements $QuizStateCopyWith<$Res> {
  _$QuizStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$QuizStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'QuizState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() startQuizLoading,
    required TResult Function(StartQuizResponseModel data) startQuizSuccess,
    required TResult Function(ApiErrorModel apiErrorModel) startQuizError,
    required TResult Function() sendQuizResultLoading,
    required TResult Function(QuizResultResponseModel data)
        sendQuizResultSuccess,
    required TResult Function(ApiErrorModel apiErrorModel) sendQuizResultError,
    required TResult Function(int remainingSeconds) quizTimerTick,
    required TResult Function() quizTimeUp,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? startQuizLoading,
    TResult? Function(StartQuizResponseModel data)? startQuizSuccess,
    TResult? Function(ApiErrorModel apiErrorModel)? startQuizError,
    TResult? Function()? sendQuizResultLoading,
    TResult? Function(QuizResultResponseModel data)? sendQuizResultSuccess,
    TResult? Function(ApiErrorModel apiErrorModel)? sendQuizResultError,
    TResult? Function(int remainingSeconds)? quizTimerTick,
    TResult? Function()? quizTimeUp,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? startQuizLoading,
    TResult Function(StartQuizResponseModel data)? startQuizSuccess,
    TResult Function(ApiErrorModel apiErrorModel)? startQuizError,
    TResult Function()? sendQuizResultLoading,
    TResult Function(QuizResultResponseModel data)? sendQuizResultSuccess,
    TResult Function(ApiErrorModel apiErrorModel)? sendQuizResultError,
    TResult Function(int remainingSeconds)? quizTimerTick,
    TResult Function()? quizTimeUp,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(StartQuizLoading value) startQuizLoading,
    required TResult Function(StartQuizSuccess value) startQuizSuccess,
    required TResult Function(StartQuizError value) startQuizError,
    required TResult Function(SendQuizResultLoading value)
        sendQuizResultLoading,
    required TResult Function(SendQuizResultSuccess value)
        sendQuizResultSuccess,
    required TResult Function(SendQuizResultError value) sendQuizResultError,
    required TResult Function(QuizTimerTick value) quizTimerTick,
    required TResult Function(QuizTimeUp value) quizTimeUp,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(StartQuizLoading value)? startQuizLoading,
    TResult? Function(StartQuizSuccess value)? startQuizSuccess,
    TResult? Function(StartQuizError value)? startQuizError,
    TResult? Function(SendQuizResultLoading value)? sendQuizResultLoading,
    TResult? Function(SendQuizResultSuccess value)? sendQuizResultSuccess,
    TResult? Function(SendQuizResultError value)? sendQuizResultError,
    TResult? Function(QuizTimerTick value)? quizTimerTick,
    TResult? Function(QuizTimeUp value)? quizTimeUp,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(StartQuizLoading value)? startQuizLoading,
    TResult Function(StartQuizSuccess value)? startQuizSuccess,
    TResult Function(StartQuizError value)? startQuizError,
    TResult Function(SendQuizResultLoading value)? sendQuizResultLoading,
    TResult Function(SendQuizResultSuccess value)? sendQuizResultSuccess,
    TResult Function(SendQuizResultError value)? sendQuizResultError,
    TResult Function(QuizTimerTick value)? quizTimerTick,
    TResult Function(QuizTimeUp value)? quizTimeUp,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements QuizState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$StartQuizLoadingImplCopyWith<$Res> {
  factory _$$StartQuizLoadingImplCopyWith(_$StartQuizLoadingImpl value,
          $Res Function(_$StartQuizLoadingImpl) then) =
      __$$StartQuizLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$StartQuizLoadingImplCopyWithImpl<$Res>
    extends _$QuizStateCopyWithImpl<$Res, _$StartQuizLoadingImpl>
    implements _$$StartQuizLoadingImplCopyWith<$Res> {
  __$$StartQuizLoadingImplCopyWithImpl(_$StartQuizLoadingImpl _value,
      $Res Function(_$StartQuizLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$StartQuizLoadingImpl implements StartQuizLoading {
  const _$StartQuizLoadingImpl();

  @override
  String toString() {
    return 'QuizState.startQuizLoading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$StartQuizLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() startQuizLoading,
    required TResult Function(StartQuizResponseModel data) startQuizSuccess,
    required TResult Function(ApiErrorModel apiErrorModel) startQuizError,
    required TResult Function() sendQuizResultLoading,
    required TResult Function(QuizResultResponseModel data)
        sendQuizResultSuccess,
    required TResult Function(ApiErrorModel apiErrorModel) sendQuizResultError,
    required TResult Function(int remainingSeconds) quizTimerTick,
    required TResult Function() quizTimeUp,
  }) {
    return startQuizLoading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? startQuizLoading,
    TResult? Function(StartQuizResponseModel data)? startQuizSuccess,
    TResult? Function(ApiErrorModel apiErrorModel)? startQuizError,
    TResult? Function()? sendQuizResultLoading,
    TResult? Function(QuizResultResponseModel data)? sendQuizResultSuccess,
    TResult? Function(ApiErrorModel apiErrorModel)? sendQuizResultError,
    TResult? Function(int remainingSeconds)? quizTimerTick,
    TResult? Function()? quizTimeUp,
  }) {
    return startQuizLoading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? startQuizLoading,
    TResult Function(StartQuizResponseModel data)? startQuizSuccess,
    TResult Function(ApiErrorModel apiErrorModel)? startQuizError,
    TResult Function()? sendQuizResultLoading,
    TResult Function(QuizResultResponseModel data)? sendQuizResultSuccess,
    TResult Function(ApiErrorModel apiErrorModel)? sendQuizResultError,
    TResult Function(int remainingSeconds)? quizTimerTick,
    TResult Function()? quizTimeUp,
    required TResult orElse(),
  }) {
    if (startQuizLoading != null) {
      return startQuizLoading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(StartQuizLoading value) startQuizLoading,
    required TResult Function(StartQuizSuccess value) startQuizSuccess,
    required TResult Function(StartQuizError value) startQuizError,
    required TResult Function(SendQuizResultLoading value)
        sendQuizResultLoading,
    required TResult Function(SendQuizResultSuccess value)
        sendQuizResultSuccess,
    required TResult Function(SendQuizResultError value) sendQuizResultError,
    required TResult Function(QuizTimerTick value) quizTimerTick,
    required TResult Function(QuizTimeUp value) quizTimeUp,
  }) {
    return startQuizLoading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(StartQuizLoading value)? startQuizLoading,
    TResult? Function(StartQuizSuccess value)? startQuizSuccess,
    TResult? Function(StartQuizError value)? startQuizError,
    TResult? Function(SendQuizResultLoading value)? sendQuizResultLoading,
    TResult? Function(SendQuizResultSuccess value)? sendQuizResultSuccess,
    TResult? Function(SendQuizResultError value)? sendQuizResultError,
    TResult? Function(QuizTimerTick value)? quizTimerTick,
    TResult? Function(QuizTimeUp value)? quizTimeUp,
  }) {
    return startQuizLoading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(StartQuizLoading value)? startQuizLoading,
    TResult Function(StartQuizSuccess value)? startQuizSuccess,
    TResult Function(StartQuizError value)? startQuizError,
    TResult Function(SendQuizResultLoading value)? sendQuizResultLoading,
    TResult Function(SendQuizResultSuccess value)? sendQuizResultSuccess,
    TResult Function(SendQuizResultError value)? sendQuizResultError,
    TResult Function(QuizTimerTick value)? quizTimerTick,
    TResult Function(QuizTimeUp value)? quizTimeUp,
    required TResult orElse(),
  }) {
    if (startQuizLoading != null) {
      return startQuizLoading(this);
    }
    return orElse();
  }
}

abstract class StartQuizLoading implements QuizState {
  const factory StartQuizLoading() = _$StartQuizLoadingImpl;
}

/// @nodoc
abstract class _$$StartQuizSuccessImplCopyWith<$Res> {
  factory _$$StartQuizSuccessImplCopyWith(_$StartQuizSuccessImpl value,
          $Res Function(_$StartQuizSuccessImpl) then) =
      __$$StartQuizSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({StartQuizResponseModel data});
}

/// @nodoc
class __$$StartQuizSuccessImplCopyWithImpl<$Res>
    extends _$QuizStateCopyWithImpl<$Res, _$StartQuizSuccessImpl>
    implements _$$StartQuizSuccessImplCopyWith<$Res> {
  __$$StartQuizSuccessImplCopyWithImpl(_$StartQuizSuccessImpl _value,
      $Res Function(_$StartQuizSuccessImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_$StartQuizSuccessImpl(
      null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as StartQuizResponseModel,
    ));
  }
}

/// @nodoc

class _$StartQuizSuccessImpl implements StartQuizSuccess {
  const _$StartQuizSuccessImpl(this.data);

  @override
  final StartQuizResponseModel data;

  @override
  String toString() {
    return 'QuizState.startQuizSuccess(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StartQuizSuccessImpl &&
            (identical(other.data, data) || other.data == data));
  }

  @override
  int get hashCode => Object.hash(runtimeType, data);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StartQuizSuccessImplCopyWith<_$StartQuizSuccessImpl> get copyWith =>
      __$$StartQuizSuccessImplCopyWithImpl<_$StartQuizSuccessImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() startQuizLoading,
    required TResult Function(StartQuizResponseModel data) startQuizSuccess,
    required TResult Function(ApiErrorModel apiErrorModel) startQuizError,
    required TResult Function() sendQuizResultLoading,
    required TResult Function(QuizResultResponseModel data)
        sendQuizResultSuccess,
    required TResult Function(ApiErrorModel apiErrorModel) sendQuizResultError,
    required TResult Function(int remainingSeconds) quizTimerTick,
    required TResult Function() quizTimeUp,
  }) {
    return startQuizSuccess(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? startQuizLoading,
    TResult? Function(StartQuizResponseModel data)? startQuizSuccess,
    TResult? Function(ApiErrorModel apiErrorModel)? startQuizError,
    TResult? Function()? sendQuizResultLoading,
    TResult? Function(QuizResultResponseModel data)? sendQuizResultSuccess,
    TResult? Function(ApiErrorModel apiErrorModel)? sendQuizResultError,
    TResult? Function(int remainingSeconds)? quizTimerTick,
    TResult? Function()? quizTimeUp,
  }) {
    return startQuizSuccess?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? startQuizLoading,
    TResult Function(StartQuizResponseModel data)? startQuizSuccess,
    TResult Function(ApiErrorModel apiErrorModel)? startQuizError,
    TResult Function()? sendQuizResultLoading,
    TResult Function(QuizResultResponseModel data)? sendQuizResultSuccess,
    TResult Function(ApiErrorModel apiErrorModel)? sendQuizResultError,
    TResult Function(int remainingSeconds)? quizTimerTick,
    TResult Function()? quizTimeUp,
    required TResult orElse(),
  }) {
    if (startQuizSuccess != null) {
      return startQuizSuccess(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(StartQuizLoading value) startQuizLoading,
    required TResult Function(StartQuizSuccess value) startQuizSuccess,
    required TResult Function(StartQuizError value) startQuizError,
    required TResult Function(SendQuizResultLoading value)
        sendQuizResultLoading,
    required TResult Function(SendQuizResultSuccess value)
        sendQuizResultSuccess,
    required TResult Function(SendQuizResultError value) sendQuizResultError,
    required TResult Function(QuizTimerTick value) quizTimerTick,
    required TResult Function(QuizTimeUp value) quizTimeUp,
  }) {
    return startQuizSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(StartQuizLoading value)? startQuizLoading,
    TResult? Function(StartQuizSuccess value)? startQuizSuccess,
    TResult? Function(StartQuizError value)? startQuizError,
    TResult? Function(SendQuizResultLoading value)? sendQuizResultLoading,
    TResult? Function(SendQuizResultSuccess value)? sendQuizResultSuccess,
    TResult? Function(SendQuizResultError value)? sendQuizResultError,
    TResult? Function(QuizTimerTick value)? quizTimerTick,
    TResult? Function(QuizTimeUp value)? quizTimeUp,
  }) {
    return startQuizSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(StartQuizLoading value)? startQuizLoading,
    TResult Function(StartQuizSuccess value)? startQuizSuccess,
    TResult Function(StartQuizError value)? startQuizError,
    TResult Function(SendQuizResultLoading value)? sendQuizResultLoading,
    TResult Function(SendQuizResultSuccess value)? sendQuizResultSuccess,
    TResult Function(SendQuizResultError value)? sendQuizResultError,
    TResult Function(QuizTimerTick value)? quizTimerTick,
    TResult Function(QuizTimeUp value)? quizTimeUp,
    required TResult orElse(),
  }) {
    if (startQuizSuccess != null) {
      return startQuizSuccess(this);
    }
    return orElse();
  }
}

abstract class StartQuizSuccess implements QuizState {
  const factory StartQuizSuccess(final StartQuizResponseModel data) =
      _$StartQuizSuccessImpl;

  StartQuizResponseModel get data;
  @JsonKey(ignore: true)
  _$$StartQuizSuccessImplCopyWith<_$StartQuizSuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$StartQuizErrorImplCopyWith<$Res> {
  factory _$$StartQuizErrorImplCopyWith(_$StartQuizErrorImpl value,
          $Res Function(_$StartQuizErrorImpl) then) =
      __$$StartQuizErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ApiErrorModel apiErrorModel});
}

/// @nodoc
class __$$StartQuizErrorImplCopyWithImpl<$Res>
    extends _$QuizStateCopyWithImpl<$Res, _$StartQuizErrorImpl>
    implements _$$StartQuizErrorImplCopyWith<$Res> {
  __$$StartQuizErrorImplCopyWithImpl(
      _$StartQuizErrorImpl _value, $Res Function(_$StartQuizErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? apiErrorModel = null,
  }) {
    return _then(_$StartQuizErrorImpl(
      null == apiErrorModel
          ? _value.apiErrorModel
          : apiErrorModel // ignore: cast_nullable_to_non_nullable
              as ApiErrorModel,
    ));
  }
}

/// @nodoc

class _$StartQuizErrorImpl implements StartQuizError {
  const _$StartQuizErrorImpl(this.apiErrorModel);

  @override
  final ApiErrorModel apiErrorModel;

  @override
  String toString() {
    return 'QuizState.startQuizError(apiErrorModel: $apiErrorModel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StartQuizErrorImpl &&
            (identical(other.apiErrorModel, apiErrorModel) ||
                other.apiErrorModel == apiErrorModel));
  }

  @override
  int get hashCode => Object.hash(runtimeType, apiErrorModel);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StartQuizErrorImplCopyWith<_$StartQuizErrorImpl> get copyWith =>
      __$$StartQuizErrorImplCopyWithImpl<_$StartQuizErrorImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() startQuizLoading,
    required TResult Function(StartQuizResponseModel data) startQuizSuccess,
    required TResult Function(ApiErrorModel apiErrorModel) startQuizError,
    required TResult Function() sendQuizResultLoading,
    required TResult Function(QuizResultResponseModel data)
        sendQuizResultSuccess,
    required TResult Function(ApiErrorModel apiErrorModel) sendQuizResultError,
    required TResult Function(int remainingSeconds) quizTimerTick,
    required TResult Function() quizTimeUp,
  }) {
    return startQuizError(apiErrorModel);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? startQuizLoading,
    TResult? Function(StartQuizResponseModel data)? startQuizSuccess,
    TResult? Function(ApiErrorModel apiErrorModel)? startQuizError,
    TResult? Function()? sendQuizResultLoading,
    TResult? Function(QuizResultResponseModel data)? sendQuizResultSuccess,
    TResult? Function(ApiErrorModel apiErrorModel)? sendQuizResultError,
    TResult? Function(int remainingSeconds)? quizTimerTick,
    TResult? Function()? quizTimeUp,
  }) {
    return startQuizError?.call(apiErrorModel);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? startQuizLoading,
    TResult Function(StartQuizResponseModel data)? startQuizSuccess,
    TResult Function(ApiErrorModel apiErrorModel)? startQuizError,
    TResult Function()? sendQuizResultLoading,
    TResult Function(QuizResultResponseModel data)? sendQuizResultSuccess,
    TResult Function(ApiErrorModel apiErrorModel)? sendQuizResultError,
    TResult Function(int remainingSeconds)? quizTimerTick,
    TResult Function()? quizTimeUp,
    required TResult orElse(),
  }) {
    if (startQuizError != null) {
      return startQuizError(apiErrorModel);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(StartQuizLoading value) startQuizLoading,
    required TResult Function(StartQuizSuccess value) startQuizSuccess,
    required TResult Function(StartQuizError value) startQuizError,
    required TResult Function(SendQuizResultLoading value)
        sendQuizResultLoading,
    required TResult Function(SendQuizResultSuccess value)
        sendQuizResultSuccess,
    required TResult Function(SendQuizResultError value) sendQuizResultError,
    required TResult Function(QuizTimerTick value) quizTimerTick,
    required TResult Function(QuizTimeUp value) quizTimeUp,
  }) {
    return startQuizError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(StartQuizLoading value)? startQuizLoading,
    TResult? Function(StartQuizSuccess value)? startQuizSuccess,
    TResult? Function(StartQuizError value)? startQuizError,
    TResult? Function(SendQuizResultLoading value)? sendQuizResultLoading,
    TResult? Function(SendQuizResultSuccess value)? sendQuizResultSuccess,
    TResult? Function(SendQuizResultError value)? sendQuizResultError,
    TResult? Function(QuizTimerTick value)? quizTimerTick,
    TResult? Function(QuizTimeUp value)? quizTimeUp,
  }) {
    return startQuizError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(StartQuizLoading value)? startQuizLoading,
    TResult Function(StartQuizSuccess value)? startQuizSuccess,
    TResult Function(StartQuizError value)? startQuizError,
    TResult Function(SendQuizResultLoading value)? sendQuizResultLoading,
    TResult Function(SendQuizResultSuccess value)? sendQuizResultSuccess,
    TResult Function(SendQuizResultError value)? sendQuizResultError,
    TResult Function(QuizTimerTick value)? quizTimerTick,
    TResult Function(QuizTimeUp value)? quizTimeUp,
    required TResult orElse(),
  }) {
    if (startQuizError != null) {
      return startQuizError(this);
    }
    return orElse();
  }
}

abstract class StartQuizError implements QuizState {
  const factory StartQuizError(final ApiErrorModel apiErrorModel) =
      _$StartQuizErrorImpl;

  ApiErrorModel get apiErrorModel;
  @JsonKey(ignore: true)
  _$$StartQuizErrorImplCopyWith<_$StartQuizErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SendQuizResultLoadingImplCopyWith<$Res> {
  factory _$$SendQuizResultLoadingImplCopyWith(
          _$SendQuizResultLoadingImpl value,
          $Res Function(_$SendQuizResultLoadingImpl) then) =
      __$$SendQuizResultLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SendQuizResultLoadingImplCopyWithImpl<$Res>
    extends _$QuizStateCopyWithImpl<$Res, _$SendQuizResultLoadingImpl>
    implements _$$SendQuizResultLoadingImplCopyWith<$Res> {
  __$$SendQuizResultLoadingImplCopyWithImpl(_$SendQuizResultLoadingImpl _value,
      $Res Function(_$SendQuizResultLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$SendQuizResultLoadingImpl implements SendQuizResultLoading {
  const _$SendQuizResultLoadingImpl();

  @override
  String toString() {
    return 'QuizState.sendQuizResultLoading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SendQuizResultLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() startQuizLoading,
    required TResult Function(StartQuizResponseModel data) startQuizSuccess,
    required TResult Function(ApiErrorModel apiErrorModel) startQuizError,
    required TResult Function() sendQuizResultLoading,
    required TResult Function(QuizResultResponseModel data)
        sendQuizResultSuccess,
    required TResult Function(ApiErrorModel apiErrorModel) sendQuizResultError,
    required TResult Function(int remainingSeconds) quizTimerTick,
    required TResult Function() quizTimeUp,
  }) {
    return sendQuizResultLoading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? startQuizLoading,
    TResult? Function(StartQuizResponseModel data)? startQuizSuccess,
    TResult? Function(ApiErrorModel apiErrorModel)? startQuizError,
    TResult? Function()? sendQuizResultLoading,
    TResult? Function(QuizResultResponseModel data)? sendQuizResultSuccess,
    TResult? Function(ApiErrorModel apiErrorModel)? sendQuizResultError,
    TResult? Function(int remainingSeconds)? quizTimerTick,
    TResult? Function()? quizTimeUp,
  }) {
    return sendQuizResultLoading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? startQuizLoading,
    TResult Function(StartQuizResponseModel data)? startQuizSuccess,
    TResult Function(ApiErrorModel apiErrorModel)? startQuizError,
    TResult Function()? sendQuizResultLoading,
    TResult Function(QuizResultResponseModel data)? sendQuizResultSuccess,
    TResult Function(ApiErrorModel apiErrorModel)? sendQuizResultError,
    TResult Function(int remainingSeconds)? quizTimerTick,
    TResult Function()? quizTimeUp,
    required TResult orElse(),
  }) {
    if (sendQuizResultLoading != null) {
      return sendQuizResultLoading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(StartQuizLoading value) startQuizLoading,
    required TResult Function(StartQuizSuccess value) startQuizSuccess,
    required TResult Function(StartQuizError value) startQuizError,
    required TResult Function(SendQuizResultLoading value)
        sendQuizResultLoading,
    required TResult Function(SendQuizResultSuccess value)
        sendQuizResultSuccess,
    required TResult Function(SendQuizResultError value) sendQuizResultError,
    required TResult Function(QuizTimerTick value) quizTimerTick,
    required TResult Function(QuizTimeUp value) quizTimeUp,
  }) {
    return sendQuizResultLoading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(StartQuizLoading value)? startQuizLoading,
    TResult? Function(StartQuizSuccess value)? startQuizSuccess,
    TResult? Function(StartQuizError value)? startQuizError,
    TResult? Function(SendQuizResultLoading value)? sendQuizResultLoading,
    TResult? Function(SendQuizResultSuccess value)? sendQuizResultSuccess,
    TResult? Function(SendQuizResultError value)? sendQuizResultError,
    TResult? Function(QuizTimerTick value)? quizTimerTick,
    TResult? Function(QuizTimeUp value)? quizTimeUp,
  }) {
    return sendQuizResultLoading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(StartQuizLoading value)? startQuizLoading,
    TResult Function(StartQuizSuccess value)? startQuizSuccess,
    TResult Function(StartQuizError value)? startQuizError,
    TResult Function(SendQuizResultLoading value)? sendQuizResultLoading,
    TResult Function(SendQuizResultSuccess value)? sendQuizResultSuccess,
    TResult Function(SendQuizResultError value)? sendQuizResultError,
    TResult Function(QuizTimerTick value)? quizTimerTick,
    TResult Function(QuizTimeUp value)? quizTimeUp,
    required TResult orElse(),
  }) {
    if (sendQuizResultLoading != null) {
      return sendQuizResultLoading(this);
    }
    return orElse();
  }
}

abstract class SendQuizResultLoading implements QuizState {
  const factory SendQuizResultLoading() = _$SendQuizResultLoadingImpl;
}

/// @nodoc
abstract class _$$SendQuizResultSuccessImplCopyWith<$Res> {
  factory _$$SendQuizResultSuccessImplCopyWith(
          _$SendQuizResultSuccessImpl value,
          $Res Function(_$SendQuizResultSuccessImpl) then) =
      __$$SendQuizResultSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({QuizResultResponseModel data});
}

/// @nodoc
class __$$SendQuizResultSuccessImplCopyWithImpl<$Res>
    extends _$QuizStateCopyWithImpl<$Res, _$SendQuizResultSuccessImpl>
    implements _$$SendQuizResultSuccessImplCopyWith<$Res> {
  __$$SendQuizResultSuccessImplCopyWithImpl(_$SendQuizResultSuccessImpl _value,
      $Res Function(_$SendQuizResultSuccessImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_$SendQuizResultSuccessImpl(
      null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as QuizResultResponseModel,
    ));
  }
}

/// @nodoc

class _$SendQuizResultSuccessImpl implements SendQuizResultSuccess {
  const _$SendQuizResultSuccessImpl(this.data);

  @override
  final QuizResultResponseModel data;

  @override
  String toString() {
    return 'QuizState.sendQuizResultSuccess(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SendQuizResultSuccessImpl &&
            (identical(other.data, data) || other.data == data));
  }

  @override
  int get hashCode => Object.hash(runtimeType, data);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SendQuizResultSuccessImplCopyWith<_$SendQuizResultSuccessImpl>
      get copyWith => __$$SendQuizResultSuccessImplCopyWithImpl<
          _$SendQuizResultSuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() startQuizLoading,
    required TResult Function(StartQuizResponseModel data) startQuizSuccess,
    required TResult Function(ApiErrorModel apiErrorModel) startQuizError,
    required TResult Function() sendQuizResultLoading,
    required TResult Function(QuizResultResponseModel data)
        sendQuizResultSuccess,
    required TResult Function(ApiErrorModel apiErrorModel) sendQuizResultError,
    required TResult Function(int remainingSeconds) quizTimerTick,
    required TResult Function() quizTimeUp,
  }) {
    return sendQuizResultSuccess(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? startQuizLoading,
    TResult? Function(StartQuizResponseModel data)? startQuizSuccess,
    TResult? Function(ApiErrorModel apiErrorModel)? startQuizError,
    TResult? Function()? sendQuizResultLoading,
    TResult? Function(QuizResultResponseModel data)? sendQuizResultSuccess,
    TResult? Function(ApiErrorModel apiErrorModel)? sendQuizResultError,
    TResult? Function(int remainingSeconds)? quizTimerTick,
    TResult? Function()? quizTimeUp,
  }) {
    return sendQuizResultSuccess?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? startQuizLoading,
    TResult Function(StartQuizResponseModel data)? startQuizSuccess,
    TResult Function(ApiErrorModel apiErrorModel)? startQuizError,
    TResult Function()? sendQuizResultLoading,
    TResult Function(QuizResultResponseModel data)? sendQuizResultSuccess,
    TResult Function(ApiErrorModel apiErrorModel)? sendQuizResultError,
    TResult Function(int remainingSeconds)? quizTimerTick,
    TResult Function()? quizTimeUp,
    required TResult orElse(),
  }) {
    if (sendQuizResultSuccess != null) {
      return sendQuizResultSuccess(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(StartQuizLoading value) startQuizLoading,
    required TResult Function(StartQuizSuccess value) startQuizSuccess,
    required TResult Function(StartQuizError value) startQuizError,
    required TResult Function(SendQuizResultLoading value)
        sendQuizResultLoading,
    required TResult Function(SendQuizResultSuccess value)
        sendQuizResultSuccess,
    required TResult Function(SendQuizResultError value) sendQuizResultError,
    required TResult Function(QuizTimerTick value) quizTimerTick,
    required TResult Function(QuizTimeUp value) quizTimeUp,
  }) {
    return sendQuizResultSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(StartQuizLoading value)? startQuizLoading,
    TResult? Function(StartQuizSuccess value)? startQuizSuccess,
    TResult? Function(StartQuizError value)? startQuizError,
    TResult? Function(SendQuizResultLoading value)? sendQuizResultLoading,
    TResult? Function(SendQuizResultSuccess value)? sendQuizResultSuccess,
    TResult? Function(SendQuizResultError value)? sendQuizResultError,
    TResult? Function(QuizTimerTick value)? quizTimerTick,
    TResult? Function(QuizTimeUp value)? quizTimeUp,
  }) {
    return sendQuizResultSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(StartQuizLoading value)? startQuizLoading,
    TResult Function(StartQuizSuccess value)? startQuizSuccess,
    TResult Function(StartQuizError value)? startQuizError,
    TResult Function(SendQuizResultLoading value)? sendQuizResultLoading,
    TResult Function(SendQuizResultSuccess value)? sendQuizResultSuccess,
    TResult Function(SendQuizResultError value)? sendQuizResultError,
    TResult Function(QuizTimerTick value)? quizTimerTick,
    TResult Function(QuizTimeUp value)? quizTimeUp,
    required TResult orElse(),
  }) {
    if (sendQuizResultSuccess != null) {
      return sendQuizResultSuccess(this);
    }
    return orElse();
  }
}

abstract class SendQuizResultSuccess implements QuizState {
  const factory SendQuizResultSuccess(final QuizResultResponseModel data) =
      _$SendQuizResultSuccessImpl;

  QuizResultResponseModel get data;
  @JsonKey(ignore: true)
  _$$SendQuizResultSuccessImplCopyWith<_$SendQuizResultSuccessImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SendQuizResultErrorImplCopyWith<$Res> {
  factory _$$SendQuizResultErrorImplCopyWith(_$SendQuizResultErrorImpl value,
          $Res Function(_$SendQuizResultErrorImpl) then) =
      __$$SendQuizResultErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ApiErrorModel apiErrorModel});
}

/// @nodoc
class __$$SendQuizResultErrorImplCopyWithImpl<$Res>
    extends _$QuizStateCopyWithImpl<$Res, _$SendQuizResultErrorImpl>
    implements _$$SendQuizResultErrorImplCopyWith<$Res> {
  __$$SendQuizResultErrorImplCopyWithImpl(_$SendQuizResultErrorImpl _value,
      $Res Function(_$SendQuizResultErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? apiErrorModel = null,
  }) {
    return _then(_$SendQuizResultErrorImpl(
      null == apiErrorModel
          ? _value.apiErrorModel
          : apiErrorModel // ignore: cast_nullable_to_non_nullable
              as ApiErrorModel,
    ));
  }
}

/// @nodoc

class _$SendQuizResultErrorImpl implements SendQuizResultError {
  const _$SendQuizResultErrorImpl(this.apiErrorModel);

  @override
  final ApiErrorModel apiErrorModel;

  @override
  String toString() {
    return 'QuizState.sendQuizResultError(apiErrorModel: $apiErrorModel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SendQuizResultErrorImpl &&
            (identical(other.apiErrorModel, apiErrorModel) ||
                other.apiErrorModel == apiErrorModel));
  }

  @override
  int get hashCode => Object.hash(runtimeType, apiErrorModel);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SendQuizResultErrorImplCopyWith<_$SendQuizResultErrorImpl> get copyWith =>
      __$$SendQuizResultErrorImplCopyWithImpl<_$SendQuizResultErrorImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() startQuizLoading,
    required TResult Function(StartQuizResponseModel data) startQuizSuccess,
    required TResult Function(ApiErrorModel apiErrorModel) startQuizError,
    required TResult Function() sendQuizResultLoading,
    required TResult Function(QuizResultResponseModel data)
        sendQuizResultSuccess,
    required TResult Function(ApiErrorModel apiErrorModel) sendQuizResultError,
    required TResult Function(int remainingSeconds) quizTimerTick,
    required TResult Function() quizTimeUp,
  }) {
    return sendQuizResultError(apiErrorModel);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? startQuizLoading,
    TResult? Function(StartQuizResponseModel data)? startQuizSuccess,
    TResult? Function(ApiErrorModel apiErrorModel)? startQuizError,
    TResult? Function()? sendQuizResultLoading,
    TResult? Function(QuizResultResponseModel data)? sendQuizResultSuccess,
    TResult? Function(ApiErrorModel apiErrorModel)? sendQuizResultError,
    TResult? Function(int remainingSeconds)? quizTimerTick,
    TResult? Function()? quizTimeUp,
  }) {
    return sendQuizResultError?.call(apiErrorModel);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? startQuizLoading,
    TResult Function(StartQuizResponseModel data)? startQuizSuccess,
    TResult Function(ApiErrorModel apiErrorModel)? startQuizError,
    TResult Function()? sendQuizResultLoading,
    TResult Function(QuizResultResponseModel data)? sendQuizResultSuccess,
    TResult Function(ApiErrorModel apiErrorModel)? sendQuizResultError,
    TResult Function(int remainingSeconds)? quizTimerTick,
    TResult Function()? quizTimeUp,
    required TResult orElse(),
  }) {
    if (sendQuizResultError != null) {
      return sendQuizResultError(apiErrorModel);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(StartQuizLoading value) startQuizLoading,
    required TResult Function(StartQuizSuccess value) startQuizSuccess,
    required TResult Function(StartQuizError value) startQuizError,
    required TResult Function(SendQuizResultLoading value)
        sendQuizResultLoading,
    required TResult Function(SendQuizResultSuccess value)
        sendQuizResultSuccess,
    required TResult Function(SendQuizResultError value) sendQuizResultError,
    required TResult Function(QuizTimerTick value) quizTimerTick,
    required TResult Function(QuizTimeUp value) quizTimeUp,
  }) {
    return sendQuizResultError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(StartQuizLoading value)? startQuizLoading,
    TResult? Function(StartQuizSuccess value)? startQuizSuccess,
    TResult? Function(StartQuizError value)? startQuizError,
    TResult? Function(SendQuizResultLoading value)? sendQuizResultLoading,
    TResult? Function(SendQuizResultSuccess value)? sendQuizResultSuccess,
    TResult? Function(SendQuizResultError value)? sendQuizResultError,
    TResult? Function(QuizTimerTick value)? quizTimerTick,
    TResult? Function(QuizTimeUp value)? quizTimeUp,
  }) {
    return sendQuizResultError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(StartQuizLoading value)? startQuizLoading,
    TResult Function(StartQuizSuccess value)? startQuizSuccess,
    TResult Function(StartQuizError value)? startQuizError,
    TResult Function(SendQuizResultLoading value)? sendQuizResultLoading,
    TResult Function(SendQuizResultSuccess value)? sendQuizResultSuccess,
    TResult Function(SendQuizResultError value)? sendQuizResultError,
    TResult Function(QuizTimerTick value)? quizTimerTick,
    TResult Function(QuizTimeUp value)? quizTimeUp,
    required TResult orElse(),
  }) {
    if (sendQuizResultError != null) {
      return sendQuizResultError(this);
    }
    return orElse();
  }
}

abstract class SendQuizResultError implements QuizState {
  const factory SendQuizResultError(final ApiErrorModel apiErrorModel) =
      _$SendQuizResultErrorImpl;

  ApiErrorModel get apiErrorModel;
  @JsonKey(ignore: true)
  _$$SendQuizResultErrorImplCopyWith<_$SendQuizResultErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$QuizTimerTickImplCopyWith<$Res> {
  factory _$$QuizTimerTickImplCopyWith(
          _$QuizTimerTickImpl value, $Res Function(_$QuizTimerTickImpl) then) =
      __$$QuizTimerTickImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int remainingSeconds});
}

/// @nodoc
class __$$QuizTimerTickImplCopyWithImpl<$Res>
    extends _$QuizStateCopyWithImpl<$Res, _$QuizTimerTickImpl>
    implements _$$QuizTimerTickImplCopyWith<$Res> {
  __$$QuizTimerTickImplCopyWithImpl(
      _$QuizTimerTickImpl _value, $Res Function(_$QuizTimerTickImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? remainingSeconds = null,
  }) {
    return _then(_$QuizTimerTickImpl(
      null == remainingSeconds
          ? _value.remainingSeconds
          : remainingSeconds // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$QuizTimerTickImpl implements QuizTimerTick {
  const _$QuizTimerTickImpl(this.remainingSeconds);

  @override
  final int remainingSeconds;

  @override
  String toString() {
    return 'QuizState.quizTimerTick(remainingSeconds: $remainingSeconds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuizTimerTickImpl &&
            (identical(other.remainingSeconds, remainingSeconds) ||
                other.remainingSeconds == remainingSeconds));
  }

  @override
  int get hashCode => Object.hash(runtimeType, remainingSeconds);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$QuizTimerTickImplCopyWith<_$QuizTimerTickImpl> get copyWith =>
      __$$QuizTimerTickImplCopyWithImpl<_$QuizTimerTickImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() startQuizLoading,
    required TResult Function(StartQuizResponseModel data) startQuizSuccess,
    required TResult Function(ApiErrorModel apiErrorModel) startQuizError,
    required TResult Function() sendQuizResultLoading,
    required TResult Function(QuizResultResponseModel data)
        sendQuizResultSuccess,
    required TResult Function(ApiErrorModel apiErrorModel) sendQuizResultError,
    required TResult Function(int remainingSeconds) quizTimerTick,
    required TResult Function() quizTimeUp,
  }) {
    return quizTimerTick(remainingSeconds);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? startQuizLoading,
    TResult? Function(StartQuizResponseModel data)? startQuizSuccess,
    TResult? Function(ApiErrorModel apiErrorModel)? startQuizError,
    TResult? Function()? sendQuizResultLoading,
    TResult? Function(QuizResultResponseModel data)? sendQuizResultSuccess,
    TResult? Function(ApiErrorModel apiErrorModel)? sendQuizResultError,
    TResult? Function(int remainingSeconds)? quizTimerTick,
    TResult? Function()? quizTimeUp,
  }) {
    return quizTimerTick?.call(remainingSeconds);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? startQuizLoading,
    TResult Function(StartQuizResponseModel data)? startQuizSuccess,
    TResult Function(ApiErrorModel apiErrorModel)? startQuizError,
    TResult Function()? sendQuizResultLoading,
    TResult Function(QuizResultResponseModel data)? sendQuizResultSuccess,
    TResult Function(ApiErrorModel apiErrorModel)? sendQuizResultError,
    TResult Function(int remainingSeconds)? quizTimerTick,
    TResult Function()? quizTimeUp,
    required TResult orElse(),
  }) {
    if (quizTimerTick != null) {
      return quizTimerTick(remainingSeconds);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(StartQuizLoading value) startQuizLoading,
    required TResult Function(StartQuizSuccess value) startQuizSuccess,
    required TResult Function(StartQuizError value) startQuizError,
    required TResult Function(SendQuizResultLoading value)
        sendQuizResultLoading,
    required TResult Function(SendQuizResultSuccess value)
        sendQuizResultSuccess,
    required TResult Function(SendQuizResultError value) sendQuizResultError,
    required TResult Function(QuizTimerTick value) quizTimerTick,
    required TResult Function(QuizTimeUp value) quizTimeUp,
  }) {
    return quizTimerTick(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(StartQuizLoading value)? startQuizLoading,
    TResult? Function(StartQuizSuccess value)? startQuizSuccess,
    TResult? Function(StartQuizError value)? startQuizError,
    TResult? Function(SendQuizResultLoading value)? sendQuizResultLoading,
    TResult? Function(SendQuizResultSuccess value)? sendQuizResultSuccess,
    TResult? Function(SendQuizResultError value)? sendQuizResultError,
    TResult? Function(QuizTimerTick value)? quizTimerTick,
    TResult? Function(QuizTimeUp value)? quizTimeUp,
  }) {
    return quizTimerTick?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(StartQuizLoading value)? startQuizLoading,
    TResult Function(StartQuizSuccess value)? startQuizSuccess,
    TResult Function(StartQuizError value)? startQuizError,
    TResult Function(SendQuizResultLoading value)? sendQuizResultLoading,
    TResult Function(SendQuizResultSuccess value)? sendQuizResultSuccess,
    TResult Function(SendQuizResultError value)? sendQuizResultError,
    TResult Function(QuizTimerTick value)? quizTimerTick,
    TResult Function(QuizTimeUp value)? quizTimeUp,
    required TResult orElse(),
  }) {
    if (quizTimerTick != null) {
      return quizTimerTick(this);
    }
    return orElse();
  }
}

abstract class QuizTimerTick implements QuizState {
  const factory QuizTimerTick(final int remainingSeconds) = _$QuizTimerTickImpl;

  int get remainingSeconds;
  @JsonKey(ignore: true)
  _$$QuizTimerTickImplCopyWith<_$QuizTimerTickImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$QuizTimeUpImplCopyWith<$Res> {
  factory _$$QuizTimeUpImplCopyWith(
          _$QuizTimeUpImpl value, $Res Function(_$QuizTimeUpImpl) then) =
      __$$QuizTimeUpImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$QuizTimeUpImplCopyWithImpl<$Res>
    extends _$QuizStateCopyWithImpl<$Res, _$QuizTimeUpImpl>
    implements _$$QuizTimeUpImplCopyWith<$Res> {
  __$$QuizTimeUpImplCopyWithImpl(
      _$QuizTimeUpImpl _value, $Res Function(_$QuizTimeUpImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$QuizTimeUpImpl implements QuizTimeUp {
  const _$QuizTimeUpImpl();

  @override
  String toString() {
    return 'QuizState.quizTimeUp()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$QuizTimeUpImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() startQuizLoading,
    required TResult Function(StartQuizResponseModel data) startQuizSuccess,
    required TResult Function(ApiErrorModel apiErrorModel) startQuizError,
    required TResult Function() sendQuizResultLoading,
    required TResult Function(QuizResultResponseModel data)
        sendQuizResultSuccess,
    required TResult Function(ApiErrorModel apiErrorModel) sendQuizResultError,
    required TResult Function(int remainingSeconds) quizTimerTick,
    required TResult Function() quizTimeUp,
  }) {
    return quizTimeUp();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? startQuizLoading,
    TResult? Function(StartQuizResponseModel data)? startQuizSuccess,
    TResult? Function(ApiErrorModel apiErrorModel)? startQuizError,
    TResult? Function()? sendQuizResultLoading,
    TResult? Function(QuizResultResponseModel data)? sendQuizResultSuccess,
    TResult? Function(ApiErrorModel apiErrorModel)? sendQuizResultError,
    TResult? Function(int remainingSeconds)? quizTimerTick,
    TResult? Function()? quizTimeUp,
  }) {
    return quizTimeUp?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? startQuizLoading,
    TResult Function(StartQuizResponseModel data)? startQuizSuccess,
    TResult Function(ApiErrorModel apiErrorModel)? startQuizError,
    TResult Function()? sendQuizResultLoading,
    TResult Function(QuizResultResponseModel data)? sendQuizResultSuccess,
    TResult Function(ApiErrorModel apiErrorModel)? sendQuizResultError,
    TResult Function(int remainingSeconds)? quizTimerTick,
    TResult Function()? quizTimeUp,
    required TResult orElse(),
  }) {
    if (quizTimeUp != null) {
      return quizTimeUp();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(StartQuizLoading value) startQuizLoading,
    required TResult Function(StartQuizSuccess value) startQuizSuccess,
    required TResult Function(StartQuizError value) startQuizError,
    required TResult Function(SendQuizResultLoading value)
        sendQuizResultLoading,
    required TResult Function(SendQuizResultSuccess value)
        sendQuizResultSuccess,
    required TResult Function(SendQuizResultError value) sendQuizResultError,
    required TResult Function(QuizTimerTick value) quizTimerTick,
    required TResult Function(QuizTimeUp value) quizTimeUp,
  }) {
    return quizTimeUp(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(StartQuizLoading value)? startQuizLoading,
    TResult? Function(StartQuizSuccess value)? startQuizSuccess,
    TResult? Function(StartQuizError value)? startQuizError,
    TResult? Function(SendQuizResultLoading value)? sendQuizResultLoading,
    TResult? Function(SendQuizResultSuccess value)? sendQuizResultSuccess,
    TResult? Function(SendQuizResultError value)? sendQuizResultError,
    TResult? Function(QuizTimerTick value)? quizTimerTick,
    TResult? Function(QuizTimeUp value)? quizTimeUp,
  }) {
    return quizTimeUp?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(StartQuizLoading value)? startQuizLoading,
    TResult Function(StartQuizSuccess value)? startQuizSuccess,
    TResult Function(StartQuizError value)? startQuizError,
    TResult Function(SendQuizResultLoading value)? sendQuizResultLoading,
    TResult Function(SendQuizResultSuccess value)? sendQuizResultSuccess,
    TResult Function(SendQuizResultError value)? sendQuizResultError,
    TResult Function(QuizTimerTick value)? quizTimerTick,
    TResult Function(QuizTimeUp value)? quizTimeUp,
    required TResult orElse(),
  }) {
    if (quizTimeUp != null) {
      return quizTimeUp(this);
    }
    return orElse();
  }
}

abstract class QuizTimeUp implements QuizState {
  const factory QuizTimeUp() = _$QuizTimeUpImpl;
}
