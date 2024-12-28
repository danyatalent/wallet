import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:wallet/features/router/app_router.dart';

abstract class BaseWelcomeNavigation {
  bool get canPop;

  void replaceGeneratePhrase(BuildContext context);
  void replaceImportPhrase(BuildContext context);
  void popWithResult(BuildContext context);
  void replaceLocalAuth(BuildContext context);
}

class WelcomeNavigation implements BaseWelcomeNavigation {
  final void Function()? onResult;

  WelcomeNavigation(this.onResult);

  @override
  bool get canPop => onResult != null;

  @override
  void popWithResult(BuildContext context) {
    onResult!();
  }

  @override
  void replaceGeneratePhrase(BuildContext context) {
    context.router.replace(const PhraseRoute());
  }

  @override
  void replaceImportPhrase(BuildContext context) {
    context.router.replace(const ImportPhraseRoute());
  }

  @override
  void replaceLocalAuth(BuildContext context) {
    context.router.replace(LocalAuthRoute());
  }
}