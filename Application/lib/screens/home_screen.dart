import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plant_it/constants.dart';
import 'package:plant_it/model/user_model.dart';
import 'package:plant_it/screens/chat_list_screen.dart';
import 'package:plant_it/services/network_helper.dart';
import 'package:plant_it/services/shared_prefs.dart';

import 'custom_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List> getFeed() async {
    User user = await SharedPrefs.getUser();
    return await NetworkHelper.getPosts(user.email);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () async {
            await showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: const NewPostBottomSheet(),
                  );
                });
            setState(() {});
          },
        ),
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.green, size: 30),
          title: const Text(
            "Plant It",
            style: TextStyle(color: Colors.green, fontSize: 20),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ChatListScreen(),
                  ),
                );
              },
              icon: const Icon(
                Icons.mail_rounded,
                size: 30,
              ),
            ),
          ],
        ),
        drawer: const CustomDrawer(),
        body: FutureBuilder(
            future: getFeed(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    var post = snapshot.data![index];
                    return PostWidget(
                      postId: post["id"],
                      userName: post["author"],
                      userType: post["user_type"],
                      imageUrl: "${NetworkHelper.urlString}${post["image"]}",
                      caption: post["caption"],
                      likes: post["likes"],
                      time: post["time"],
                      comments: post["comments"],
                      isLiked: post["isliked"],
                    );
                  },
                );
              } else {
                return const Center(
                  child: kCircularProgressIndicator,
                );
              }
            }),
      ),
    );
  }
}

class NewPostBottomSheet extends StatefulWidget {
  const NewPostBottomSheet({
    super.key,
  });

  @override
  State<NewPostBottomSheet> createState() => _NewPostBottomSheetState();
}

class _NewPostBottomSheetState extends State<NewPostBottomSheet> {
  final ImagePicker _picker = ImagePicker();
  XFile? image;
  String caption = "";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () async {
                    image = await _picker.pickImage(source: ImageSource.camera);
                  },
                  icon: const Icon(
                    Icons.camera_alt,
                    color: Colors.green,
                    size: 30,
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    image =
                        await _picker.pickImage(source: ImageSource.gallery);
                  },
                  icon: const Icon(
                    Icons.photo,
                    color: Colors.green,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 25.0),
            child: TextField(
              keyboardType: TextInputType.multiline,
              maxLines: 10,
              onChanged: (value) {
                caption = value;
              },
              decoration: InputDecoration(
                hintText: "Type your caption...",
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
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: OutlinedButton(
              onPressed: () async {
                var user = await SharedPrefs.getUser();
                print(caption + " This is caption");
                NetworkHelper.makeAPost(
                    caption, image!, user.name, user.userType);
              },
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.green,
                side: BorderSide(color: Colors.green.shade200, width: 1),
                padding: const EdgeInsets.symmetric(vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                "Post",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PostWidget extends StatefulWidget {
  final String userName, userType, time, imageUrl, caption;
  final int postId;
  final List comments;
  bool isLiked;
  int likes;

  PostWidget({
    super.key,
    required this.userName,
    required this.userType,
    required this.time,
    required this.likes,
    required this.imageUrl,
    required this.caption,
    required this.comments,
    required this.isLiked,
    required this.postId,
  });

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 12.0),
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
              Text(
                widget.userName,
                style: const TextStyle(color: Colors.green, fontSize: 18),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 3.0, horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: Colors.lightGreen, width: 0.8),
                ),
                child: Text(
                  widget.userType.toUpperCase(),
                  style: const TextStyle(color: Colors.green),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Container(
              height: MediaQuery.of(context).size.height / 5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: Image.network(widget.imageUrl).image,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () async {
                    if (widget.isLiked) {
                      return;
                    }
                    User user = await SharedPrefs.getUser();
                    await NetworkHelper.likePost(user.email, widget.postId);
                    setState(() {
                      widget.isLiked = true;
                      widget.likes += 1;
                    });
                  },
                  icon: Icon(
                    widget.isLiked
                        ? Icons.energy_savings_leaf_rounded
                        : Icons.energy_savings_leaf_outlined,
                    color: Colors.green,
                    size: 30,
                  ),
                ),
                Text(
                  "Likes : ${widget.likes}",
                  style: const TextStyle(color: Colors.lightGreen),
                ),
                IconButton(
                  onPressed: () async {
                    await showModalBottomSheet(
                      backgroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(10.0),
                        ),
                      ),
                      context: context,
                      builder: (context) {
                        return Padding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: CommentBottomSheet(
                            comments: widget.comments,
                            postId: widget.postId,
                          ),
                        );
                      },
                    );
                    setState(() {});
                  },
                  icon: const Icon(
                    Icons.comment,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
          Text(
            widget.caption,
            style: const TextStyle(color: Colors.green, fontSize: 18),
          )
        ],
      ),
    );
  }
}

class CommentBottomSheet extends StatefulWidget {
  const CommentBottomSheet({
    super.key,
    required this.comments,
    required this.postId,
  });

  final List comments;
  final int postId;

  @override
  State<CommentBottomSheet> createState() => _CommentBottomSheetState();
}

class _CommentBottomSheetState extends State<CommentBottomSheet> {
  String comment = "";

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
            itemCount: widget.comments.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              var comment = widget.comments[index];
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
                      comment["author"],
                      style: TextStyle(
                          color: Colors.green.shade400,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      comment["comment"],
                      style: TextStyle(
                        color: Colors.green.shade300,
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
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
                  onChanged: (value) {
                    comment = value;
                  },
                  decoration: const InputDecoration(
                      label: Text("Comment"), hintText: "Type your comment..."),
                  style: TextStyle(
                    color: Colors.green.shade400,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: OutlinedButton(
                  onPressed: () async {
                    var user = await SharedPrefs.getUser();
                    print(comment + " This is caption");
                    await NetworkHelper.addComment(
                        comment, widget.postId, user.name);

                  },
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
