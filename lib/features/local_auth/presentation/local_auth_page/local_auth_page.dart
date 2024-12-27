import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:wallet/features/local_auth/domain/repository/local_auth_repository.dart';
import 'package:auto_route/annotations.dart';
import 'package:wallet/features/local_auth/presentation/local_auth_page/bloc/local_auth_bloc.dart';
import 'package:wallet/features/local_auth/presentation/local_auth_page/local_auth_navigation.dart';
import 'package:wallet/features/local_auth/presentation/local_auth_page/local_auth_view.dart';

@RoutePage()
class LocalAuthPage extends StatelessWidget {
  final void Function()? onResult;

  const LocalAuthPage({super.key, this.onResult});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LocalAuthBloc(context.read<LocalAuthRepository>())
        ..add(const LocalAuthEventSubscriptionRequested()),
      child: Provider<BaseLocalAuthNavigation>(
        create: (_) => LocalAuthNavigation(onResult),
        child: const LocalAuthView(),
      ),
    );
  }
}