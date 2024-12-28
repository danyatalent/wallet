import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:wallet/features/router/app_router.dart';

abstract class BaseLocalAuthNavigation {
  bool get canPop;

  void popWithResult(BuildContext context);
  void replaceWallet(BuildContext context);
}

class LocalAuthNavigation implements BaseLocalAuthNavigation {
  final void Function()? onResult;

  LocalAuthNavigation(this.onResult);

  @override
  bool get canPop => onResult != null;

  @override
  void popWithResult(BuildContext context) {
    onResult!();
  }

  @override
  void replaceWallet(BuildContext context) {
    context.router.replace(const WalletRoute());
  }
}