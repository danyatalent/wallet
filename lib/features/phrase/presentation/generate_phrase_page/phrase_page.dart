import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:wallet/features/phrase/domain/repositroy/phrase_repository.dart';
import 'package:wallet/features/phrase/presentation/generate_phrase_page/bloc/phrase_bloc.dart';
import 'package:wallet/features/phrase/presentation/generate_phrase_page/phrase_navigation.dart';
import 'package:wallet/features/phrase/presentation/generate_phrase_page/phrase_view.dart';
import 'package:auto_route/annotations.dart';


@RoutePage()
class PhrasePage extends StatelessWidget {
  const PhrasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PhraseBloc>(
        create: (_) => PhraseBloc(context.read<PhraseRepository>())
            ..add(const PhraseEvent.started()),
        child: Provider<BasePhraseNavigation>(
            create: (_) => PhraseNavigation(),
            child: const PhraseView()
        ),
    );
  }
}