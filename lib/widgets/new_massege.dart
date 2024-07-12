import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMassege extends StatefulWidget {
  const NewMassege({Key? key});

  @override
  State<NewMassege> createState() => _NewMassegeState();
}

class _NewMassegeState extends State<NewMassege> {
  final _messageController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _messageController.dispose();
  }

  _sendMessage() async {
    final enteredMessage = _messageController.text;
    if (enteredMessage.trim().isEmpty) {
      return;
    }

    FocusScope.of(context).unfocus();
    _messageController.clear();

    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // Handle no signed-in user scenario
      return;
    }

    final DocumentSnapshot<Map<String, dynamic>> userData =
        await FirebaseFirestore.instance
            .collection("users")
            .doc(user.uid)
            .get();

    final userName = userData.data()?["userame"] ?? "Unknown";
    final userImage = userData.data()?["image_url"] ?? "default_image_url";

    await FirebaseFirestore.instance.collection("chats").add({
      "text": enteredMessage,
      "createdAt": Timestamp.now(),
      "userId": user.uid,
      "userName": userName,
      "userImage": userImage,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 15,
        right: 1,
        bottom: 14,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: const InputDecoration(labelText: "Send a message..."),
              autocorrect: true,
              enableSuggestions: true,
              textCapitalization: TextCapitalization.sentences,
            ),
          ),
          IconButton(
            onPressed: _sendMessage,
            icon: Icon(
              Icons.send,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}