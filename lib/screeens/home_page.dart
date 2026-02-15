import 'package:chating_app/components/custom_drawer.dart';
import 'package:chating_app/components/user_listtile.dart';
import 'package:chating_app/screeens/chat_page.dart';
import 'package:chating_app/service/auth/auth_service.dart';
import 'package:chating_app/service/chat/chat_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('H O M E')),
      drawer: CustomDrawer(),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: _chatService.getUserStream(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData) {
          return Center(child: Text('No users found'));
        }

        final users = snapshot.data!;
        if (users.isEmpty) {
          return Center(child: Text('No users available'));
        }

        return Padding(
          padding: const EdgeInsets.only(top: 25),
          child: ListView.builder(
            itemCount: users.length,
            itemBuilder: (ctx, index) =>
                _buildUserListTile(users[index], context),
          ),
        );
      },
    );
  }

  Widget _buildUserListTile(
    Map<String, dynamic> userData,
    BuildContext context,
  ) {
    if (userData['email'] != _authService.currentUser?.email) {
      return UserListtile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                email: userData['email'] ?? 'No Email',
                receiverId: userData['uid'],
              ),
            ),
          );
          // Handle user tap, e.g., navigate to chat screen
        },
        text: userData['email'] ?? 'No Email',
      );
    } else {
      return Container();
    }
  }
}
