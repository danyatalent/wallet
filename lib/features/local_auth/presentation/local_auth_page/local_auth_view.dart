import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:wallet/features/local_auth/presentation/local_auth_page/bloc/local_auth_bloc.dart';
import 'package:wallet/features/local_auth/presentation/local_auth_page/local_auth_navigation.dart';

class LocalAuthView extends StatelessWidget {
  const LocalAuthView({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocListener<LocalAuthBloc, LocalAuthState>(
      listener: (context, state) {
        final navigation = context.read<BaseLocalAuthNavigation>();

         if (state.status == BlocLocalAuthStatus.authenticated) {
          if (navigation.canPop) {
            navigation.popWithResult(context);
            return;
          }
          navigation.replaceWallet(context);
         }
         // if (state.status == BlocLocalAuthStatus.pinVerified) {
         //  navigation.replaceGeneratePhrase(context);
         // }
      },
      child:  Scaffold(
        body: Center(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Form(
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const _PinCodeTextField(),
                      const Padding(padding: EdgeInsets.all(20)),
                      _TextMessage(),
                    ],
                ),
              ),
          ),
        )
      )
    );
  }
}

class _PinCodeTextField extends StatelessWidget {
  const _PinCodeTextField({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();

    return PinCodeTextField(
          appContext: context,
          length: 4,
          pastedTextStyle: TextStyle(
            color: Colors.green.shade600,
            fontWeight: FontWeight.bold,
          ),
          animationType: AnimationType.fade,
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(5),
            fieldHeight: 50,
            fieldWidth: 40,
            activeFillColor: Colors.white,
          ),
          animationDuration: const Duration(milliseconds: 300),
          cursorColor: Colors.black,
          keyboardType: TextInputType.number,
          controller: textEditingController,
          boxShadows: const [
            BoxShadow(
              offset: Offset(0, 1),
              color: Colors.black12,
              blurRadius: 10,
            )
          ],
          onChanged: (v) {
            context.read<LocalAuthBloc>().add(LocalAuthEventPinChanged(pinCode: v));
          },
          onCompleted: (v) {
            final currentStatus = context.read<LocalAuthBloc>().state.status;

            if (currentStatus == BlocLocalAuthStatus.setupRequired) {
              context.read<LocalAuthBloc>().add(const LocalAuthEventPinSetup());
            } else if (currentStatus == BlocLocalAuthStatus.settingUp) {
              context.read<LocalAuthBloc>().add(const LocalAuthEventPinVerify());
            } else {
              context.read<LocalAuthBloc>().add(const LocalAuthEventVerify());
            }

            textEditingController.clear();
          },
    );
  }
}

class _TextMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentStatus = context.select((LocalAuthBloc bloc) => bloc.state.status);

    var message = 'Enter your pin code';

    if (currentStatus == BlocLocalAuthStatus.setupRequired) {
      message = 'Please setup your pin code';
    } else if (currentStatus == BlocLocalAuthStatus.settingUp) {
      message = 'Please verify your pin code';
    }

    return Text(
        message,
        style: const TextStyle(
            fontSize: 20,
            color: Colors.orange
        ),
    );
  }
}