import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet/features/phrase/domain/entities/phrase.dart';
import 'package:wallet/features/phrase/presentation/import_phrase_page/bloc/import_phrase_bloc.dart';
import 'package:wallet/features/phrase/presentation/import_phrase_page/import_phrase_navigation.dart';

class ImportPhraseView extends StatelessWidget {
  const ImportPhraseView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<TextEditingController> controllers = List.generate(12, (_) => TextEditingController());

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
                      'Import your mnemonic phrase',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Expanded(
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16.0,
                          crossAxisSpacing: 16.0,
                          childAspectRatio: 4.0,
                        ),
                        itemCount: 12,
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${index + 1}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextFormField(
                                onChanged: (v) {
                                  context.read<ImportPhraseBloc>().add(ImportPhraseEvent.updateWord(index: index, word: v));
                                },
                                controller: controllers[index],
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
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

  String _getMnemonicPhrase(List<String> words) {
    return words.map((e) => e.trim()).join(' ');
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        final mnemonicPhrase = _getMnemonicPhrase(context.read<ImportPhraseBloc>().state.words);
        if (mnemonicPhrase.split(' ').length == 12) {
          context.read<ImportPhraseBloc>().add(const ImportPhraseEvent.submit());
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please fill in all 12 words')),
          );
        }
      },
      label: const Text('Submit'),
      icon: Image.asset('assets/check.svg', width: 16.0, height: 16.0),
    );
  }
}