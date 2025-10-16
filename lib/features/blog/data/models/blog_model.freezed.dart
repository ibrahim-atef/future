// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'blog_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GetPostsResponseModel _$GetPostsResponseModelFromJson(
    Map<String, dynamic> json) {
  return _GetPostsResponseModel.fromJson(json);
}

/// @nodoc
mixin _$GetPostsResponseModel {
  bool get success => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  List<PostModel> get data => throw _privateConstructorUsedError;
  PaginationModel get pagination => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GetPostsResponseModelCopyWith<GetPostsResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetPostsResponseModelCopyWith<$Res> {
  factory $GetPostsResponseModelCopyWith(GetPostsResponseModel value,
          $Res Function(GetPostsResponseModel) then) =
      _$GetPostsResponseModelCopyWithImpl<$Res, GetPostsResponseModel>;
  @useResult
  $Res call(
      {bool success,
      String message,
      List<PostModel> data,
      PaginationModel pagination});

  $PaginationModelCopyWith<$Res> get pagination;
}

/// @nodoc
class _$GetPostsResponseModelCopyWithImpl<$Res,
        $Val extends GetPostsResponseModel>
    implements $GetPostsResponseModelCopyWith<$Res> {
  _$GetPostsResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
    Object? data = null,
    Object? pagination = null,
  }) {
    return _then(_value.copyWith(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<PostModel>,
      pagination: null == pagination
          ? _value.pagination
          : pagination // ignore: cast_nullable_to_non_nullable
              as PaginationModel,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PaginationModelCopyWith<$Res> get pagination {
    return $PaginationModelCopyWith<$Res>(_value.pagination, (value) {
      return _then(_value.copyWith(pagination: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GetPostsResponseModelImplCopyWith<$Res>
    implements $GetPostsResponseModelCopyWith<$Res> {
  factory _$$GetPostsResponseModelImplCopyWith(
          _$GetPostsResponseModelImpl value,
          $Res Function(_$GetPostsResponseModelImpl) then) =
      __$$GetPostsResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool success,
      String message,
      List<PostModel> data,
      PaginationModel pagination});

  @override
  $PaginationModelCopyWith<$Res> get pagination;
}

/// @nodoc
class __$$GetPostsResponseModelImplCopyWithImpl<$Res>
    extends _$GetPostsResponseModelCopyWithImpl<$Res,
        _$GetPostsResponseModelImpl>
    implements _$$GetPostsResponseModelImplCopyWith<$Res> {
  __$$GetPostsResponseModelImplCopyWithImpl(_$GetPostsResponseModelImpl _value,
      $Res Function(_$GetPostsResponseModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
    Object? data = null,
    Object? pagination = null,
  }) {
    return _then(_$GetPostsResponseModelImpl(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<PostModel>,
      pagination: null == pagination
          ? _value.pagination
          : pagination // ignore: cast_nullable_to_non_nullable
              as PaginationModel,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GetPostsResponseModelImpl implements _GetPostsResponseModel {
  const _$GetPostsResponseModelImpl(
      {required this.success,
      required this.message,
      required final List<PostModel> data,
      required this.pagination})
      : _data = data;

  factory _$GetPostsResponseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$GetPostsResponseModelImplFromJson(json);

  @override
  final bool success;
  @override
  final String message;
  final List<PostModel> _data;
  @override
  List<PostModel> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  final PaginationModel pagination;

  @override
  String toString() {
    return 'GetPostsResponseModel(success: $success, message: $message, data: $data, pagination: $pagination)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetPostsResponseModelImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.pagination, pagination) ||
                other.pagination == pagination));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, success, message,
      const DeepCollectionEquality().hash(_data), pagination);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GetPostsResponseModelImplCopyWith<_$GetPostsResponseModelImpl>
      get copyWith => __$$GetPostsResponseModelImplCopyWithImpl<
          _$GetPostsResponseModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetPostsResponseModelImplToJson(
      this,
    );
  }
}

abstract class _GetPostsResponseModel implements GetPostsResponseModel {
  const factory _GetPostsResponseModel(
      {required final bool success,
      required final String message,
      required final List<PostModel> data,
      required final PaginationModel pagination}) = _$GetPostsResponseModelImpl;

  factory _GetPostsResponseModel.fromJson(Map<String, dynamic> json) =
      _$GetPostsResponseModelImpl.fromJson;

  @override
  bool get success;
  @override
  String get message;
  @override
  List<PostModel> get data;
  @override
  PaginationModel get pagination;
  @override
  @JsonKey(ignore: true)
  _$$GetPostsResponseModelImplCopyWith<_$GetPostsResponseModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

PostModel _$PostModelFromJson(Map<String, dynamic> json) {
  return _PostModel.fromJson(json);
}

/// @nodoc
mixin _$PostModel {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get excerpt => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  dynamic get imageUrl => throw _privateConstructorUsedError;
  String get author => throw _privateConstructorUsedError;
  List<dynamic> get tags => throw _privateConstructorUsedError;
  int get viewsCount => throw _privateConstructorUsedError;
  String get publishedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PostModelCopyWith<PostModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostModelCopyWith<$Res> {
  factory $PostModelCopyWith(PostModel value, $Res Function(PostModel) then) =
      _$PostModelCopyWithImpl<$Res, PostModel>;
  @useResult
  $Res call(
      {String id,
      String title,
      String excerpt,
      String content,
      dynamic imageUrl,
      String author,
      List<dynamic> tags,
      int viewsCount,
      String publishedAt});
}

/// @nodoc
class _$PostModelCopyWithImpl<$Res, $Val extends PostModel>
    implements $PostModelCopyWith<$Res> {
  _$PostModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? excerpt = null,
    Object? content = null,
    Object? imageUrl = freezed,
    Object? author = null,
    Object? tags = null,
    Object? viewsCount = null,
    Object? publishedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      excerpt: null == excerpt
          ? _value.excerpt
          : excerpt // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as dynamic,
      author: null == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      viewsCount: null == viewsCount
          ? _value.viewsCount
          : viewsCount // ignore: cast_nullable_to_non_nullable
              as int,
      publishedAt: null == publishedAt
          ? _value.publishedAt
          : publishedAt // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PostModelImplCopyWith<$Res>
    implements $PostModelCopyWith<$Res> {
  factory _$$PostModelImplCopyWith(
          _$PostModelImpl value, $Res Function(_$PostModelImpl) then) =
      __$$PostModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String excerpt,
      String content,
      dynamic imageUrl,
      String author,
      List<dynamic> tags,
      int viewsCount,
      String publishedAt});
}

/// @nodoc
class __$$PostModelImplCopyWithImpl<$Res>
    extends _$PostModelCopyWithImpl<$Res, _$PostModelImpl>
    implements _$$PostModelImplCopyWith<$Res> {
  __$$PostModelImplCopyWithImpl(
      _$PostModelImpl _value, $Res Function(_$PostModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? excerpt = null,
    Object? content = null,
    Object? imageUrl = freezed,
    Object? author = null,
    Object? tags = null,
    Object? viewsCount = null,
    Object? publishedAt = null,
  }) {
    return _then(_$PostModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      excerpt: null == excerpt
          ? _value.excerpt
          : excerpt // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as dynamic,
      author: null == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      viewsCount: null == viewsCount
          ? _value.viewsCount
          : viewsCount // ignore: cast_nullable_to_non_nullable
              as int,
      publishedAt: null == publishedAt
          ? _value.publishedAt
          : publishedAt // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PostModelImpl implements _PostModel {
  const _$PostModelImpl(
      {required this.id,
      required this.title,
      required this.excerpt,
      required this.content,
      required this.imageUrl,
      required this.author,
      required final List<dynamic> tags,
      required this.viewsCount,
      required this.publishedAt})
      : _tags = tags;

  factory _$PostModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PostModelImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String excerpt;
  @override
  final String content;
  @override
  final dynamic imageUrl;
  @override
  final String author;
  final List<dynamic> _tags;
  @override
  List<dynamic> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  final int viewsCount;
  @override
  final String publishedAt;

  @override
  String toString() {
    return 'PostModel(id: $id, title: $title, excerpt: $excerpt, content: $content, imageUrl: $imageUrl, author: $author, tags: $tags, viewsCount: $viewsCount, publishedAt: $publishedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.excerpt, excerpt) || other.excerpt == excerpt) &&
            (identical(other.content, content) || other.content == content) &&
            const DeepCollectionEquality().equals(other.imageUrl, imageUrl) &&
            (identical(other.author, author) || other.author == author) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.viewsCount, viewsCount) ||
                other.viewsCount == viewsCount) &&
            (identical(other.publishedAt, publishedAt) ||
                other.publishedAt == publishedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      excerpt,
      content,
      const DeepCollectionEquality().hash(imageUrl),
      author,
      const DeepCollectionEquality().hash(_tags),
      viewsCount,
      publishedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PostModelImplCopyWith<_$PostModelImpl> get copyWith =>
      __$$PostModelImplCopyWithImpl<_$PostModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PostModelImplToJson(
      this,
    );
  }
}

abstract class _PostModel implements PostModel {
  const factory _PostModel(
      {required final String id,
      required final String title,
      required final String excerpt,
      required final String content,
      required final dynamic imageUrl,
      required final String author,
      required final List<dynamic> tags,
      required final int viewsCount,
      required final String publishedAt}) = _$PostModelImpl;

  factory _PostModel.fromJson(Map<String, dynamic> json) =
      _$PostModelImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get excerpt;
  @override
  String get content;
  @override
  dynamic get imageUrl;
  @override
  String get author;
  @override
  List<dynamic> get tags;
  @override
  int get viewsCount;
  @override
  String get publishedAt;
  @override
  @JsonKey(ignore: true)
  _$$PostModelImplCopyWith<_$PostModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PaginationModel _$PaginationModelFromJson(Map<String, dynamic> json) {
  return _PaginationModel.fromJson(json);
}

/// @nodoc
mixin _$PaginationModel {
  @JsonKey(name: 'current_page')
  int get currentPage => throw _privateConstructorUsedError;
  @JsonKey(name: 'per_page')
  int get perPage => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_items')
  int get totalItems => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_pages')
  int get totalPages => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PaginationModelCopyWith<PaginationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaginationModelCopyWith<$Res> {
  factory $PaginationModelCopyWith(
          PaginationModel value, $Res Function(PaginationModel) then) =
      _$PaginationModelCopyWithImpl<$Res, PaginationModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'current_page') int currentPage,
      @JsonKey(name: 'per_page') int perPage,
      @JsonKey(name: 'total_items') int totalItems,
      @JsonKey(name: 'total_pages') int totalPages});
}

/// @nodoc
class _$PaginationModelCopyWithImpl<$Res, $Val extends PaginationModel>
    implements $PaginationModelCopyWith<$Res> {
  _$PaginationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentPage = null,
    Object? perPage = null,
    Object? totalItems = null,
    Object? totalPages = null,
  }) {
    return _then(_value.copyWith(
      currentPage: null == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      perPage: null == perPage
          ? _value.perPage
          : perPage // ignore: cast_nullable_to_non_nullable
              as int,
      totalItems: null == totalItems
          ? _value.totalItems
          : totalItems // ignore: cast_nullable_to_non_nullable
              as int,
      totalPages: null == totalPages
          ? _value.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PaginationModelImplCopyWith<$Res>
    implements $PaginationModelCopyWith<$Res> {
  factory _$$PaginationModelImplCopyWith(_$PaginationModelImpl value,
          $Res Function(_$PaginationModelImpl) then) =
      __$$PaginationModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'current_page') int currentPage,
      @JsonKey(name: 'per_page') int perPage,
      @JsonKey(name: 'total_items') int totalItems,
      @JsonKey(name: 'total_pages') int totalPages});
}

/// @nodoc
class __$$PaginationModelImplCopyWithImpl<$Res>
    extends _$PaginationModelCopyWithImpl<$Res, _$PaginationModelImpl>
    implements _$$PaginationModelImplCopyWith<$Res> {
  __$$PaginationModelImplCopyWithImpl(
      _$PaginationModelImpl _value, $Res Function(_$PaginationModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentPage = null,
    Object? perPage = null,
    Object? totalItems = null,
    Object? totalPages = null,
  }) {
    return _then(_$PaginationModelImpl(
      currentPage: null == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      perPage: null == perPage
          ? _value.perPage
          : perPage // ignore: cast_nullable_to_non_nullable
              as int,
      totalItems: null == totalItems
          ? _value.totalItems
          : totalItems // ignore: cast_nullable_to_non_nullable
              as int,
      totalPages: null == totalPages
          ? _value.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PaginationModelImpl implements _PaginationModel {
  const _$PaginationModelImpl(
      {@JsonKey(name: 'current_page') required this.currentPage,
      @JsonKey(name: 'per_page') required this.perPage,
      @JsonKey(name: 'total_items') required this.totalItems,
      @JsonKey(name: 'total_pages') required this.totalPages});

  factory _$PaginationModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaginationModelImplFromJson(json);

  @override
  @JsonKey(name: 'current_page')
  final int currentPage;
  @override
  @JsonKey(name: 'per_page')
  final int perPage;
  @override
  @JsonKey(name: 'total_items')
  final int totalItems;
  @override
  @JsonKey(name: 'total_pages')
  final int totalPages;

  @override
  String toString() {
    return 'PaginationModel(currentPage: $currentPage, perPage: $perPage, totalItems: $totalItems, totalPages: $totalPages)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaginationModelImpl &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.perPage, perPage) || other.perPage == perPage) &&
            (identical(other.totalItems, totalItems) ||
                other.totalItems == totalItems) &&
            (identical(other.totalPages, totalPages) ||
                other.totalPages == totalPages));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, currentPage, perPage, totalItems, totalPages);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PaginationModelImplCopyWith<_$PaginationModelImpl> get copyWith =>
      __$$PaginationModelImplCopyWithImpl<_$PaginationModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PaginationModelImplToJson(
      this,
    );
  }
}

abstract class _PaginationModel implements PaginationModel {
  const factory _PaginationModel(
          {@JsonKey(name: 'current_page') required final int currentPage,
          @JsonKey(name: 'per_page') required final int perPage,
          @JsonKey(name: 'total_items') required final int totalItems,
          @JsonKey(name: 'total_pages') required final int totalPages}) =
      _$PaginationModelImpl;

  factory _PaginationModel.fromJson(Map<String, dynamic> json) =
      _$PaginationModelImpl.fromJson;

  @override
  @JsonKey(name: 'current_page')
  int get currentPage;
  @override
  @JsonKey(name: 'per_page')
  int get perPage;
  @override
  @JsonKey(name: 'total_items')
  int get totalItems;
  @override
  @JsonKey(name: 'total_pages')
  int get totalPages;
  @override
  @JsonKey(ignore: true)
  _$$PaginationModelImplCopyWith<_$PaginationModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GetPostDetailsResponseModel _$GetPostDetailsResponseModelFromJson(
    Map<String, dynamic> json) {
  return _GetPostDetailsResponseModel.fromJson(json);
}

/// @nodoc
mixin _$GetPostDetailsResponseModel {
  bool get success => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  PostDetailsModel get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GetPostDetailsResponseModelCopyWith<GetPostDetailsResponseModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetPostDetailsResponseModelCopyWith<$Res> {
  factory $GetPostDetailsResponseModelCopyWith(
          GetPostDetailsResponseModel value,
          $Res Function(GetPostDetailsResponseModel) then) =
      _$GetPostDetailsResponseModelCopyWithImpl<$Res,
          GetPostDetailsResponseModel>;
  @useResult
  $Res call({bool success, String message, PostDetailsModel data});

  $PostDetailsModelCopyWith<$Res> get data;
}

/// @nodoc
class _$GetPostDetailsResponseModelCopyWithImpl<$Res,
        $Val extends GetPostDetailsResponseModel>
    implements $GetPostDetailsResponseModelCopyWith<$Res> {
  _$GetPostDetailsResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
    Object? data = null,
  }) {
    return _then(_value.copyWith(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as PostDetailsModel,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PostDetailsModelCopyWith<$Res> get data {
    return $PostDetailsModelCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GetPostDetailsResponseModelImplCopyWith<$Res>
    implements $GetPostDetailsResponseModelCopyWith<$Res> {
  factory _$$GetPostDetailsResponseModelImplCopyWith(
          _$GetPostDetailsResponseModelImpl value,
          $Res Function(_$GetPostDetailsResponseModelImpl) then) =
      __$$GetPostDetailsResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool success, String message, PostDetailsModel data});

  @override
  $PostDetailsModelCopyWith<$Res> get data;
}

/// @nodoc
class __$$GetPostDetailsResponseModelImplCopyWithImpl<$Res>
    extends _$GetPostDetailsResponseModelCopyWithImpl<$Res,
        _$GetPostDetailsResponseModelImpl>
    implements _$$GetPostDetailsResponseModelImplCopyWith<$Res> {
  __$$GetPostDetailsResponseModelImplCopyWithImpl(
      _$GetPostDetailsResponseModelImpl _value,
      $Res Function(_$GetPostDetailsResponseModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
    Object? data = null,
  }) {
    return _then(_$GetPostDetailsResponseModelImpl(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as PostDetailsModel,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GetPostDetailsResponseModelImpl
    implements _GetPostDetailsResponseModel {
  const _$GetPostDetailsResponseModelImpl(
      {required this.success, required this.message, required this.data});

  factory _$GetPostDetailsResponseModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$GetPostDetailsResponseModelImplFromJson(json);

  @override
  final bool success;
  @override
  final String message;
  @override
  final PostDetailsModel data;

  @override
  String toString() {
    return 'GetPostDetailsResponseModel(success: $success, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetPostDetailsResponseModelImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, success, message, data);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GetPostDetailsResponseModelImplCopyWith<_$GetPostDetailsResponseModelImpl>
      get copyWith => __$$GetPostDetailsResponseModelImplCopyWithImpl<
          _$GetPostDetailsResponseModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetPostDetailsResponseModelImplToJson(
      this,
    );
  }
}

abstract class _GetPostDetailsResponseModel
    implements GetPostDetailsResponseModel {
  const factory _GetPostDetailsResponseModel(
          {required final bool success,
          required final String message,
          required final PostDetailsModel data}) =
      _$GetPostDetailsResponseModelImpl;

  factory _GetPostDetailsResponseModel.fromJson(Map<String, dynamic> json) =
      _$GetPostDetailsResponseModelImpl.fromJson;

  @override
  bool get success;
  @override
  String get message;
  @override
  PostDetailsModel get data;
  @override
  @JsonKey(ignore: true)
  _$$GetPostDetailsResponseModelImplCopyWith<_$GetPostDetailsResponseModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

PostDetailsModel _$PostDetailsModelFromJson(Map<String, dynamic> json) {
  return _PostDetailsModel.fromJson(json);
}

/// @nodoc
mixin _$PostDetailsModel {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  dynamic get imageUrl => throw _privateConstructorUsedError;
  String get author => throw _privateConstructorUsedError;
  List<dynamic> get tags => throw _privateConstructorUsedError;
  int get viewsCount => throw _privateConstructorUsedError;
  String get publishedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PostDetailsModelCopyWith<PostDetailsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostDetailsModelCopyWith<$Res> {
  factory $PostDetailsModelCopyWith(
          PostDetailsModel value, $Res Function(PostDetailsModel) then) =
      _$PostDetailsModelCopyWithImpl<$Res, PostDetailsModel>;
  @useResult
  $Res call(
      {String id,
      String title,
      String content,
      dynamic imageUrl,
      String author,
      List<dynamic> tags,
      int viewsCount,
      String publishedAt});
}

/// @nodoc
class _$PostDetailsModelCopyWithImpl<$Res, $Val extends PostDetailsModel>
    implements $PostDetailsModelCopyWith<$Res> {
  _$PostDetailsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? content = null,
    Object? imageUrl = freezed,
    Object? author = null,
    Object? tags = null,
    Object? viewsCount = null,
    Object? publishedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as dynamic,
      author: null == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      viewsCount: null == viewsCount
          ? _value.viewsCount
          : viewsCount // ignore: cast_nullable_to_non_nullable
              as int,
      publishedAt: null == publishedAt
          ? _value.publishedAt
          : publishedAt // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PostDetailsModelImplCopyWith<$Res>
    implements $PostDetailsModelCopyWith<$Res> {
  factory _$$PostDetailsModelImplCopyWith(_$PostDetailsModelImpl value,
          $Res Function(_$PostDetailsModelImpl) then) =
      __$$PostDetailsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String content,
      dynamic imageUrl,
      String author,
      List<dynamic> tags,
      int viewsCount,
      String publishedAt});
}

/// @nodoc
class __$$PostDetailsModelImplCopyWithImpl<$Res>
    extends _$PostDetailsModelCopyWithImpl<$Res, _$PostDetailsModelImpl>
    implements _$$PostDetailsModelImplCopyWith<$Res> {
  __$$PostDetailsModelImplCopyWithImpl(_$PostDetailsModelImpl _value,
      $Res Function(_$PostDetailsModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? content = null,
    Object? imageUrl = freezed,
    Object? author = null,
    Object? tags = null,
    Object? viewsCount = null,
    Object? publishedAt = null,
  }) {
    return _then(_$PostDetailsModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as dynamic,
      author: null == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      viewsCount: null == viewsCount
          ? _value.viewsCount
          : viewsCount // ignore: cast_nullable_to_non_nullable
              as int,
      publishedAt: null == publishedAt
          ? _value.publishedAt
          : publishedAt // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PostDetailsModelImpl implements _PostDetailsModel {
  const _$PostDetailsModelImpl(
      {required this.id,
      required this.title,
      required this.content,
      required this.imageUrl,
      required this.author,
      required final List<dynamic> tags,
      required this.viewsCount,
      required this.publishedAt})
      : _tags = tags;

  factory _$PostDetailsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PostDetailsModelImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String content;
  @override
  final dynamic imageUrl;
  @override
  final String author;
  final List<dynamic> _tags;
  @override
  List<dynamic> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  final int viewsCount;
  @override
  final String publishedAt;

  @override
  String toString() {
    return 'PostDetailsModel(id: $id, title: $title, content: $content, imageUrl: $imageUrl, author: $author, tags: $tags, viewsCount: $viewsCount, publishedAt: $publishedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostDetailsModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            const DeepCollectionEquality().equals(other.imageUrl, imageUrl) &&
            (identical(other.author, author) || other.author == author) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.viewsCount, viewsCount) ||
                other.viewsCount == viewsCount) &&
            (identical(other.publishedAt, publishedAt) ||
                other.publishedAt == publishedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      content,
      const DeepCollectionEquality().hash(imageUrl),
      author,
      const DeepCollectionEquality().hash(_tags),
      viewsCount,
      publishedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PostDetailsModelImplCopyWith<_$PostDetailsModelImpl> get copyWith =>
      __$$PostDetailsModelImplCopyWithImpl<_$PostDetailsModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PostDetailsModelImplToJson(
      this,
    );
  }
}

abstract class _PostDetailsModel implements PostDetailsModel {
  const factory _PostDetailsModel(
      {required final String id,
      required final String title,
      required final String content,
      required final dynamic imageUrl,
      required final String author,
      required final List<dynamic> tags,
      required final int viewsCount,
      required final String publishedAt}) = _$PostDetailsModelImpl;

  factory _PostDetailsModel.fromJson(Map<String, dynamic> json) =
      _$PostDetailsModelImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get content;
  @override
  dynamic get imageUrl;
  @override
  String get author;
  @override
  List<dynamic> get tags;
  @override
  int get viewsCount;
  @override
  String get publishedAt;
  @override
  @JsonKey(ignore: true)
  _$$PostDetailsModelImplCopyWith<_$PostDetailsModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
