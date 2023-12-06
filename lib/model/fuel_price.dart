import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fuel_app/dao/priceEvent.dart';
import 'package:fuel_app/firebase_options.dart';

///Contains the relevant data for our views regarding fuel prices
class FuelPriceModel extends ChangeNotifier {
  FuelPriceModel() {
    init();
  }
  int _petrolPricePerLitre = 21;
  int _dieselPricePerLitre = 22;

  bool _showPetrolPrice = true;
  bool _showDieselPrice = true;
  List<PriceEvent> _priceChangeHistory = [];
  StreamSubscription<QuerySnapshot>? _priceChangeEvents;
  List<PriceEvent> get priceChangeHistory => _priceChangeHistory;
  late final FirebaseFirestore _db;

  void incrementPetrolPrice() {
    _petrolPricePerLitre++;
    addPriceChangeToHistory("petrol");
    notifyListeners();
  }

  void incrementDieselPrice() {
    _dieselPricePerLitre++;
    addPriceChangeToHistory("diesel");
    notifyListeners();
  }

  void updatePetrolPrice(int newPrice) {
    _petrolPricePerLitre = newPrice;
    addPriceChangeToHistory("petrol");
    notifyListeners();
  }

  void updateDieselPrice(int newPrice) {
    _dieselPricePerLitre = newPrice;
    addPriceChangeToHistory("diesel");
    notifyListeners();
  }

  int get currentPetrolPrice => _petrolPricePerLitre;

  int get currentDieselPrice => _dieselPricePerLitre;

  void updateShowPetrolPrice(bool show) {
    _showPetrolPrice = show;
    notifyListeners();
  }

  bool get showPetrolPrice => _showPetrolPrice;

  void updateShowDieselPrice(bool show) {
    _showDieselPrice = show;
    notifyListeners();
  }

  bool get showDieselPrice => _showDieselPrice;

  bool _loggedIn = false;
  bool get loggedIn => _loggedIn;
  var provider = EmailAuthProvider();

  Future<void> init() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

    FirebaseUIAuth.configureProviders([
      EmailAuthProvider(),
    ]);
    FirebaseFirestore db = FirebaseFirestore.instance;
    _db = db;
    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _loggedIn = true;
      } else {
        _loggedIn = false;
        _priceChangeEvents?.cancel();
        _priceChangeHistory = [];
      }
      notifyListeners();
    });
  }

  Future<DocumentReference> addPriceChangeToHistory(String fuelType) {
    var changedPrice = 0;

    if (!_loggedIn) {
      throw Exception('Must be logged in');
    }

    switch (fuelType) {
      case 'diesel':
        changedPrice = _dieselPricePerLitre;
        break;
      case 'petrol':
        changedPrice = _petrolPricePerLitre;
        break;
    }

    final priceEvent = <String, dynamic>{
      'fuelType': fuelType,
      'newPrice': changedPrice,
      'timestamp': DateTime.now(),
      'userId': FirebaseAuth.instance.currentUser!.uid,
    };

    return _db.collection('''
priceEvents''').add(priceEvent);
  }

  Future<List<PriceEvent>> getPriceEvents() async {
    final snapshot = await _db
        .collection("priceEvents")
        .orderBy("timestamp", descending: true)
        .limit(100)
        .get();
    final priceEvent =
        snapshot.docs.map((e) => PriceEvent.fromSnapShot(e)).toList();
    return priceEvent;
  }
}
