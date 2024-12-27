import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet/features/wallet/presentation/wallet_page/bloc/wallet_bloc.dart';

class WalletView extends StatelessWidget {
  const WalletView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<WalletBloc, WalletState>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: _BalanceText(state.wallet.balance),
              ),
              const SizedBox(height: 24.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _CopyAddressButton(address: state.wallet.address),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Replace with your send logic
                      },
                      label: const Text('Send'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class _BalanceText extends StatelessWidget {
  final String balance;

  const _BalanceText(this.balance, {super.key});

  @override
  Widget build(BuildContext context) {
    var message = 'Balance: $balance SOL';

    return Text(
      message,
      style: const TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.pinkAccent,
      ),
    );
  }
}

class _CopyAddressButton extends StatelessWidget {
  final String address;

  const _CopyAddressButton({required this.address, super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        Clipboard.setData(ClipboardData(text: address));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Address copied to clipboard!')),
        );
      },
      icon: const Icon(Icons.copy),
      label: const Text('Copy Address'),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      ),
    );
  }
}