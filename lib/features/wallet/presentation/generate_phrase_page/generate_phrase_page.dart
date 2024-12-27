import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:wallet/features/wallet/presentation/generate_phrase_page/bloc/generate_phrase_bloc.dart';
import 'package:wallet/features/wallet/presentation/generate_phrase_page/generate_phrase_navigation.dart';
import 'package:wallet/features/wallet/presentation/generate_phrase_page/generate_phrase_view.dart';
import 'package:wallet/features/wallet/domain/repository/wallet_repository.dart';

@RoutePage()
class GeneratePhrasePage extends StatelessWidget {
  const GeneratePhrasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GeneratePhraseBloc(context.read<WalletRepository>())
        ..add(const GeneratePhraseEvent.started()),
      child: Provider<BaseGeneratePhraseNavigation>(
        create: (_) => GeneratePhraseNavigation(),
        child: const GeneratePhraseView(),
      ),
    );
  }
}