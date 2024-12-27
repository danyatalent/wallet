import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:wallet/features/phrase/domain/repositroy/phrase_repository.dart';
import 'package:wallet/features/phrase/presentation/welcome_page/bloc/welcome_bloc.dart';
import 'package:wallet/features/phrase/presentation/welcome_page/welcome_navigation.dart';
import 'package:wallet/features/phrase/presentation/welcome_page/welcome_view.dart';

@RoutePage()
class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WelcomeBloc>(
      create: (_) => WelcomeBloc(context.read<PhraseRepository>())
        ..add(const WelcomeEvent.started()),
      child: Provider<BaseWelcomeNavigation>(
        create: (_) => WelcomeNavigation(),
        child: const WelcomeView(),
      ),
    );
  }
}