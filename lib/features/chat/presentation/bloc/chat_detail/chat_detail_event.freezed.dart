// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_detail_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ChatDetailEvent {
  String get userId => throw _privateConstructorUsedError;
  String get conversationId => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userId, String conversationId)
    loadRequested,
    required TResult Function(
      String userId,
      String conversationId,
      Message message,
    )
    sendMessage,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userId, String conversationId)? loadRequested,
    TResult? Function(String userId, String conversationId, Message message)?
    sendMessage,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userId, String conversationId)? loadRequested,
    TResult Function(String userId, String conversationId, Message message)?
    sendMessage,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChatDetailLoadRequested value) loadRequested,
    required TResult Function(ChatDetailSendMessage value) sendMessage,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChatDetailLoadRequested value)? loadRequested,
    TResult? Function(ChatDetailSendMessage value)? sendMessage,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChatDetailLoadRequested value)? loadRequested,
    TResult Function(ChatDetailSendMessage value)? sendMessage,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;

  /// Create a copy of ChatDetailEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatDetailEventCopyWith<ChatDetailEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatDetailEventCopyWith<$Res> {
  factory $ChatDetailEventCopyWith(
    ChatDetailEvent value,
    $Res Function(ChatDetailEvent) then,
  ) = _$ChatDetailEventCopyWithImpl<$Res, ChatDetailEvent>;
  @useResult
  $Res call({String userId, String conversationId});
}

/// @nodoc
class _$ChatDetailEventCopyWithImpl<$Res, $Val extends ChatDetailEvent>
    implements $ChatDetailEventCopyWith<$Res> {
  _$ChatDetailEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatDetailEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? userId = null, Object? conversationId = null}) {
    return _then(
      _value.copyWith(
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            conversationId: null == conversationId
                ? _value.conversationId
                : conversationId // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ChatDetailLoadRequestedImplCopyWith<$Res>
    implements $ChatDetailEventCopyWith<$Res> {
  factory _$$ChatDetailLoadRequestedImplCopyWith(
    _$ChatDetailLoadRequestedImpl value,
    $Res Function(_$ChatDetailLoadRequestedImpl) then,
  ) = __$$ChatDetailLoadRequestedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String userId, String conversationId});
}

/// @nodoc
class __$$ChatDetailLoadRequestedImplCopyWithImpl<$Res>
    extends _$ChatDetailEventCopyWithImpl<$Res, _$ChatDetailLoadRequestedImpl>
    implements _$$ChatDetailLoadRequestedImplCopyWith<$Res> {
  __$$ChatDetailLoadRequestedImplCopyWithImpl(
    _$ChatDetailLoadRequestedImpl _value,
    $Res Function(_$ChatDetailLoadRequestedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatDetailEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? userId = null, Object? conversationId = null}) {
    return _then(
      _$ChatDetailLoadRequestedImpl(
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        conversationId: null == conversationId
            ? _value.conversationId
            : conversationId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ChatDetailLoadRequestedImpl implements ChatDetailLoadRequested {
  const _$ChatDetailLoadRequestedImpl({
    required this.userId,
    required this.conversationId,
  });

  @override
  final String userId;
  @override
  final String conversationId;

  @override
  String toString() {
    return 'ChatDetailEvent.loadRequested(userId: $userId, conversationId: $conversationId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatDetailLoadRequestedImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userId, conversationId);

  /// Create a copy of ChatDetailEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatDetailLoadRequestedImplCopyWith<_$ChatDetailLoadRequestedImpl>
  get copyWith =>
      __$$ChatDetailLoadRequestedImplCopyWithImpl<
        _$ChatDetailLoadRequestedImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userId, String conversationId)
    loadRequested,
    required TResult Function(
      String userId,
      String conversationId,
      Message message,
    )
    sendMessage,
  }) {
    return loadRequested(userId, conversationId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userId, String conversationId)? loadRequested,
    TResult? Function(String userId, String conversationId, Message message)?
    sendMessage,
  }) {
    return loadRequested?.call(userId, conversationId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userId, String conversationId)? loadRequested,
    TResult Function(String userId, String conversationId, Message message)?
    sendMessage,
    required TResult orElse(),
  }) {
    if (loadRequested != null) {
      return loadRequested(userId, conversationId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChatDetailLoadRequested value) loadRequested,
    required TResult Function(ChatDetailSendMessage value) sendMessage,
  }) {
    return loadRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChatDetailLoadRequested value)? loadRequested,
    TResult? Function(ChatDetailSendMessage value)? sendMessage,
  }) {
    return loadRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChatDetailLoadRequested value)? loadRequested,
    TResult Function(ChatDetailSendMessage value)? sendMessage,
    required TResult orElse(),
  }) {
    if (loadRequested != null) {
      return loadRequested(this);
    }
    return orElse();
  }
}

