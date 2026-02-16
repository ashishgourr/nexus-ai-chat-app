// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_list_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ChatListEvent {
  String get userId => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userId) loadRequested,
    required TResult Function(String userId) createConversationRequested,
    required TResult Function(String userId, String conversationId)
    deleteConversationRequested,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userId)? loadRequested,
    TResult? Function(String userId)? createConversationRequested,
    TResult? Function(String userId, String conversationId)?
    deleteConversationRequested,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userId)? loadRequested,
    TResult Function(String userId)? createConversationRequested,
    TResult Function(String userId, String conversationId)?
    deleteConversationRequested,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChatListLoadRequested value) loadRequested,
    required TResult Function(ChatListCreateConversationRequested value)
    createConversationRequested,
    required TResult Function(ChatListDeleteConversationRequested value)
    deleteConversationRequested,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChatListLoadRequested value)? loadRequested,
    TResult? Function(ChatListCreateConversationRequested value)?
    createConversationRequested,
    TResult? Function(ChatListDeleteConversationRequested value)?
    deleteConversationRequested,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChatListLoadRequested value)? loadRequested,
    TResult Function(ChatListCreateConversationRequested value)?
    createConversationRequested,
    TResult Function(ChatListDeleteConversationRequested value)?
    deleteConversationRequested,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;

  /// Create a copy of ChatListEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatListEventCopyWith<ChatListEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatListEventCopyWith<$Res> {
  factory $ChatListEventCopyWith(
    ChatListEvent value,
    $Res Function(ChatListEvent) then,
  ) = _$ChatListEventCopyWithImpl<$Res, ChatListEvent>;
  @useResult
  $Res call({String userId});
}

/// @nodoc
class _$ChatListEventCopyWithImpl<$Res, $Val extends ChatListEvent>
    implements $ChatListEventCopyWith<$Res> {
  _$ChatListEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatListEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? userId = null}) {
    return _then(
      _value.copyWith(
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ChatListLoadRequestedImplCopyWith<$Res>
    implements $ChatListEventCopyWith<$Res> {
  factory _$$ChatListLoadRequestedImplCopyWith(
    _$ChatListLoadRequestedImpl value,
    $Res Function(_$ChatListLoadRequestedImpl) then,
  ) = __$$ChatListLoadRequestedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String userId});
}

/// @nodoc
class __$$ChatListLoadRequestedImplCopyWithImpl<$Res>
    extends _$ChatListEventCopyWithImpl<$Res, _$ChatListLoadRequestedImpl>
    implements _$$ChatListLoadRequestedImplCopyWith<$Res> {
  __$$ChatListLoadRequestedImplCopyWithImpl(
    _$ChatListLoadRequestedImpl _value,
    $Res Function(_$ChatListLoadRequestedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatListEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? userId = null}) {
    return _then(
      _$ChatListLoadRequestedImpl(
        null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ChatListLoadRequestedImpl implements ChatListLoadRequested {
  const _$ChatListLoadRequestedImpl(this.userId);

  @override
  final String userId;

  @override
  String toString() {
    return 'ChatListEvent.loadRequested(userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatListLoadRequestedImpl &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userId);

  /// Create a copy of ChatListEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatListLoadRequestedImplCopyWith<_$ChatListLoadRequestedImpl>
  get copyWith =>
      __$$ChatListLoadRequestedImplCopyWithImpl<_$ChatListLoadRequestedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userId) loadRequested,
    required TResult Function(String userId) createConversationRequested,
    required TResult Function(String userId, String conversationId)
    deleteConversationRequested,
  }) {
    return loadRequested(userId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userId)? loadRequested,
    TResult? Function(String userId)? createConversationRequested,
    TResult? Function(String userId, String conversationId)?
    deleteConversationRequested,
  }) {
    return loadRequested?.call(userId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userId)? loadRequested,
    TResult Function(String userId)? createConversationRequested,
    TResult Function(String userId, String conversationId)?
    deleteConversationRequested,
    required TResult orElse(),
  }) {
    if (loadRequested != null) {
      return loadRequested(userId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChatListLoadRequested value) loadRequested,
    required TResult Function(ChatListCreateConversationRequested value)
    createConversationRequested,
    required TResult Function(ChatListDeleteConversationRequested value)
    deleteConversationRequested,
  }) {
    return loadRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChatListLoadRequested value)? loadRequested,
    TResult? Function(ChatListCreateConversationRequested value)?
    createConversationRequested,
    TResult? Function(ChatListDeleteConversationRequested value)?
    deleteConversationRequested,
  }) {
    return loadRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChatListLoadRequested value)? loadRequested,
    TResult Function(ChatListCreateConversationRequested value)?
    createConversationRequested,
    TResult Function(ChatListDeleteConversationRequested value)?
    deleteConversationRequested,
    required TResult orElse(),
  }) {
    if (loadRequested != null) {
      return loadRequested(this);
    }
    return orElse();
  }
}

