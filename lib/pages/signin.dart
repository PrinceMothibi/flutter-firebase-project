import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:fuel_app/model/fuel_price.dart';
import 'package:provider/provider.dart';

import 'home.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPage();
}

class _SignInPage extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<FuelPriceModel>();

    return SignInScreen(
      providers: [appState.provider],
      actions: [
        AuthStateChangeAction((context, state) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider.value(
                    value: appState,
                    child: const MyHomePage(title: "Fuel4U"),
                  )));
        }),
      ],
    );
  }
}
