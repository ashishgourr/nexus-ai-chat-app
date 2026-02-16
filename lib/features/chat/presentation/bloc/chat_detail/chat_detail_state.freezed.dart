// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_detail_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ChatDetailState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Message> messages, bool isStreaming) loaded,
    required TResult Function(String message) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Message> messages, bool isStreaming)? loaded,
    TResult? Function(String message)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Message> messages, bool isStreaming)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChatDetailInitial value) initial,
    required TResult Function(ChatDetailLoading value) loading,
    required TResult Function(ChatDetailLoaded value) loaded,
    required TResult Function(ChatDetailError value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChatDetailInitial value)? initial,
    TResult? Function(ChatDetailLoading value)? loading,
    TResult? Function(ChatDetailLoaded value)? loaded,
    TResult? Function(ChatDetailError value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChatDetailInitial value)? initial,
    TResult Function(ChatDetailLoading value)? loading,
    TResult Function(ChatDetailLoaded value)? loaded,
    TResult Function(ChatDetailError value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatDetailStateCopyWith<$Res> {
  factory $ChatDetailStateCopyWith(
    ChatDetailState value,
    $Res Function(ChatDetailState) then,
  ) = _$ChatDetailStateCopyWithImpl<$Res, ChatDetailState>;
}

/// @nodoc
class _$ChatDetailStateCopyWithImpl<$Res, $Val extends ChatDetailState>
    implements $ChatDetailStateCopyWith<$Res> {
  _$ChatDetailStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatDetailState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$ChatDetailInitialImplCopyWith<$Res> {
  factory _$$ChatDetailInitialImplCopyWith(
    _$ChatDetailInitialImpl value,
    $Res Function(_$ChatDetailInitialImpl) then,
  ) = __$$ChatDetailInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ChatDetailInitialImplCopyWithImpl<$Res>
    extends _$ChatDetailStateCopyWithImpl<$Res, _$ChatDetailInitialImpl>
    implements _$$ChatDetailInitialImplCopyWith<$Res> {
  __$$ChatDetailInitialImplCopyWithImpl(
    _$ChatDetailInitialImpl _value,
    $Res Function(_$ChatDetailInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatDetailState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ChatDetailInitialImpl implements ChatDetailInitial {
  const _$ChatDetailInitialImpl();

  @override
  String toString() {
    return 'ChatDetailState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ChatDetailInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Message> messages, bool isStreaming) loaded,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Message> messages, bool isStreaming)? loaded,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Message> messages, bool isStreaming)? loaded,
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
    required TResult Function(ChatDetailInitial value) initial,
    required TResult Function(ChatDetailLoading value) loading,
    required TResult Function(ChatDetailLoaded value) loaded,
    required TResult Function(ChatDetailError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChatDetailInitial value)? initial,
    TResult? Function(ChatDetailLoading value)? loading,
    TResult? Function(ChatDetailLoaded value)? loaded,
    TResult? Function(ChatDetailError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChatDetailInitial value)? initial,
    TResult Function(ChatDetailLoading value)? loading,
    TResult Function(ChatDetailLoaded value)? loaded,
    TResult Function(ChatDetailError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class ChatDetailInitial implements ChatDetailState {
  const factory ChatDetailInitial() = _$ChatDetailInitialImpl;
}

/// @nodoc
abstract class _$$ChatDetailLoadingImplCopyWith<$Res> {
  factory _$$ChatDetailLoadingImplCopyWith(
    _$ChatDetailLoadingImpl value,
    $Res Function(_$ChatDetailLoadingImpl) then,
  ) = __$$ChatDetailLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ChatDetailLoadingImplCopyWithImpl<$Res>
    extends _$ChatDetailStateCopyWithImpl<$Res, _$ChatDetailLoadingImpl>
    implements _$$ChatDetailLoadingImplCopyWith<$Res> {
  __$$ChatDetailLoadingImplCopyWithImpl(
    _$ChatDetailLoadingImpl _value,
    $Res Function(_$ChatDetailLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatDetailState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ChatDetailLoadingImpl implements ChatDetailLoading {
  const _$ChatDetailLoadingImpl();

  @override
  String toString() {
    return 'ChatDetailState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ChatDetailLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Message> messages, bool isStreaming) loaded,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Message> messages, bool isStreaming)? loaded,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Message> messages, bool isStreaming)? loaded,
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
    required TResult Function(ChatDetailInitial value) initial,
    required TResult Function(ChatDetailLoading value) loading,
    required TResult Function(ChatDetailLoaded value) loaded,
    required TResult Function(ChatDetailError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChatDetailInitial value)? initial,
    TResult? Function(ChatDetailLoading value)? loading,
    TResult? Function(ChatDetailLoaded value)? loaded,
    TResult? Function(ChatDetailError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChatDetailInitial value)? initial,
    TResult Function(ChatDetailLoading value)? loading,
    TResult Function(ChatDetailLoaded value)? loaded,
    TResult Function(ChatDetailError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class ChatDetailLoading implements ChatDetailState {
  const factory ChatDetailLoading() = _$ChatDetailLoadingImpl;
}

/// @nodoc
abstract class _$$ChatDetailLoadedImplCopyWith<$Res> {
  factory _$$ChatDetailLoadedImplCopyWith(
    _$ChatDetailLoadedImpl value,
    $Res Function(_$ChatDetailLoadedImpl) then,
  ) = __$$ChatDetailLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Message> messages, bool isStreaming});
}

/// @nodoc
class __$$ChatDetailLoadedImplCopyWithImpl<$Res>
    extends _$ChatDetailStateCopyWithImpl<$Res, _$ChatDetailLoadedImpl>
    implements _$$ChatDetailLoadedImplCopyWith<$Res> {
  __$$ChatDetailLoadedImplCopyWithImpl(
    _$ChatDetailLoadedImpl _value,
    $Res Function(_$ChatDetailLoadedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatDetailState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? messages = null, Object? isStreaming = null}) {
    return _then(
      _$ChatDetailLoadedImpl(
        messages: null == messages
            ? _value._messages
            : messages // ignore: cast_nullable_to_non_nullable
                  as List<Message>,
        isStreaming: null == isStreaming
            ? _value.isStreaming
            : isStreaming // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$ChatDetailLoadedImpl implements ChatDetailLoaded {
  const _$ChatDetailLoadedImpl({
    required final List<Message> messages,
    this.isStreaming = false,
  }) : _messages = messages;

  final List<Message> _messages;
  @override
  List<Message> get messages {
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messages);
  }

  @override
  @JsonKey()
  final bool isStreaming;

  @override
  String toString() {
    return 'ChatDetailState.loaded(messages: $messages, isStreaming: $isStreaming)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatDetailLoadedImpl &&
            const DeepCollectionEquality().equals(other._messages, _messages) &&
            (identical(other.isStreaming, isStreaming) ||
                other.isStreaming == isStreaming));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_messages),
    isStreaming,
  );

  /// Create a copy of ChatDetailState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatDetailLoadedImplCopyWith<_$ChatDetailLoadedImpl> get copyWith =>
      __$$ChatDetailLoadedImplCopyWithImpl<_$ChatDetailLoadedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Message> messages, bool isStreaming) loaded,
    required TResult Function(String message) error,
  }) {
    return loaded(messages, isStreaming);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Message> messages, bool isStreaming)? loaded,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(messages, isStreaming);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Message> messages, bool isStreaming)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(messages, isStreaming);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChatDetailInitial value) initial,
    required TResult Function(ChatDetailLoading value) loading,
    required TResult Function(ChatDetailLoaded value) loaded,
    required TResult Function(ChatDetailError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChatDetailInitial value)? initial,
    TResult? Function(ChatDetailLoading value)? loading,
    TResult? Function(ChatDetailLoaded value)? loaded,
    TResult? Function(ChatDetailError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChatDetailInitial value)? initial,
    TResult Function(ChatDetailLoading value)? loading,
    TResult Function(ChatDetailLoaded value)? loaded,
    TResult Function(ChatDetailError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class ChatDetailLoaded implements ChatDetailState {
  const factory ChatDetailLoaded({
    required final List<Message> messages,
    final bool isStreaming,
  }) = _$ChatDetailLoadedImpl;

  List<Message> get messages;
  bool get isStreaming;

  /// Create a copy of ChatDetailState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatDetailLoadedImplCopyWith<_$ChatDetailLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ChatDetailErrorImplCopyWith<$Res> {
  factory _$$ChatDetailErrorImplCopyWith(
    _$ChatDetailErrorImpl value,
    $Res Function(_$ChatDetailErrorImpl) then,
  ) = __$$ChatDetailErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ChatDetailErrorImplCopyWithImpl<$Res>
    extends _$ChatDetailStateCopyWithImpl<$Res, _$ChatDetailErrorImpl>
    implements _$$ChatDetailErrorImplCopyWith<$Res> {
  __$$ChatDetailErrorImplCopyWithImpl(
    _$ChatDetailErrorImpl _value,
    $Res Function(_$ChatDetailErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatDetailState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$ChatDetailErrorImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ChatDetailErrorImpl implements ChatDetailError {
  const _$ChatDetailErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'ChatDetailState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatDetailErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of ChatDetailState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatDetailErrorImplCopyWith<_$ChatDetailErrorImpl> get copyWith =>
      __$$ChatDetailErrorImplCopyWithImpl<_$ChatDetailErrorImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<Message> messages, bool isStreaming) loaded,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<Message> messages, bool isStreaming)? loaded,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<Message> messages, bool isStreaming)? loaded,
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
    required TResult Function(ChatDetailInitial value) initial,
    required TResult Function(ChatDetailLoading value) loading,
    required TResult Function(ChatDetailLoaded value) loaded,
    required TResult Function(ChatDetailError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChatDetailInitial value)? initial,
    TResult? Function(ChatDetailLoading value)? loading,
    TResult? Function(ChatDetailLoaded value)? loaded,
    TResult? Function(ChatDetailError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChatDetailInitial value)? initial,
    TResult Function(ChatDetailLoading value)? loading,
    TResult Function(ChatDetailLoaded value)? loaded,
    TResult Function(ChatDetailError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class ChatDetailError implements ChatDetailState {
  const factory ChatDetailError(final String message) = _$ChatDetailErrorImpl;

  String get message;

  /// Create a copy of ChatDetailState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatDetailErrorImplCopyWith<_$ChatDetailErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
