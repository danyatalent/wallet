import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallet/features/local_auth/domain/repository/local_auth_repository.dart';
import 'package:wallet/features/phrase/domain/repositroy/phrase_repository.dart';
import 'package:wallet/features/router/app_router.dart';
import 'package:wallet/features/wallet/domain/repository/wallet_repository.dart';

part 'app_theme.dart';

class App extends StatelessWidget {
  final PhraseRepository phraseRepository;
  final LocalAuthRepository localAuthRepository;
  final WalletRepository walletRepository;


  const App(
  {super.key,
    required this.phraseRepository,
  required this.localAuthRepository,
  required this.walletRepository});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider.value(
              value: localAuthRepository
          ),
          RepositoryProvider.value(
              value: walletRepository
          ),
          RepositoryProvider.value(
              value: phraseRepository,
          )
        ],
        child: AppView(
          appRouter: AppRouter(localAuthRepository, phraseRepository),
        )
    );
  }
}

class AppView extends StatelessWidget {
  final AppRouter appRouter;

  const AppView({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        theme: getAppTheme(),
      routerConfig: appRouter.config(),
      );
  }
}