import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fuel_app/model/fuel_price.dart';
import 'package:provider/provider.dart';

class PriceEvent {
  const PriceEvent(
      {required this.fuelType, required this.price, required this.timestamp});

  final String fuelType;
  final int price;
  final Timestamp timestamp;

  factory PriceEvent.fromSnapShot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return PriceEvent(
        fuelType: data["fuelType"],
        price: data["newPrice"],
        timestamp: data["timestamp"]);
  }
}

class PriceHistoryList extends StatelessWidget {
  const PriceHistoryList({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<FuelPriceModel>();

    Widget priceHistoryStructure(
        PriceEvent priceEvent, FuelPriceModel appState) {
      DateTime eventDate = priceEvent.timestamp.toDate();
      var day = eventDate.day;
      var month = eventDate.month;
      var year = eventDate.year;
      var time = "${eventDate.hour}:${eventDate.minute}";
      var date = "on $day of $month $year at $time";

      return ListTile(
        leading: const Icon(Icons.history),
        title: Column(children: [
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Text(
                "${priceEvent.fuelType} price changed to ${priceEvent.price} on ${priceEvent.timestamp.toDate()}."),
          )
        ]),
      );
    }

    return FutureBuilder<List<PriceEvent>>(
        future: appState.getPriceEvents(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              List<PriceEvent> priceEvents = snapshot.data as List<PriceEvent>;
              return ListView.builder(itemBuilder: ((c, index) {
                return priceHistoryStructure(priceEvents[index], appState);
              }));
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              return const Text("Something else is wrong");
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}


// Widget _buildPriceHistoryList(
  //     BuildContext context, FuelPriceModel fuelPriceModel) {
  //   return ListView.builder(
  //       itemCount: 20,
  //       padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
  //       itemBuilder: (listBuildContext, index) {
  //         if (index.isEven && !fuelPriceModel.showDieselPrice) {
  //           return Container();
  //         }
  //         if (!index.isEven && !fuelPriceModel.showPetrolPrice) {
  //           return Container();
  //         }
  //         String message = index.isEven
  //             ? 'Diesel price changed to ${fuelPriceModel.currentDieselPrice - (index / 2).ceil()}'
  //             : 'Petrol price changed to ${fuelPriceModel.currentPetrolPrice - (index / 2).floor()}';
  //         return Padding(
  //             padding: const EdgeInsets.all(6.0),
  //             child: Text(
  //               message,
  //               textAlign: TextAlign.center,
  //             ));
  //       });
  // }