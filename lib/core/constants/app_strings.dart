library;

class AppStrings {
  AppStrings._();

  // ─── Splash ─────────────────────────────────────────────────────────────
  static const String appName = 'Nexus AI';
  static const String splashTagline = 'Your Intelligent Companion';

  // ─── Auth (auth page & buttons) ──────────────────────────────────────────
  static const String welcomeTitle = 'Welcome to\nNexus AI';
  static const String welcomeSubtitle =
      'Your intelligent conversation partner,\navailable 24/7';
  static const String orDivider = 'OR';
  static const String termsAndPrivacy =
      'By continuing, you agree to our Terms of Service\nand Privacy Policy';
  static const String continueAsGuest = 'Continue as Guest';
  static const String continueWithGoogle = 'Continue with Google';
  static const String continueWithApple = 'Continue with Apple';
  static const String instantResponses = 'Instant\nResponses';
  static const String smartAi = 'Smart\nAI';
  static const String alwaysHere = 'Always\nHere';
  static const String signingIn = 'Signing in…';

  // ─── Auth errors (user-facing) ────────────────────────────────────────────
  static const String anonymousSignInNoUser =
      'Anonymous sign-in returned no user';
  static const String guestSignInNotEnabled =
      'Guest sign-in is not enabled. Use Google Sign-In, or enable Anonymous '
      'sign-in in Firebase Console.';
  static const String googleSignInCancelled = 'Google sign-in was cancelled';
  static const String googleSignInCompatibility =
      'Google Sign-In failed (compatibility issue). Try again or use Continue '
      'as Guest.';
  static const String googleSignInNoUser =
      'Google sign-in returned no user';
  static const String googleSignInFailed =
      'Google Sign-In failed. Try "Continue as Guest" or update the app.';
  static const String appleSignInNoUser = 'Apple sign-in returned no user';
  static const String appleSignInSetupRequired =
      'Apple Sign In is implemented but requires an Apple Developer account and '
      'Sign in with Apple capability. See docs/APPLE_SIGNIN_SETUP.md.';
  static const String appleSignInCancelled = 'Apple sign-in was cancelled';
  static const String notAnonymousUser = 'Not an anonymous user';
  static const String linkReturnedNoUser = 'Link returned no user';
  static const String googleAccountAlreadyInUse =
      'This Google account is already used by another account.';
  static const String appleAccountAlreadyInUse =
      'This Apple account is already used by another account.';
  static const String emailAlreadyLinked =
      'This email is already linked to another account.';
  static const String accountAlreadyLinked =
      'This account is already linked to your profile.';
  static const String appleLinkSetupRequired =
      'Apple account linking requires an Apple Developer account and '
      'Sign in with Apple capability. See docs/APPLE_SIGNIN_SETUP.md.';

  // ─── Chat list ───────────────────────────────────────────────────────────
  static const String chats = 'Chats';
  static const String linkToGoogle = 'Link to Google';
  static const String linkToApple = 'Link to Apple';
  static const String signOut = 'Sign out';
  static const String newChat = 'New Chat';
  static const String noMessagesYet = 'No messages yet';
  static const String justNow = 'Just now';
  static const String deleteConversationTitle = 'Delete conversation?';
  static const String deleteConversationContent =
      'This conversation will be permanently deleted.';
  static const String cancel = 'Cancel';
  static const String delete = 'Delete';

  // ─── Chat detail ────────────────────────────────────────────────────────
  static const String responseFailed = 'Response failed';
  static const String apiQuotaExceeded =
      "AI quota reached. Try again in a few minutes, or check your API plan.";
  static const String rateLimitMessage =
      'Please wait a moment before sending again.';
  static const String savedForWhenBackOnline =
      "Saved for when you're back online.";
  static const String loadingMessages = 'Loading messages';
  static const String aiAssistant = 'AI Assistant';
  static const String aiAssistantSubtitle = 'Always here to help';
  static const String howCanIHelp = 'How can I help you today?';
  static const String sendMessageToStart =
      'Send a message to start the conversation';
  static const String askMeAnything = 'Ask me anything...';
  static const String sendMessage = 'Send message';
  static const String sendDisabledWhileAiResponding =
      'Send disabled while AI is responding';

  // ─── Empty chat state ───────────────────────────────────────────────────
  static const String noConversationsYet = 'No conversations yet';
  static const String startConversationSubtitle =
      'Start a conversation with AI to get instant\nanswers, ideas, and assistance';
  static const String startNewChat = 'Start New Chat';
  static const String getIdeas = 'Get ideas';
  static const String writeContent = 'Write content';
  static const String askQuestions = 'Ask questions';
  static const String beCreative = 'Be creative';

  // ─── Network / connectivity ──────────────────────────────────────────────
  static const String backOnline = 'Back online';
  static const String youreOffline = "You're offline";
  static const String noInternetConnection = 'No internet connection';
  static const String offlineCheckConnection =
      'You appear to be offline. Check your connection and try again.';
}
