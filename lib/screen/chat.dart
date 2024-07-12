import 'package:chatt_app/widgets/chat_masseges.dart';
import 'package:chatt_app/widgets/new_massege.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("flutter chat"),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: Icon(Icons.exit_to_app),
            color: Theme.of(context).colorScheme.primary,
          )
        ],
      ),
      body: const Center(
        child:const Column(children: [
          Expanded(child: ChatMasseges()),
          NewMassege(),
        ],) ,
      ),
    );
  }
}
