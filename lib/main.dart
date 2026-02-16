library;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'config/theme/app_theme.dart';
import 'core/di/injection_container.dart';
import 'core/network/connectivity_cubit.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'pages/splash_page.dart';
import 'features/chat/presentation/bloc/chat_list/chat_list_bloc.dart';
import 'router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dotenv.load(fileName: '.env');
  await initializeDependencies();
  runApp(const MiniAiChatApp());
}

class MiniAiChatApp extends StatelessWidget {
  const MiniAiChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl.get<AuthBloc>()),
        BlocProvider(create: (_) => sl.get<ChatListBloc>()),
        BlocProvider(create: (_) => sl.get<ConnectivityCubit>()),
      ],
      child: MaterialApp.router(
        title: 'Nexus AI',
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        debugShowCheckedModeBanner: false,
        routerConfig: createAppRouter(
          isAuthenticated: () => FirebaseAuth.instance.currentUser != null,
          splashScreenBuilder: () => const SplashPage(),
        ),
      ),
    );
  }
}
