import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wallet/features/phrase/domain/entities/phrase.dart';
import 'package:wallet/features/phrase/presentation/welcome_page/welcome_navigation.dart';

import 'bloc/welcome_bloc.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<WelcomeBloc, WelcomeState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/wallet.svg', width: 32.0, height: 32.0),
                    const SizedBox(width: 8.0),
                    const Text(
                      'TerraWallet',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Padding(padding: EdgeInsets.only(top:56)),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: _CreateWalletButton()
                    ),
                    Padding(padding: EdgeInsets.all(8)),
                    Expanded(
                      child: _ImportWalletButton()
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _CreateWalletButton extends StatelessWidget {
  const _CreateWalletButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        context.read<BaseWelcomeNavigation>().replaceGeneratePhrase(context);
      },
      icon: SvgPicture.asset('assets/add.svg'),
      label: const Text('Create Wallet'),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      ),
    );
  }
}

class _ImportWalletButton extends StatelessWidget {
  const _ImportWalletButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        context.read<BaseWelcomeNavigation>().replaceImportPhrase(context);
      },
      label: const Text('Import Wallet'),
      icon: SvgPicture.asset('assets/import.svg'),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      ),
    );
  }
}