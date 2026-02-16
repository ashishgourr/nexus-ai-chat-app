library;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../network/connectivity_cubit.dart';
import '../network/dio_client.dart';
import '../network/network_info.dart';
import '../network/network_info_impl.dart';
import '../security/encryption_service.dart';
import '../services/ai/ai_mock_service.dart';
import '../../config/constants/api_constants.dart';
import '../services/ai/gemini_service.dart';
import '../services/storage/encrypted_storage_service.dart';
import '../services/storage/local_storage_service.dart';
import '../services/storage/secure_storage_service.dart';
import '../services/storage/storage_manager.dart';
import '../../features/auth/data/datasources/auth_local_datasource.dart';
import '../../features/auth/data/datasources/auth_local_datasource_impl.dart';
import '../../features/auth/data/datasources/auth_remote_datasource.dart';
import '../../features/auth/data/datasources/auth_remote_datasource_impl.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/get_current_user.dart';
import '../../features/auth/domain/usecases/link_anonymous_account.dart';
import '../../features/auth/domain/usecases/sign_in_anonymous.dart';
import '../../features/auth/domain/usecases/sign_in_with_apple.dart';
import '../../features/auth/domain/usecases/sign_in_with_google.dart';
import '../../features/auth/domain/usecases/sign_out.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/chat/data/datasources/ai_datasource.dart';
import '../../features/chat/data/datasources/chat_local_datasource.dart';
import '../../features/chat/data/datasources/chat_local_datasource_impl.dart';
import '../../features/chat/data/datasources/chat_remote_datasource.dart';
import '../../features/chat/data/datasources/chat_remote_datasource_impl.dart';
import '../../features/chat/data/repositories/chat_repository_impl.dart';
import '../../features/chat/domain/repositories/chat_repository.dart';
import '../../features/chat/domain/usecases/add_pending_message.dart';
import '../../features/chat/domain/usecases/create_conversation.dart';
import '../../features/chat/domain/usecases/delete_conversation.dart';
import '../../features/chat/domain/usecases/flush_pending_messages.dart';
import '../../features/chat/domain/usecases/get_cached_conversation_only.dart';
import '../../features/chat/domain/usecases/get_cached_conversations_only.dart';
import '../../features/chat/domain/usecases/get_conversation.dart';
import '../../features/chat/domain/usecases/get_conversations.dart';
import '../../features/chat/domain/usecases/save_assistant_message.dart';
import '../../features/chat/domain/usecases/send_message.dart';
import '../../features/chat/domain/usecases/stream_ai_response.dart';
import '../../features/chat/presentation/bloc/chat_detail/chat_detail_bloc.dart';
import '../../features/chat/presentation/bloc/chat_list/chat_list_bloc.dart';

final GetIt sl = GetIt.instance;

