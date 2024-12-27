import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:wallet/features/router/app_router.dart';

abstract class BaseWelcomeNavigation {
  void replaceGeneratePhrase(BuildContext context);
  void replaceImportPhrase(BuildContext context);
}

class WelcomeNavigation implements BaseWelcomeNavigation {
  @override
  void replaceGeneratePhrase(BuildContext context) {
    context.router.replace(const PhraseRoute());
  }

  @override
  void replaceImportPhrase(BuildContext context) {
    context.router.replace(const ImportPhraseRoute());
  }
}