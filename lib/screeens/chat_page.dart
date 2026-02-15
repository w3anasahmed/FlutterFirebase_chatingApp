import 'package:chating_app/components/chat_bubble.dart';
import 'package:chating_app/components/custom_textfield.dart';
import 'package:chating_app/service/auth/auth_service.dart';
import 'package:chating_app/service/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final String email;
  final String receiverId;
  ChatPage({super.key, required this.email, required this.receiverId});

  final TextEditingController _messageController = TextEditingController();

  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  void _sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(receiverId, _messageController.text);

      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(email)),
      body: Column(
        children: [
          Expanded(child: _buildMessagesList()),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: _buildUserInput(),
          ),
        ],
      ),
    );
  }

  Widget _buildMessagesList() {
    String senderId = _authService.currentUser!.uid;
    return StreamBuilder(
      stream: _chatService.getMessage(receiverId, senderId),
      builder: (context, snapshot) {
        //error
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        return ListView(
          children: snapshot.data!.docs
              .map((doc) => _buildMessageItem(doc))
              .toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    bool isCurrentUser = data['senderId'] == _authService.currentUser!.uid;

    var alignment = isCurrentUser
        ? Alignment.centerRight
        : Alignment.centerLeft;
    return Column(
      crossAxisAlignment: isCurrentUser
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        ChatBubble(message: data['message'], isCurrentUser: isCurrentUser),
      ],
    );
  }

  Widget _buildUserInput() {
    return Row(
      children: [
        Expanded(
          child: CustomTextfield(
            controller: _messageController,
            hintText: "Enter message...",
            obscureText: false,
          ),
        ),

        Container(
          decoration: BoxDecoration(
            color: Colors.green,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: _sendMessage,
            icon: Icon(Icons.send, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
