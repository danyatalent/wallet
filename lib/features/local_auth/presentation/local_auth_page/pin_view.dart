import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:wallet/features/local_auth/presentation/local_auth_page/bloc/local_auth_bloc.dart';

class PinEntryView extends StatelessWidget {
  const PinEntryView({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController pinController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Setup Pin Code')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PinCodeTextField(
              appContext: context,
              length: 4,
              obscureText: true,
              animationType: AnimationType.fade,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(5),
                fieldHeight: 50,
                fieldWidth: 40,
                activeFillColor: Colors.white,
              ),
              animationDuration: const Duration(milliseconds: 300),
              backgroundColor: Colors.blue.shade50,
              enableActiveFill: true,
              controller: pinController,
              onCompleted: (v) {
                context.read<LocalAuthBloc>().add(LocalAuthEventPinChanged(pinCode: v));
                context.read<LocalAuthBloc>().add(const LocalAuthEventVerify());
                Navigator.of(context).pop();
              },
              onChanged: (value) {},
              beforeTextPaste: (text) {
                return true;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final pinCode = pinController.text;
                context.read<LocalAuthBloc>().add(LocalAuthEventPinChanged(pinCode: pinCode));
                context.read<LocalAuthBloc>().add(const LocalAuthEventVerify());
                Navigator.of(context).pop();
              },
              child: const Text('Enter Pin Code'),
            ),
          ],
        ),
      ),
    );
  }
}