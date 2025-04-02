import 'package:flutter/material.dart';
import 'package:flutter_scan_lock/utils/custom_snackbar.dart';
import 'package:flutter_scan_lock/utils/open_screen_lock.dart';
import 'package:flutter_scan_lock/utils/open_screen_with_confirm.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Screen Lock Demo'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 700,
              ),
              child: Wrap(
                spacing: 16,
                runSpacing: 16,
                alignment: WrapAlignment.start,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      openScreenLock(
                        context: context,
                        correctString: '1234',
                        onSuccess: () {
                          CustomSnackbar.success(context, 'Success');
                          NextPage.show(context);
                        },
                        onError: () {
                          CustomSnackbar.error(context, 'Wrong Passcode');
                        },
                      );
                    },
                    child: const Text('ScreenLock'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      openScreenLockWithConfirm(
                        context: context,
                        correctString: '1234',
                        onSuccess: () {
                          CustomSnackbar.success(context, 'Success');
                          NextPage.show(context);
                        },
                        onError: () {
                          CustomSnackbar.error(context, 'Wrong Passcode');
                        },
                      );
                    },
                    child: const Text('ScreenLock with Confirm'),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

class NextPage extends StatelessWidget {
  const NextPage({super.key});

  static show(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const NextPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Next Page'),
      ),
    );
  }
}
