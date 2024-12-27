import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:wallet/features/wallet/presentation/wallet_page/bloc/wallet_bloc.dart';
import 'package:wallet/features/wallet/presentation/wallet_page/wallet_navigation.dart';
import 'package:wallet/features/wallet/presentation/wallet_page/wallet_view.dart';
import 'package:wallet/features/wallet/domain/repository/wallet_repository.dart';

@RoutePage()
class WalletPage extends StatelessWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => WalletBloc(context.read<WalletRepository>())
          ..add(const WalletEvent.started()),
        child: Provider<BaseWalletNavigation>(
          create: (_) => WalletNavigation(),
          child: const WalletView(),
        ),
    );
  }
}