Future<void> initializeDependencies() async {
  final sharedPrefs = await SharedPreferences.getInstance();

  sl.registerLazySingleton<SharedPreferences>(() => sharedPrefs);
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerLazySingleton<Connectivity>(() => Connectivity());
  sl.registerLazySingleton<ConnectivityCubit>(
    () => ConnectivityCubit(sl.get<Connectivity>()),
  );
  sl.registerLazySingleton<GoogleSignIn>(
    () => GoogleSignIn(serverClientId: dotenv.env['GOOGLE_WEB_CLIENT_ID']),
  );

  sl.registerLazySingleton<SecureStorageService>(
    () => SecureStorageServiceImpl(),
  );
  sl.registerLazySingleton<LocalStorageService>(
    () => LocalStorageServiceImpl(sl.get<SharedPreferences>()),
  );
  sl.registerLazySingleton<EncryptionService>(
    () => EncryptionService(sl.get<SecureStorageService>()),
  );
  sl.registerLazySingleton<EncryptedStorageService>(
    () => EncryptedStorageService(
      sl.get<EncryptionService>(),
      sl.get<LocalStorageService>(),
    ),
  );
  sl.registerLazySingleton<StorageManager>(
    () => StorageManager(
      sl.get<LocalStorageService>(),
      sl.get<SecureStorageService>(),
      sl.get<EncryptedStorageService>(),
    ),
  );

  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(sl.get<Connectivity>()),
  );
  sl.registerLazySingleton<DioClient>(() => DioClient(sl.get<Dio>()));

  sl.registerLazySingleton<Dio>(
    () => Dio(BaseOptions(
      connectTimeout: ApiConstants.geminiConnectTimeout,
      receiveTimeout: ApiConstants.geminiReceiveTimeout,
      sendTimeout: ApiConstants.geminiSendTimeout,
    )),
    instanceName: 'gemini',
  );
  sl.registerLazySingleton<GeminiService>(
    () => GeminiService(
      apiKey: dotenv.env['GEMINI_API_KEY'],
      dio: sl.get<Dio>(instanceName: 'gemini'),
    ),
  );
  sl.registerLazySingleton<AIMockService>(() => AIMockService());
  sl.registerLazySingleton<AIDatasource>(
    () => AIDatasource(sl.get<GeminiService>(), sl.get<AIMockService>()),
  );

  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(sl.get<StorageManager>()),
  );
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      sl.get<FirebaseAuth>(),
      sl.get<AuthLocalDataSource>(),
      sl.get<AuthLocalDataSource>(),
      googleSignIn: sl.get<GoogleSignIn>(),
    ),
  );
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      sl.get<AuthRemoteDataSource>(),
      sl.get<FirebaseFirestore>(),
      sl.get<FirebaseFirestore>(),
    ),
  );

  sl.registerLazySingleton<GetCurrentUser>(
    () => GetCurrentUser(sl.get<AuthRepository>()),
  );
  sl.registerLazySingleton<SignInAnonymous>(
    () => SignInAnonymous(sl.get<AuthRepository>()),
  );
  sl.registerLazySingleton<SignInWithGoogle>(
    () => SignInWithGoogle(sl.get<AuthRepository>()),
  );
  sl.registerLazySingleton<SignInWithApple>(
    () => SignInWithApple(sl.get<AuthRepository>()),
  );
  sl.registerLazySingleton<LinkAnonymousAccount>(
    () => LinkAnonymousAccount(sl.get<AuthRepository>()),
  );
  sl.registerLazySingleton<SignOut>(() => SignOut(sl.get<AuthRepository>()));

  sl.registerFactory<AuthBloc>(
    () => AuthBloc(
      getCurrentUser: sl.get<GetCurrentUser>(),
      signInAnonymous: sl.get<SignInAnonymous>(),
      signInWithGoogle: sl.get<SignInWithGoogle>(),
      signInWithApple: sl.get<SignInWithApple>(),
      linkAnonymousAccount: sl.get<LinkAnonymousAccount>(),
      signOut: sl.get<SignOut>(),
    ),
  );

  sl.registerLazySingleton<ChatRemoteDataSource>(
    () => ChatRemoteDataSourceImpl(sl.get<FirebaseFirestore>()),
  );
  sl.registerLazySingleton<ChatLocalDataSource>(
    () => ChatLocalDataSourceImpl(sl.get<StorageManager>()),
  );
  sl.registerLazySingleton<ChatRepository>(
    () => ChatRepositoryImpl(
      sl.get<ChatRemoteDataSource>(),
      sl.get<ChatLocalDataSource>(),
      sl.get<AIDatasource>(),
    ),
  );

  sl.registerLazySingleton<GetCachedConversationsOnly>(
    () => GetCachedConversationsOnly(sl.get<ChatRepository>()),
  );
  sl.registerLazySingleton<GetConversations>(
    () => GetConversations(sl.get<ChatRepository>()),
  );
  sl.registerLazySingleton<GetCachedConversationOnly>(
    () => GetCachedConversationOnly(sl.get<ChatRepository>()),
  );
  sl.registerLazySingleton<CreateConversation>(
    () => CreateConversation(sl.get<ChatRepository>()),
  );
  sl.registerLazySingleton<GetConversation>(
    () => GetConversation(sl.get<ChatRepository>()),
  );
  sl.registerLazySingleton<SendMessage>(
    () => SendMessage(sl.get<ChatRepository>()),
  );
  sl.registerLazySingleton<SaveAssistantMessage>(
    () => SaveAssistantMessage(sl.get<ChatRepository>()),
  );
  sl.registerLazySingleton<StreamAIResponse>(
    () => StreamAIResponse(sl.get<ChatRepository>()),
  );
  sl.registerLazySingleton<DeleteConversation>(
    () => DeleteConversation(sl.get<ChatRepository>()),
  );
  sl.registerLazySingleton<AddPendingMessage>(
    () => AddPendingMessage(sl.get<ChatRepository>()),
  );
  sl.registerLazySingleton<FlushPendingMessages>(
    () => FlushPendingMessages(sl.get<ChatRepository>()),
  );

  sl.registerFactory<ChatListBloc>(
    () => ChatListBloc(
      getCachedConversationsOnly: sl.get<GetCachedConversationsOnly>(),
      getConversations: sl.get<GetConversations>(),
      createConversation: sl.get<CreateConversation>(),
      deleteConversation: sl.get<DeleteConversation>(),
    ),
  );
  sl.registerFactory<ChatDetailBloc>(
    () => ChatDetailBloc(
      getCachedConversationOnly: sl.get<GetCachedConversationOnly>(),
      getConversation: sl.get<GetConversation>(),
      sendMessage: sl.get<SendMessage>(),
      addPendingMessage: sl.get<AddPendingMessage>(),
      streamAIResponse: sl.get<StreamAIResponse>(),
      saveAssistantMessage: sl.get<SaveAssistantMessage>(),
    ),
  );
}
