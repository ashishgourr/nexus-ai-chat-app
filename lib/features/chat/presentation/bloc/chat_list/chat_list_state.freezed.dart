// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ChatListState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<Conversation> conversations,
      String? createdId,
    )
    loaded,
    required TResult Function(String message) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Conversation> conversations, String? createdId)?
    loaded,
    TResult? Function(String message)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Conversation> conversations, String? createdId)?
    loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChatListInitial value) initial,
    required TResult Function(ChatListLoading value) loading,
    required TResult Function(ChatListLoaded value) loaded,
    required TResult Function(ChatListError value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChatListInitial value)? initial,
    TResult? Function(ChatListLoading value)? loading,
    TResult? Function(ChatListLoaded value)? loaded,
    TResult? Function(ChatListError value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChatListInitial value)? initial,
    TResult Function(ChatListLoading value)? loading,
    TResult Function(ChatListLoaded value)? loaded,
    TResult Function(ChatListError value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatListStateCopyWith<$Res> {
  factory $ChatListStateCopyWith(
    ChatListState value,
    $Res Function(ChatListState) then,
  ) = _$ChatListStateCopyWithImpl<$Res, ChatListState>;
}

/// @nodoc
class _$ChatListStateCopyWithImpl<$Res, $Val extends ChatListState>
    implements $ChatListStateCopyWith<$Res> {
  _$ChatListStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatListState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$ChatListInitialImplCopyWith<$Res> {
  factory _$$ChatListInitialImplCopyWith(
    _$ChatListInitialImpl value,
    $Res Function(_$ChatListInitialImpl) then,
  ) = __$$ChatListInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ChatListInitialImplCopyWithImpl<$Res>
    extends _$ChatListStateCopyWithImpl<$Res, _$ChatListInitialImpl>
    implements _$$ChatListInitialImplCopyWith<$Res> {
  __$$ChatListInitialImplCopyWithImpl(
    _$ChatListInitialImpl _value,
    $Res Function(_$ChatListInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatListState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ChatListInitialImpl implements ChatListInitial {
  const _$ChatListInitialImpl();

  @override
  String toString() {
    return 'ChatListState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ChatListInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<Conversation> conversations,
      String? createdId,
    )
    loaded,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Conversation> conversations, String? createdId)?
    loaded,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Conversation> conversations, String? createdId)?
    loaded,
    TResult Function(String message)? error,
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
    required TResult Function(ChatListInitial value) initial,
    required TResult Function(ChatListLoading value) loading,
    required TResult Function(ChatListLoaded value) loaded,
    required TResult Function(ChatListError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChatListInitial value)? initial,
    TResult? Function(ChatListLoading value)? loading,
    TResult? Function(ChatListLoaded value)? loaded,
    TResult? Function(ChatListError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChatListInitial value)? initial,
    TResult Function(ChatListLoading value)? loading,
    TResult Function(ChatListLoaded value)? loaded,
    TResult Function(ChatListError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class ChatListInitial implements ChatListState {
  const factory ChatListInitial() = _$ChatListInitialImpl;
}

/// @nodoc
abstract class _$$ChatListLoadingImplCopyWith<$Res> {
  factory _$$ChatListLoadingImplCopyWith(
    _$ChatListLoadingImpl value,
    $Res Function(_$ChatListLoadingImpl) then,
  ) = __$$ChatListLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ChatListLoadingImplCopyWithImpl<$Res>
    extends _$ChatListStateCopyWithImpl<$Res, _$ChatListLoadingImpl>
    implements _$$ChatListLoadingImplCopyWith<$Res> {
  __$$ChatListLoadingImplCopyWithImpl(
    _$ChatListLoadingImpl _value,
    $Res Function(_$ChatListLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatListState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ChatListLoadingImpl implements ChatListLoading {
  const _$ChatListLoadingImpl();

  @override
  String toString() {
    return 'ChatListState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ChatListLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<Conversation> conversations,
      String? createdId,
    )
    loaded,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Conversation> conversations, String? createdId)?
    loaded,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Conversation> conversations, String? createdId)?
    loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChatListInitial value) initial,
    required TResult Function(ChatListLoading value) loading,
    required TResult Function(ChatListLoaded value) loaded,
    required TResult Function(ChatListError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChatListInitial value)? initial,
    TResult? Function(ChatListLoading value)? loading,
    TResult? Function(ChatListLoaded value)? loaded,
    TResult? Function(ChatListError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChatListInitial value)? initial,
    TResult Function(ChatListLoading value)? loading,
    TResult Function(ChatListLoaded value)? loaded,
    TResult Function(ChatListError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class ChatListLoading implements ChatListState {
  const factory ChatListLoading() = _$ChatListLoadingImpl;
}

/// @nodoc
abstract class _$$ChatListLoadedImplCopyWith<$Res> {
  factory _$$ChatListLoadedImplCopyWith(
    _$ChatListLoadedImpl value,
    $Res Function(_$ChatListLoadedImpl) then,
  ) = __$$ChatListLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Conversation> conversations, String? createdId});
}

/// @nodoc
class __$$ChatListLoadedImplCopyWithImpl<$Res>
    extends _$ChatListStateCopyWithImpl<$Res, _$ChatListLoadedImpl>
    implements _$$ChatListLoadedImplCopyWith<$Res> {
  __$$ChatListLoadedImplCopyWithImpl(
    _$ChatListLoadedImpl _value,
    $Res Function(_$ChatListLoadedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? conversations = null, Object? createdId = freezed}) {
    return _then(
      _$ChatListLoadedImpl(
        null == conversations
            ? _value._conversations
            : conversations // ignore: cast_nullable_to_non_nullable
                  as List<Conversation>,
        createdId: freezed == createdId
            ? _value.createdId
            : createdId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$ChatListLoadedImpl implements ChatListLoaded {
  const _$ChatListLoadedImpl(
    final List<Conversation> conversations, {
    this.createdId,
  }) : _conversations = conversations;

  final List<Conversation> _conversations;
  @override
  List<Conversation> get conversations {
    if (_conversations is EqualUnmodifiableListView) return _conversations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_conversations);
  }

  @override
  final String? createdId;

  @override
  String toString() {
    return 'ChatListState.loaded(conversations: $conversations, createdId: $createdId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatListLoadedImpl &&
            const DeepCollectionEquality().equals(
              other._conversations,
              _conversations,
            ) &&
            (identical(other.createdId, createdId) ||
                other.createdId == createdId));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_conversations),
    createdId,
  );

  /// Create a copy of ChatListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatListLoadedImplCopyWith<_$ChatListLoadedImpl> get copyWith =>
      __$$ChatListLoadedImplCopyWithImpl<_$ChatListLoadedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<Conversation> conversations,
      String? createdId,
    )
    loaded,
    required TResult Function(String message) error,
  }) {
    return loaded(conversations, createdId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Conversation> conversations, String? createdId)?
    loaded,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(conversations, createdId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Conversation> conversations, String? createdId)?
    loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(conversations, createdId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChatListInitial value) initial,
    required TResult Function(ChatListLoading value) loading,
    required TResult Function(ChatListLoaded value) loaded,
    required TResult Function(ChatListError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChatListInitial value)? initial,
    TResult? Function(ChatListLoading value)? loading,
    TResult? Function(ChatListLoaded value)? loaded,
    TResult? Function(ChatListError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChatListInitial value)? initial,
    TResult Function(ChatListLoading value)? loading,
    TResult Function(ChatListLoaded value)? loaded,
    TResult Function(ChatListError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class ChatListLoaded implements ChatListState {
  const factory ChatListLoaded(
    final List<Conversation> conversations, {
    final String? createdId,
  }) = _$ChatListLoadedImpl;

  List<Conversation> get conversations;
  String? get createdId;

  /// Create a copy of ChatListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatListLoadedImplCopyWith<_$ChatListLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ChatListErrorImplCopyWith<$Res> {
  factory _$$ChatListErrorImplCopyWith(
    _$ChatListErrorImpl value,
    $Res Function(_$ChatListErrorImpl) then,
  ) = __$$ChatListErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ChatListErrorImplCopyWithImpl<$Res>
    extends _$ChatListStateCopyWithImpl<$Res, _$ChatListErrorImpl>
    implements _$$ChatListErrorImplCopyWith<$Res> {
  __$$ChatListErrorImplCopyWithImpl(
    _$ChatListErrorImpl _value,
    $Res Function(_$ChatListErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$ChatListErrorImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ChatListErrorImpl implements ChatListError {
  const _$ChatListErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'ChatListState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatListErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of ChatListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatListErrorImplCopyWith<_$ChatListErrorImpl> get copyWith =>
      __$$ChatListErrorImplCopyWithImpl<_$ChatListErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<Conversation> conversations,
      String? createdId,
    )
    loaded,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Conversation> conversations, String? createdId)?
    loaded,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Conversation> conversations, String? createdId)?
    loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChatListInitial value) initial,
    required TResult Function(ChatListLoading value) loading,
    required TResult Function(ChatListLoaded value) loaded,
    required TResult Function(ChatListError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChatListInitial value)? initial,
    TResult? Function(ChatListLoading value)? loading,
    TResult? Function(ChatListLoaded value)? loaded,
    TResult? Function(ChatListError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChatListInitial value)? initial,
    TResult Function(ChatListLoading value)? loading,
    TResult Function(ChatListLoaded value)? loaded,
    TResult Function(ChatListError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class ChatListError implements ChatListState {
  const factory ChatListError(final String message) = _$ChatListErrorImpl;

  String get message;

  /// Create a copy of ChatListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatListErrorImplCopyWith<_$ChatListErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
