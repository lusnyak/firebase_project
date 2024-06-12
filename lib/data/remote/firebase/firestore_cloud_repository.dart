import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_project/domain/models/user_model/user_model.dart';

class FirestoreCloudRepo {
  FirestoreCloudRepo._();

  static FirestoreCloudRepo? _instance;

  static FirestoreCloudRepo get instance {
    return _instance ?? FirestoreCloudRepo._();
  }

  FirebaseFirestore ffInstance = FirebaseFirestore.instance;

  CollectionReference<UserModel> get usersRef =>
      ffInstance.collection("users").withConverter(
          fromFirestore: (data, _) => UserModel.fromJson(data.data()!),
          toFirestore: (user, _) => user.toJson());

  Stream<QuerySnapshot<UserModel>> getUsers() {
    return usersRef.snapshots();
  }

  addUser() {
    final newValue = UserModel(firstName: "Vlad", lastName: "Baghdasaryan", dob: DateTime(2000, 11, 24), status: false);
    usersRef.add(newValue);
  }
}
