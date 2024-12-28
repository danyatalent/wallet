import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wallet/features/wallet/presentation/wallet_page/bloc/wallet_bloc.dart';

class WalletView extends StatelessWidget {
  const WalletView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<WalletBloc, WalletState>(
        listener: (context, state) {
          // Add your listener logic here
        },
          child: BlocBuilder<WalletBloc, WalletState> (
              builder: (context, state) {
                return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row (
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
                      const Padding(padding: EdgeInsets.all(8.0)),
                      _BalanceText(state.wallet.balance),
                      const Padding(padding: EdgeInsets.only(top:48)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              child: _CopyAddressButton(address: state.wallet.address),
                          ),
                          const Padding(padding: EdgeInsets.all(8)),
                          const Expanded(
                              child: _RequestFundsButton(),
                          ),
                          const Padding(padding: EdgeInsets.all(8)),
                          Expanded(
                              child: _CopyPrivateKeyButton(mnemonic: state.wallet.mnemonic),
                          ),
                        ],
                      ),
                    ],
                );
              }
          )
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
        fontSize: 16,
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
      label: const Text('Copy Address', style: TextStyle(color: Colors.white, fontSize: 8)),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      ),
    );
  }
}

class _RequestFundsButton extends StatelessWidget {
  const _RequestFundsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        context.read<WalletBloc>().add(const WalletEvent.requestFunds());
      },
      icon: const Icon(Icons.request_page),
      label: const Text('Request Funds', style: TextStyle(color: Colors.white, fontSize: 8)),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      ),
    );
  }
}

class _CopyPrivateKeyButton extends StatelessWidget {
  final String mnemonic;

  const _CopyPrivateKeyButton({super.key, required this.mnemonic});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        Clipboard.setData(ClipboardData(text: mnemonic));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Private key copied to clipboard!', style: TextStyle(color: Colors.redAccent))),
        );
      },
      icon: const Icon(Icons.key),
      label: const Text('Copy mnemonic', style: TextStyle(color: Colors.redAccent, fontSize: 8)),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      ),
    );
  }
}