abstract class ChatListLoadRequested implements ChatListEvent {
  const factory ChatListLoadRequested(final String userId) =
      _$ChatListLoadRequestedImpl;

  @override
  String get userId;

  /// Create a copy of ChatListEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatListLoadRequestedImplCopyWith<_$ChatListLoadRequestedImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ChatListCreateConversationRequestedImplCopyWith<$Res>
    implements $ChatListEventCopyWith<$Res> {
  factory _$$ChatListCreateConversationRequestedImplCopyWith(
    _$ChatListCreateConversationRequestedImpl value,
    $Res Function(_$ChatListCreateConversationRequestedImpl) then,
  ) = __$$ChatListCreateConversationRequestedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String userId});
}

/// @nodoc
class __$$ChatListCreateConversationRequestedImplCopyWithImpl<$Res>
    extends
        _$ChatListEventCopyWithImpl<
          $Res,
          _$ChatListCreateConversationRequestedImpl
        >
    implements _$$ChatListCreateConversationRequestedImplCopyWith<$Res> {
  __$$ChatListCreateConversationRequestedImplCopyWithImpl(
    _$ChatListCreateConversationRequestedImpl _value,
    $Res Function(_$ChatListCreateConversationRequestedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatListEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? userId = null}) {
    return _then(
      _$ChatListCreateConversationRequestedImpl(
        null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ChatListCreateConversationRequestedImpl
    implements ChatListCreateConversationRequested {
  const _$ChatListCreateConversationRequestedImpl(this.userId);

  @override
  final String userId;

  @override
  String toString() {
    return 'ChatListEvent.createConversationRequested(userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatListCreateConversationRequestedImpl &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userId);

  /// Create a copy of ChatListEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatListCreateConversationRequestedImplCopyWith<
    _$ChatListCreateConversationRequestedImpl
  >
  get copyWith =>
      __$$ChatListCreateConversationRequestedImplCopyWithImpl<
        _$ChatListCreateConversationRequestedImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userId) loadRequested,
    required TResult Function(String userId) createConversationRequested,
    required TResult Function(String userId, String conversationId)
    deleteConversationRequested,
  }) {
    return createConversationRequested(userId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userId)? loadRequested,
    TResult? Function(String userId)? createConversationRequested,
    TResult? Function(String userId, String conversationId)?
    deleteConversationRequested,
  }) {
    return createConversationRequested?.call(userId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userId)? loadRequested,
    TResult Function(String userId)? createConversationRequested,
    TResult Function(String userId, String conversationId)?
    deleteConversationRequested,
    required TResult orElse(),
  }) {
    if (createConversationRequested != null) {
      return createConversationRequested(userId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChatListLoadRequested value) loadRequested,
    required TResult Function(ChatListCreateConversationRequested value)
    createConversationRequested,
    required TResult Function(ChatListDeleteConversationRequested value)
    deleteConversationRequested,
  }) {
    return createConversationRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChatListLoadRequested value)? loadRequested,
    TResult? Function(ChatListCreateConversationRequested value)?
    createConversationRequested,
    TResult? Function(ChatListDeleteConversationRequested value)?
    deleteConversationRequested,
  }) {
    return createConversationRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChatListLoadRequested value)? loadRequested,
    TResult Function(ChatListCreateConversationRequested value)?
    createConversationRequested,
    TResult Function(ChatListDeleteConversationRequested value)?
    deleteConversationRequested,
    required TResult orElse(),
  }) {
    if (createConversationRequested != null) {
      return createConversationRequested(this);
    }
    return orElse();
  }
}

