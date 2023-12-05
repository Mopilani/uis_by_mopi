import 'package:flutter/material.dart';

class InstagramView extends StatelessWidget {
  const InstagramView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(Icons.home_filled),
          ),
          BottomNavigationBarItem(
            label: "Search",
            icon: Icon(Icons.search),
          ),
          BottomNavigationBarItem(
            label: "reel",
            icon: Icon(Icons.video_call),
          ),
          BottomNavigationBarItem(
            label: "shop",
            icon: Icon(Icons.shop_outlined),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Image.asset(
                    'assets/images/instagram/instagram.png',
                    color: Colors.white,
                    width: 130,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 16.0),
                  child: Row(
                    children: [
                      Icon(Icons.add, color: Colors.white),
                      SizedBox(width: 8.0),
                      Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 20.0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 130.0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Story(
                        image: "assets/images/instagram/users/0.jpeg",
                        name: "user1",
                      ),
                      SizedBox(width: 16.0),
                      Story(
                        image: "assets/images/instagram/users/1.jpeg",
                        name: "user2",
                      ),
                      SizedBox(width: 16.0),
                      Story(
                        image: "assets/images/instagram/users/2.jpeg",
                        name: "user3",
                      ),
                      SizedBox(width: 16.0),
                      Story(
                        image: "assets/images/instagram/users/0.jpeg",
                        name: "user1",
                      ),
                      SizedBox(width: 16.0),
                      Story(
                        image: "assets/images/instagram/users/1.jpeg",
                        name: "user2",
                      ),
                      SizedBox(width: 16.0),
                      Story(
                        image: "assets/images/instagram/users/2.jpeg",
                        name: "user3",
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: 2.0,
              color: Colors.white.withOpacity(0.2),
            ),
            Expanded(
              child: ListView(
                children: const [
                  Post(
                    userName: 'dancamdev',
                    userImage: 'assets/images/instagram/users/dancamdev.png',
                    image: 'assets/images/instagram/posts/0.png',
                  ),
                  Post(
                    userName: 'dancamdev',
                    userImage: 'assets/images/instagram/users/dancamdev.png',
                    image: 'assets/images/instagram/posts/1.png',
                  ),
                  Post(
                    userName: 'dancamdev',
                    userImage: 'assets/images/instagram/users/dancamdev.png',
                    image: 'assets/images/instagram/posts/2.jpg',
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

class Story extends StatelessWidget {
  final String image;
  final String name;

  const Story({
    Key? key,
    required this.image,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 80.0,
          height: 80.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            gradient: const LinearGradient(
              colors: instagramColors,
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
          ),
          padding: const EdgeInsets.all(3.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100.0),
            child: Image.asset(image),
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12.0,
          ),
        )
      ],
    );
  }
}

class Post extends StatelessWidget {
  final String userImage;
  final String userName;
  final String image;

  const Post({
    Key? key,
    required this.userName,
    required this.userImage,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 40.0,
                      height: 40.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(60.0),
                        child: Image.asset(userImage),
                      ),
                    ),
                  ),
                  Text(
                    userName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: Icon(
                Icons.more_horiz,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width,
          child: Image.asset(
            image,
            filterQuality: FilterQuality.high,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/instagram/heart.png',
                    color: Colors.white,
                    height: 30.0,
                  ),
                  const SizedBox(width: 16.0),
                  const Icon(
                    Icons.chat_bubble_outline,
                    color: Colors.white,
                    size: 25.0,
                  ),
                  const SizedBox(width: 16.0),
                  const Icon(
                    Icons.send,
                    color: Colors.white,
                    size: 25.0,
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.bookmark_border,
                color: Colors.white,
                size: 25.0,
              ),
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: Text(
            "Liked by dancamdev and thousands of others",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: Text(
            "dancamdev Today's Progress!...",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: Text(
            "Show comments",
            style: TextStyle(
              color: Colors.white.withOpacity(0.75),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: Text(
            "21 minutes ago",
            style: TextStyle(
              color: Colors.white.withOpacity(0.75),
              fontSize: 10.0,
            ),
          ),
        )
      ],
    );
  }
}

const instagramColors = [
  Color(0xFFfeda75),
  Color(0xfffa7e1e),
  Color(0xffd62976),
  Color(0xff962fbf),
  Color(0xff4f5bd5),
];
