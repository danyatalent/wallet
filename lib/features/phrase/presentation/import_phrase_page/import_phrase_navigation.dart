import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:wallet/features/router/app_router.dart';

abstract class BaseImportPhraseNavigation {
  void replaceLocalAuth(BuildContext context);
}

class ImportPhraseNavigation implements BaseImportPhraseNavigation {
  @override
  void replaceLocalAuth(BuildContext context) {
    context.router.replace(LocalAuthRoute());
  }
}