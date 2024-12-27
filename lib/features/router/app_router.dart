import 'package:auto_route/auto_route.dart';
import 'package:wallet/features/local_auth/domain/repository/local_auth_repository.dart';
import 'package:wallet/features/local_auth/presentation/local_auth_guard/local_auth_guard.dart';
import 'package:flutter/material.dart';
import 'package:wallet/features/local_auth/presentation/local_auth_page/local_auth_page.dart';
import 'package:wallet/features/wallet/presentation/generate_phrase_page/generate_phrase_page.dart';
import 'package:wallet/features/wallet/presentation/wallet_page/wallet_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  final LocalAuthRepository localAuthRepository;

  late final LocalAuthGuard authGuard = LocalAuthGuard(localAuthRepository);

  AppRouter(this.localAuthRepository);

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: LocalAuthRoute.page, initial: true),
    AutoRoute(page: GeneratePhraseRoute.page),
    AutoRoute(page: WalletRoute.page, guards: [authGuard]),
  ];
}