import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wallet/features/phrase/domain/entities/phrase.dart';
import 'package:wallet/features/phrase/presentation/import_phrase_page/bloc/import_phrase_bloc.dart';
import 'package:wallet/features/phrase/presentation/import_phrase_page/import_phrase_navigation.dart';
import 'package:wallet/utils/mnemonic_phrase.dart';

class ImportPhraseView extends StatelessWidget {
  const ImportPhraseView({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocListener<ImportPhraseBloc, ImportPhraseState>(
        listener: (context, state) {
          if (state is PhraseSetted) {
            context.read<BaseImportPhraseNavigation>().replaceLocalAuth(context);
          }
        },
        child: Scaffold(
          body: BlocBuilder<ImportPhraseBloc, ImportPhraseState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Import private key',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: _PhraseGrid(state.words, state.phrase),
                    ),
                    const SizedBox(height: 16.0),
                    const Center(
                        child: _SubmitButton()
                    ),
                  ],
                ),
              );
            }
        )
      )
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        final mnemonicPhrase = getMnemonicPhrase(context.read<ImportPhraseBloc>().state.words);
        if (mnemonicPhrase.split(' ').length == 12) {
          context.read<ImportPhraseBloc>().add(const ImportPhraseEvent.submit());
          context.read<BaseImportPhraseNavigation>().replaceLocalAuth(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please fill in all 12 words', style: TextStyle(color: Colors.redAccent),)),
          );
        }
      },
      label: const Text('Submit'),
      icon: SvgPicture.asset('assets/check.svg', width: 16.0, height: 16.0),
    );
  }
}

class _PhraseGrid extends StatelessWidget {
  final List<String> words;
  final Phrase phrase;

  const _PhraseGrid(this.words, this.phrase, {super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
        childAspectRatio: 3.0,
      ),
      itemCount: words.length,
      itemBuilder: (context, index) {
        return Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8.0),
            ),
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              style: const TextStyle(color: Colors.white, fontSize: 16),
              decoration: null,
              textAlign: TextAlign.center,
              onChanged: (word) => context.read<ImportPhraseBloc>().add(ImportPhraseEvent.updateWord(word: word, index: index)),
            )
        );
      },
    );
  }
}
