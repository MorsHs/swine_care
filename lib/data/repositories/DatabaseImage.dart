import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:swine_care/feature/homepage/controller/image-loc-controller.dart';

class DatabaseImageSender {

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> getImage(File ears,File skin) async {
    final base64Skin = base64Encode(await skin.readAsBytes());
    final base64Ears = base64Encode(await ears.readAsBytes());

    Position? currentPosition;

    try{
    currentPosition =  await ImageLocController().determinePosition();
    }
    catch(e){
      log(e.toString());
      currentPosition = null;
    }

    if(currentPosition != null) {
      await db.collection('users').doc(auth.currentUser!.uid).collection('results').doc().set({
        'ears' : base64Ears,
        'skin' : base64Skin,
        'lat' : currentPosition.latitude,
        'long' : currentPosition.longitude
      });
    }
    else{
      throw('Location not found');
    }
  }
}