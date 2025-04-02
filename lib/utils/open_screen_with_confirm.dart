import 'package:flutter/material.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';
import 'package:local_auth/local_auth.dart';

Future<void> localAuth(BuildContext context) async {
  final localAuth = LocalAuthentication();
  final didAuthenticate = await localAuth.authenticate(
    localizedReason: 'Please authenticate',
    options: const AuthenticationOptions(biometricOnly: true),
  );

  if (didAuthenticate && context.mounted) {
    Navigator.pop(context);
  }
}

Future<void> openScreenLockWithConfirm({
  required BuildContext context,
  required String correctString,
  required VoidCallback onSuccess,
  required VoidCallback onError,
}) {
  return screenLockCreate(
    context: context,
    title: const Text(
      'Enter Your Passcode',
      style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.blueAccent),
    ),
    confirmTitle: const Text(
      'Confirm Your Passcode',
      style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.blueAccent),
    ),
    onConfirmed: (match) => {
      if (match == correctString)
        {
          Navigator.pop(context),
          onSuccess(),
        }
      else
        {
          Navigator.pop(context),
          onError(),
        }
    },
    digits: correctString.length,
    config: ScreenLockConfig(
      backgroundColor: Colors.white,
      titleTextStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      buttonStyle: OutlinedButton.styleFrom(
        alignment: Alignment.center,
        foregroundColor: Colors.blueAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        backgroundColor: Colors.white,
        side: const BorderSide(color: Colors.transparent, width: 1),
      ),
    ),
    secretsConfig: SecretsConfig(
      spacing: 20,
      padding: const EdgeInsets.symmetric(vertical: 50),
      secretConfig: SecretConfig(
        borderColor: Colors.transparent,
        borderSize: 2.0,
        disabledColor: Colors.grey.shade300,
        enabledColor: Colors.blueAccent,
        size: 18,
        builder: (context, config, enabled) => Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: enabled ? config.enabledColor : config.disabledColor,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              width: config.borderSize,
              color: config.borderColor,
            ),
          ),
          width: config.size,
          height: config.size,
        ),
      ),
    ),
    keyPadConfig: KeyPadConfig(
      buttonConfig: KeyPadButtonConfig(
        fontSize: 18,
        buttonStyle: OutlinedButton.styleFrom(
          foregroundColor: Colors.blueAccent,
          textStyle: const TextStyle(fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: Colors.white,
          side: const BorderSide(color: Colors.grey, width: 1),
          shadowColor: Colors.blueAccent.withOpacity(0.2),
          elevation: 5,
        ),
      ),
    ),
    customizedButtonChild: const Center(
      child: Icon(
        Icons.fingerprint,
      ),
    ),
    customizedButtonTap: () async => await localAuth(context),
    onOpened: () async => await localAuth(context),
    cancelButton: const Center(
      child: Icon(
        Icons.close,
        color: Colors.blueGrey,
      ),
    ),
    deleteButton: const Center(
      child: Icon(
        Icons.backspace,
        color: Colors.blueGrey,
      ),
    ),
  );
}
