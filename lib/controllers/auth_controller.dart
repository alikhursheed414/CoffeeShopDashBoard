import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'base_controller/my_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class AuthController extends MyController{

  RxBool isLoading = false.obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> performLogin(BuildContext ctx)async{
    try{
      isLoading.value = true;

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );

      User? user = userCredential.user;

      if(user?.email == "admin@gmail.com"){
        ctx.beamToNamed("/dashboard", replaceRouteInformation: true);
      }else{
        generateMessage("You're not an admin", ctx);
      }

    }catch(e){
      generateMessage("Error while login: ${e.toString()}", ctx);
      debugPrint("Error while login: ${e.toString()}");
    }finally{
      isLoading.value = false;
    }
  }

}