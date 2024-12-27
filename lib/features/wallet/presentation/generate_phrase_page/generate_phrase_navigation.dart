import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:wallet/features/router/app_router.dart';

abstract class BaseGeneratePhraseNavigation {
  void pushWallet(BuildContext context);
}

class GeneratePhraseNavigation implements BaseGeneratePhraseNavigation {
  @override
  void pushWallet(BuildContext context) {
    context.router.push(const WalletRoute());
  }
}