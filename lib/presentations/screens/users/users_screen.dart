import 'package:firebase_project/presentations/screens/users/users_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/remote/firebase/firestore_cloud_repository.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.person_add_alt),
        onPressed: (){
          FirestoreCloudRepo.instance.addUser();
        },
      ),
      body: SafeArea(
        child: StreamBuilder(
            stream: FirestoreCloudRepo.instance.getUsers(),
            builder: (context, snapshot) {
              final users = snapshot.data?.docs.toList();
              return ListView.builder(
                  itemCount: users?.length,
                  itemBuilder: (context, index) {
                    final user = users?[index].data();
                    return ListTile(
                      title: Text("${user?.firstName} ${user?.lastName}"),
                      subtitle: Text(user?.dob.toString() ?? ""),
                      trailing: (user?.status ?? false) ? const Icon(Icons.check) : null,
                    );
                  });
            }),
      ),
    );
  }
}
