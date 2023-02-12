import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String userName;
  const ChatScreen({Key? key, required this.userName}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<String> chatMessages = ["Hello! How are you?", "I am very well! Thank You", "I love the plants that you grow in your backyard !", "Good day today for some farming", "I see that your plants are doing well.", "We should host a pottery event!", "How did the event go?", "I hope well!", "I cannot wait for my marigolds to bloom!", "Neither can I!"];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.green.shade100,
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
          title: Text(
            widget.userName,
            style: const TextStyle(
              color: Colors.green,
              fontSize: 20,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Align(
                    alignment: index % 3 == 0
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 8.0),
                      margin: const EdgeInsets.only(
                        right: 5.0,
                        top: 8.0,
                        left: 5.0,
                      ),
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.7,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.horizontal(
                          left: index % 3 == 0
                              ? const Radius.circular(7)
                              : Radius.zero,
                          right: index % 3 == 0
                              ? Radius.zero
                              : const Radius.circular(7),
                        ),
                      ),
                      child: Text(
                        chatMessages[index],
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 10.0,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.text,
                      // onChanged: (value) => email = value,
                      decoration: InputDecoration(
                        label: const Text("Comment"),
                        hintText: "Type your message...",
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green.shade200),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                      style: TextStyle(
                        color: Colors.green.shade400,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.green,
                        side:
                            BorderSide(color: Colors.green.shade200, width: 1),
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        "Send",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