abstract class ChatDetailLoadRequested implements ChatDetailEvent {
  const factory ChatDetailLoadRequested({
    required final String userId,
    required final String conversationId,
  }) = _$ChatDetailLoadRequestedImpl;

  @override
  String get userId;
  @override
  String get conversationId;

  /// Create a copy of ChatDetailEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatDetailLoadRequestedImplCopyWith<_$ChatDetailLoadRequestedImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ChatDetailSendMessageImplCopyWith<$Res>
    implements $ChatDetailEventCopyWith<$Res> {
  factory _$$ChatDetailSendMessageImplCopyWith(
    _$ChatDetailSendMessageImpl value,
    $Res Function(_$ChatDetailSendMessageImpl) then,
  ) = __$$ChatDetailSendMessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String userId, String conversationId, Message message});

  $MessageCopyWith<$Res> get message;
}

/// @nodoc
class __$$ChatDetailSendMessageImplCopyWithImpl<$Res>
    extends _$ChatDetailEventCopyWithImpl<$Res, _$ChatDetailSendMessageImpl>
    implements _$$ChatDetailSendMessageImplCopyWith<$Res> {
  __$$ChatDetailSendMessageImplCopyWithImpl(
    _$ChatDetailSendMessageImpl _value,
    $Res Function(_$ChatDetailSendMessageImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatDetailEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? conversationId = null,
    Object? message = null,
  }) {
    return _then(
      _$ChatDetailSendMessageImpl(
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        conversationId: null == conversationId
            ? _value.conversationId
            : conversationId // ignore: cast_nullable_to_non_nullable
                  as String,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as Message,
      ),
    );
  }

  /// Create a copy of ChatDetailEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MessageCopyWith<$Res> get message {
    return $MessageCopyWith<$Res>(_value.message, (value) {
      return _then(_value.copyWith(message: value));
    });
  }
}

/// @nodoc

class _$ChatDetailSendMessageImpl implements ChatDetailSendMessage {
  const _$ChatDetailSendMessageImpl({
    required this.userId,
    required this.conversationId,
    required this.message,
  });

  @override
  final String userId;
  @override
  final String conversationId;
  @override
  final Message message;

  @override
  String toString() {
    return 'ChatDetailEvent.sendMessage(userId: $userId, conversationId: $conversationId, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatDetailSendMessageImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userId, conversationId, message);

  /// Create a copy of ChatDetailEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatDetailSendMessageImplCopyWith<_$ChatDetailSendMessageImpl>
  get copyWith =>
      __$$ChatDetailSendMessageImplCopyWithImpl<_$ChatDetailSendMessageImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String userId, String conversationId)
    loadRequested,
    required TResult Function(
      String userId,
      String conversationId,
      Message message,
    )
    sendMessage,
  }) {
    return sendMessage(userId, conversationId, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String userId, String conversationId)? loadRequested,
    TResult? Function(String userId, String conversationId, Message message)?
    sendMessage,
  }) {
    return sendMessage?.call(userId, conversationId, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String userId, String conversationId)? loadRequested,
    TResult Function(String userId, String conversationId, Message message)?
    sendMessage,
    required TResult orElse(),
  }) {
    if (sendMessage != null) {
      return sendMessage(userId, conversationId, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ChatDetailLoadRequested value) loadRequested,
    required TResult Function(ChatDetailSendMessage value) sendMessage,
  }) {
    return sendMessage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ChatDetailLoadRequested value)? loadRequested,
    TResult? Function(ChatDetailSendMessage value)? sendMessage,
  }) {
    return sendMessage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ChatDetailLoadRequested value)? loadRequested,
    TResult Function(ChatDetailSendMessage value)? sendMessage,
    required TResult orElse(),
  }) {
    if (sendMessage != null) {
      return sendMessage(this);
    }
    return orElse();
  }
}

abstract class ChatDetailSendMessage implements ChatDetailEvent {
  const factory ChatDetailSendMessage({
    required final String userId,
    required final String conversationId,
    required final Message message,
  }) = _$ChatDetailSendMessageImpl;

  @override
  String get userId;
  @override
  String get conversationId;
  Message get message;

  /// Create a copy of ChatDetailEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatDetailSendMessageImplCopyWith<_$ChatDetailSendMessageImpl>
  get copyWith => throw _privateConstructorUsedError;
}
