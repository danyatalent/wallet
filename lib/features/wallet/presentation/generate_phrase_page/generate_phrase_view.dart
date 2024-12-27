import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet/features/wallet/presentation/generate_phrase_page/bloc/generate_phrase_bloc.dart';
import 'package:wallet/features/wallet/presentation/generate_phrase_page/generate_phrase_navigation.dart';

class GeneratePhraseView extends StatelessWidget {
  const GeneratePhraseView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GeneratePhraseBloc, GeneratePhraseState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: _PhraseText(state.wallet.mnemonic),
                ),
                const SizedBox(height: 24.0),
                ElevatedButton(
                  onPressed: () => context.read<BaseGeneratePhraseNavigation>().pushWallet(context),
                  child: const Text('Continue'),
                ),
              ],
            );
          },
      ),
    );
  }
}

class _PhraseText extends StatelessWidget {
  final String phrase;

  const _PhraseText(this.phrase, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      phrase,
      style: const TextStyle(
        fontSize: 32,
      ),
    );
  }
}