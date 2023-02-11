import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(
            color: Colors.green,
          ),
          title: const Text(
            "Plant It",
            style: TextStyle(color: Colors.green, fontSize: 20),
          ),
          elevation: 0,
        ),
        drawer: const Drawer(),
        body: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 20.0),
                  padding: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 12.0),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: Colors.green.shade50, width: 1.5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "User Name",
                            style: TextStyle(color: Colors.green, fontSize: 18),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 3.0, horizontal: 10.0),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                  color: Colors.lightGreen, width: 0.8),
                            ),
                            child: const Text(
                              "farmer",
                              style: TextStyle(color: Colors.green),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Container(
                          height: 150,
                          width: 150,
                          color: Colors.grey,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.energy_savings_leaf_outlined,
                                color: Colors.green,
                                size: 30,
                              ),
                            ),
                            const Text(
                              "Likes : 23",
                              style: TextStyle(color: Colors.lightGreen),
                            ),
                            const Text(
                              "27/03/22 13:00",
                              style: TextStyle(color: Colors.lightGreen),
                            ),
                            IconButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  backgroundColor: Colors.white,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(10.0))),
                                  context: context,
                                  builder: (context) {
                                    return const CommentBottomSheet();
                                  },
                                );
                              },
                              icon: const Icon(
                                Icons.comment,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CommentBottomSheet extends StatelessWidget {
  const CommentBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(
            top: 15.0,
            left: 10,
            right: 10,
            bottom: 8,
          ),
          child: Text(
            "Comments",
            style: TextStyle(
              color: Colors.green,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: 10,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, int) {
              return Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 10.0,
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 5.0,
                  horizontal: 10.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "UserName",
                      style: TextStyle(
                          color: Colors.green.shade400,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      "Comment",
                      style: TextStyle(
                        color: Colors.green.shade300,
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, int) {
              return Divider(
                color: Colors.green.shade100,
                thickness: 1.5,
                height: 3,
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
                  decoration: const InputDecoration(
                      label: Text("Comment"), hintText: "Type your comment..."),

                  style: TextStyle(
                    color: Colors.green.shade400,
                  ),
                  onSubmitted: (value) {
                    // Submit the comment
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.green, width: 1),
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text(
                    "Send",
                    style: TextStyle(color: Colors.green, fontSize: 15),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
