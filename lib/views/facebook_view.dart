import 'package:flutter/material.dart';

class FacebookView extends StatelessWidget {
  const FacebookView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color(0xff2F79EE),
        unselectedItemColor: Colors.grey[700],
        iconSize: 32.0,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.people_alt_outlined), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.shop_outlined), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.person_pin_circle_outlined), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.notifications_none), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: ""),
        ],
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset("assets/images/facebook/facebook.png", height: 30.0),
            const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _TopBarIcon(icon: Icons.search),
                SizedBox(width: 16.0),
                _TopBarIcon(icon: Icons.message_rounded),
              ],
            ),
          ],
        ),
      ),
      body: ListView(
        children: const [
          _WhatsOnYourMindCard(),
          SizedBox(height: 8.0),
          _Stories(),
          SizedBox(height: 8.0),
          _Post(
            profileImage: "assets/images/facebook/user0.jpeg",
            text:
                "This is the text for a random post, that I wrote while recording the timelapse and wasn't sure what to write :)",
            name: name0,
          ),
          SizedBox(height: 8.0),
          _Post(
            profileImage: "assets/images/facebook/user1.jpeg",
            text:
                "This is the text for a random post, that I wrote while recording the timelapse and wasn't sure what to write :)",
            name: name1,
          ),
          SizedBox(height: 8.0),
          _Post(
            profileImage: "assets/images/facebook/user2.jpeg",
            text:
                "This is the text for a random post, that I wrote while recording the timelapse and wasn't sure what to write :)",
            name: name2,
          ),
        ],
      ),
    );
  }
}

class _Post extends StatelessWidget {
  final String profileImage;
  final String name;
  final String text;

  const _Post({
    Key? key,
    required this.profileImage,
    required this.name,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          _PostHeader(
            profileImage: profileImage,
            name: name,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              text,
              style: const TextStyle(fontSize: 18.0),
            ),
          ),
          const _LikeCommentShareRow(),
        ],
      ),
    );
  }
}

class _LikeCommentShareRow extends StatelessWidget {
  const _LikeCommentShareRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: _WhatsOnYourMindButton(
            text: "Like",
            iconColor: Colors.grey,
            icon: Icons.thumb_up_alt_outlined,
          ),
        ),
        SizedBox(width: 1.0),
        Expanded(
          child: _WhatsOnYourMindButton(
            text: "Comment",
            iconColor: Colors.grey,
            icon: Icons.messenger_outline_sharp,
          ),
        ),
        SizedBox(width: 1.0),
        Expanded(
          child: _WhatsOnYourMindButton(
            text: "Share",
            iconColor: Colors.grey,
            icon: Icons.share,
          ),
        ),
      ],
    );
  }
}

class _PostHeader extends StatelessWidget {
  final String profileImage;
  final String name;

  const _PostHeader({required this.profileImage, required this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(60.0),
                child: SizedBox(
                  height: 40.0,
                  width: 40.0,
                  child: Image.asset(profileImage),
                ),
              ),
              const SizedBox(width: 8.0),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                        text: "$name ",
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    const TextSpan(text: "updated his status"),
                  ],
                ),
              ),
            ],
          ),
          Icon(Icons.more_horiz_rounded, color: Colors.grey[600]),
        ],
      ),
    );
  }
}

class _Stories extends StatelessWidget {
  const _Stories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250.0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: const [
            SizedBox(width: 16.0),
            _Story(image: "assets/images/facebook/story0.jpeg", name: name0),
            SizedBox(width: 8.0),
            _Story(image: "assets/images/facebook/story1.jpeg", name: name1),
            SizedBox(width: 8.0),
            _Story(image: "assets/images/facebook/story2.jpeg", name: name2),
            SizedBox(width: 8.0),
            _Story(image: "assets/images/facebook/story3.jpeg", name: name3),
            SizedBox(width: 8.0),
            _Story(image: "assets/images/facebook/story0.jpeg", name: name0),
            SizedBox(width: 8.0),
            _Story(image: "assets/images/facebook/story1.jpeg", name: name1),
            SizedBox(width: 8.0),
            _Story(image: "assets/images/facebook/story2.jpeg", name: name2),
            SizedBox(width: 8.0),
            _Story(image: "assets/images/facebook/story3.jpeg", name: name3),
            SizedBox(width: 16.0),
          ],
        ),
      ),
    );
  }
}

class _Story extends StatelessWidget {
  final String image;
  final String name;

  const _Story({
    Key? key,
    required this.image,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.0,
      height: 200.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Text(
            name,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class _WhatsOnYourMindCard extends StatelessWidget {
  const _WhatsOnYourMindCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 100.0,
          color: Colors.white,
          child: Row(
            children: [
              const SizedBox(width: 16.0),
              ClipRRect(
                borderRadius: BorderRadius.circular(60.0),
                child: SizedBox(
                  height: 60.0,
                  width: 60.0,
                  child: Image.asset("assets/images/facebook/dancamdev.png"),
                ),
              ),
              const SizedBox(width: 16.0),
              const Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "What's on your mind?",
                    hintStyle: TextStyle(color: Colors.black),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 1.0),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: _WhatsOnYourMindButton(
                text: "Live",
                iconColor: Colors.red,
                icon: Icons.video_call,
              ),
            ),
            SizedBox(width: 1.0),
            Expanded(
              child: _WhatsOnYourMindButton(
                text: "Photo",
                iconColor: Colors.green,
                icon: Icons.photo,
              ),
            ),
            SizedBox(width: 1.0),
            Expanded(
              child: _WhatsOnYourMindButton(
                text: "Room",
                iconColor: Colors.deepPurple,
                icon: Icons.video_call,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _WhatsOnYourMindButton extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String text;

  const _WhatsOnYourMindButton({
    Key? key,
    required this.icon,
    required this.iconColor,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: iconColor),
            const SizedBox(width: 8.0),
            Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

class _TopBarIcon extends StatelessWidget {
  final IconData icon;

  const _TopBarIcon({Key? key, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      width: 40.0,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(40.0),
      ),
      child: Center(child: Icon(icon, color: Colors.black)),
    );
  }
}

const name0 = "Elisa Long";
const name1 = "Truman Warren";
const name2 = "Shannen Adamson";
const name3 = "Michelle Everly";
const name4 = "Miles Derrickson";
const name5 = "Marvin Thompsett";
const name6 = "Lennox Boone";