abstract class ChatListCreateConversationRequested implements ChatListEvent {
  const factory ChatListCreateConversationRequested(final String userId) =
      _$ChatListCreateConversationRequestedImpl;

  @override
  String get userId;

  /// Create a copy of ChatListEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatListCreateConversationRequestedImplCopyWith<
    _$ChatListCreateConversationRequestedImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ChatListDeleteConversationRequestedImplCopyWith<$Res>
    implements $ChatListEventCopyWith<$Res> {
  factory _$$ChatListDeleteConversationRequestedImplCopyWith(
    _$ChatListDeleteConversationRequestedImpl value,
    $Res Function(_$ChatListDeleteConversationRequestedImpl) then,
  ) = __$$ChatListDeleteConversationRequestedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String userId, String conversationId});
}

/// @nodoc
class __$$ChatListDeleteConversationRequestedImplCopyWithImpl<$Res>
    extends
        _$ChatListEventCopyWithImpl<
          $Res,
          _$ChatListDeleteConversationRequestedImpl
        >
    implements _$$ChatListDeleteConversationRequestedImplCopyWith<$Res> {
  __$$ChatListDeleteConversationRequestedImplCopyWithImpl(
    _$ChatListDeleteConversationRequestedImpl _value,
    $Res Function(_$ChatListDeleteConversationRequestedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatListEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? userId = null, Object? conversationId = null}) {
    return _then(
      _$ChatListDeleteConversationRequestedImpl(
        null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        null == conversationId
            ? _value.conversationId
            : conversationId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ChatListDeleteConversationRequestedImpl
    implements ChatListDeleteConversationRequested {
  const _$ChatListDeleteConversationRequestedImpl(
    this.userId,
    this.conversationId,
  );

  @override
  final String userId;
  @override
  final String conversationId;

  @override
  String toString() {
    return 'ChatListEvent.deleteConversationRequested(userId: $userId, conversationId: $conversationId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatListDeleteConversationRequestedImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userId, conversationId);

  /// Create a copy of ChatListEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatListDeleteConversationRequestedImplCopyWith<
    _$ChatListDeleteConversationRequestedImpl
  >
  get copyWith =>
      __$$ChatListDeleteConversationRequestedImplCopyWithImpl<
        _$ChatListDeleteConversationRequestedImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userId) loadRequested,
    required TResult Function(String userId) createConversationRequested,
    required TResult Function(String userId, String conversationId)
    deleteConversationRequested,
  }) {
    return deleteConversationRequested(userId, conversationId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userId)? loadRequested,
    TResult? Function(String userId)? createConversationRequested,
    TResult? Function(String userId, String conversationId)?
    deleteConversationRequested,
  }) {
    return deleteConversationRequested?.call(userId, conversationId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userId)? loadRequested,
    TResult Function(String userId)? createConversationRequested,
    TResult Function(String userId, String conversationId)?
    deleteConversationRequested,
    required TResult orElse(),
  }) {
    if (deleteConversationRequested != null) {
      return deleteConversationRequested(userId, conversationId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChatListLoadRequested value) loadRequested,
    required TResult Function(ChatListCreateConversationRequested value)
    createConversationRequested,
    required TResult Function(ChatListDeleteConversationRequested value)
    deleteConversationRequested,
  }) {
    return deleteConversationRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChatListLoadRequested value)? loadRequested,
    TResult? Function(ChatListCreateConversationRequested value)?
    createConversationRequested,
    TResult? Function(ChatListDeleteConversationRequested value)?
    deleteConversationRequested,
  }) {
    return deleteConversationRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChatListLoadRequested value)? loadRequested,
    TResult Function(ChatListCreateConversationRequested value)?
    createConversationRequested,
    TResult Function(ChatListDeleteConversationRequested value)?
    deleteConversationRequested,
    required TResult orElse(),
  }) {
    if (deleteConversationRequested != null) {
      return deleteConversationRequested(this);
    }
    return orElse();
  }
}

abstract class ChatListDeleteConversationRequested implements ChatListEvent {
  const factory ChatListDeleteConversationRequested(
    final String userId,
    final String conversationId,
  ) = _$ChatListDeleteConversationRequestedImpl;

  @override
  String get userId;
  String get conversationId;

  /// Create a copy of ChatListEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatListDeleteConversationRequestedImplCopyWith<
    _$ChatListDeleteConversationRequestedImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}
