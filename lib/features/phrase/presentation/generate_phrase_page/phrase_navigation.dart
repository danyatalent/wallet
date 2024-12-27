import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:wallet/features/router/app_router.dart';

abstract class BasePhraseNavigation {
  void replaceLocalAuth(BuildContext context);
}

class PhraseNavigation implements BasePhraseNavigation {
  @override
  void replaceLocalAuth(BuildContext context) {
    context.router.replace(LocalAuthRoute());
  }
}