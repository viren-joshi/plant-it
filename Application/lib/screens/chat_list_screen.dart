import 'package:flutter/material.dart';
import 'package:plant_it/constants.dart';
import 'package:plant_it/screens/chat_screen.dart';
import 'package:plant_it/services/network_helper.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({Key? key}) : super(key: key);

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  List<String> usersNames = ["Viren J", "Taaha M", "Divija K", "Devashish B", "Shivam T", "Sheman J", "Kazuha K", "Nahida B", "Ei Shogun", "Suresh K"];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.green,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            "Chat",
            style: TextStyle(
              color: Colors.green,
              fontSize: 20,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        body: FutureBuilder(
          future: NetworkHelper.getUserChatList(),
          builder: (context, snapshot) {
            if(snapshot.hasData){
              return ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      title: Text(snapshot.data![index]["name"]),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ChatScreen(userName: snapshot.data![index]["name"]),
                          ),
                        );
                      },
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(
                    color: Colors.lightGreen,
                    thickness: 1.5,
                    height: 3,
                  );
                },
              );
            } else {
              return const Center(child: kCircularProgressIndicator,);
            }
          }
        ),
      ),
    );
  }
}
