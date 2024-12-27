import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet/features/phrase/domain/entities/phrase.dart';
import 'package:wallet/features/phrase/presentation/generate_phrase_page/phrase_navigation.dart';

import 'bloc/phrase_bloc.dart';

class PhraseView extends StatelessWidget {
  const PhraseView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PhraseBloc, PhraseState>(
          builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: _PhraseGrid(state.text, state.phrase),
                  ),
                  const SizedBox(height: 24.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(
                        value: state.checkboxValue,
                        onChanged: (value) {
                          context.read<PhraseBloc>().add(PhraseEvent.checkboxChanged(value: value ?? false));
                        },
                      ),
                      const Text('I have written down all the words.', style: TextStyle(color: Colors.redAccent, fontSize: 8))
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  if (state.checkboxValue)
                    _CopyAndContinueButton(text: state.text),
                ],
              );
          },
      ),
    );
  }
}

class _PhraseGrid extends StatelessWidget {
  final String text;
  final Phrase phrase;

  const _PhraseGrid(this.text, this.phrase, {super.key});

  @override
  Widget build(BuildContext context) {
    if (phrase is PhraseSetupRequired) {
      return const Center(child: Text('Loading...'));
    }

    final words = text.split(' ');

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
          child: Text(
            words[index],
            style: const TextStyle(fontSize: 16.0, color: Colors.white),
          ),
        );
      },
    );
  }
}

class _CopyAndContinueButton extends StatelessWidget {
  final String text;

  const _CopyAndContinueButton({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        Clipboard.setData(ClipboardData(text: text));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Phrase copied to clipboard')),
        );
        Future.delayed(const Duration(seconds: 1));
        context.read<BasePhraseNavigation>().replaceLocalAuth(context);
      },
      icon: const Icon(Icons.copy),
      label: const Text('Copy and continue'),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      ),
    );
  }
}