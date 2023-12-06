import 'package:flutter/material.dart';
import 'package:fuel_app/dao/priceEvent.dart';
import 'package:fuel_app/pages/signin.dart';
import 'package:provider/provider.dart';
import 'package:fuel_app/model/fuel_price.dart';
import 'package:fuel_app/pages/settings.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<FuelPriceModel>(builder: (context, fuelPriceModel, child) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              _openSettingsView(context, fuelPriceModel);
            },
          ),
          title: Text(widget.title),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                fuelPriceModel.incrementDieselPrice();
              },
            ),
          ],
        ),
        body: _authenticateHomeView(context, fuelPriceModel),
        floatingActionButton: FloatingActionButton(
          onPressed: fuelPriceModel.incrementPetrolPrice,
          tooltip: 'Increment Fuel Price',
          child: const Icon(Icons.add),
        ),
      );
    });
  }

  Widget _authenticateHomeView(
      BuildContext context, FuelPriceModel fuelPriceModel) {
    if (fuelPriceModel.loggedIn) {
      return HomePageBody(fuelPriceModel: fuelPriceModel);
    } else {
      return const SignInPage();
    }
  }

  _openSettingsView(BuildContext context, FuelPriceModel fuelPriceModel) {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider.value(
              value: fuelPriceModel, child: const SettingsView()),
          fullscreenDialog: true),
    );
  }
}

class HomePageBody extends StatelessWidget {
  const HomePageBody({super.key, required this.fuelPriceModel});

  final FuelPriceModel fuelPriceModel;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
            height: 16.0,
          ),
          fuelPriceModel.showPetrolPrice
              ? PetrolPriceCard(fuelPriceModel: fuelPriceModel)
              : Container(),
          const SizedBox(
            height: 16.0,
          ),
          fuelPriceModel.showDieselPrice
              ? DieselPriceCrard(fuelPriceModel: fuelPriceModel)
              : Container(),
          const SizedBox(
            height: 32.0,
          ),
          Text(
            'Fuel Price History',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(
            height: 4.0,
          ),
          const Expanded(child: PriceHistoryList()),
        ],
      ),
    );
  }
}

class DieselPriceCrard extends StatelessWidget {
  const DieselPriceCrard({
    super.key,
    required this.fuelPriceModel,
  });

  final FuelPriceModel fuelPriceModel;

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
            side: const BorderSide(
              color: Colors.orangeAccent,
            ),
            borderRadius: BorderRadius.circular(20.0)),
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Current Diesel Price:',
                ),
                Text(
                  'R${fuelPriceModel.currentDieselPrice} per litre.',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            )));
  }
}

class PetrolPriceCard extends StatelessWidget {
  const PetrolPriceCard({
    super.key,
    required this.fuelPriceModel,
  });

  final FuelPriceModel fuelPriceModel;

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
            side: const BorderSide(
              color: Colors.green,
            ),
            borderRadius: BorderRadius.circular(20.0)),
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Current Petrol Price:',
                ),
                Text(
                  'R${fuelPriceModel.currentPetrolPrice} per litre.',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            )));
  }
}
