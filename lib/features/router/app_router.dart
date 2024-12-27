import 'package:auto_route/auto_route.dart';
import 'package:wallet/features/local_auth/domain/repository/local_auth_repository.dart';
import 'package:wallet/features/local_auth/presentation/local_auth_guard/local_auth_guard.dart';
import 'package:flutter/material.dart';
import 'package:wallet/features/local_auth/presentation/local_auth_page/local_auth_page.dart';
import 'package:wallet/features/phrase/domain/repositroy/phrase_repository.dart';
import 'package:wallet/features/phrase/presentation/welcome_guard/welcome_guard.dart';
import 'package:wallet/features/wallet/presentation/generate_phrase_page/generate_phrase_page.dart';
import 'package:wallet/features/wallet/presentation/wallet_page/wallet_page.dart';
import 'package:wallet/features/phrase/presentation/welcome_page/welcome_page.dart';
import 'package:wallet/features/phrase/presentation/generate_phrase_page/phrase_page.dart';
import 'package:wallet/features/phrase/presentation/import_phrase_page/import_phrase_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  final LocalAuthRepository localAuthRepository;
  final PhraseRepository phraseRepository;

  late final LocalAuthGuard authGuard = LocalAuthGuard(localAuthRepository);
  late final WelcomeGuard welcomeGuard = WelcomeGuard(phraseRepository);

  AppRouter(this.localAuthRepository, this.phraseRepository);

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: WelcomeRoute.page),
    AutoRoute(page: PhraseRoute.page),
    AutoRoute(page: ImportPhraseRoute.page),
    AutoRoute(page: LocalAuthRoute.page, initial: true, guards: [welcomeGuard]),
    AutoRoute(page: WalletRoute.page, guards: [authGuard]),
  ];
}