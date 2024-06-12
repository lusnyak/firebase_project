import 'package:firebase_project/data/remote/firebase/firestore_cloud_repository.dart';
import 'package:flutter/material.dart';

class UsersProvider extends ChangeNotifier {


   getUsers()  {
      FirestoreCloudRepo.instance.getUsers();
   }
}