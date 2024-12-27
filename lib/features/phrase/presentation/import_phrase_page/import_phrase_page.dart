import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:wallet/features/phrase/domain/repositroy/phrase_repository.dart';
import 'package:wallet/features/phrase/presentation/import_phrase_page/bloc/import_phrase_bloc.dart';
import 'package:wallet/features/phrase/presentation/import_phrase_page/import_phrase_navigation.dart';
import 'package:wallet/features/phrase/presentation/import_phrase_page/import_phrase_view.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class ImportPhrasePage extends StatelessWidget {
  const ImportPhrasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ImportPhraseBloc>(
      create: (_) => ImportPhraseBloc(context.read<PhraseRepository>())
        ..add(const ImportPhraseEvent.started()),
      child: Provider<BaseImportPhraseNavigation>(
        create: (_) => ImportPhraseNavigation(),
        child: const ImportPhraseView(),
      ),
    );
  }
}