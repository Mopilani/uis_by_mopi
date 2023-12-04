import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class TwitterUiView extends StatelessWidget {
  const TwitterUiView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1e252f),
      appBar: AppBar(
        backgroundColor: const Color(0xff1e252f),
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100.0),
              image: const DecorationImage(image: AssetImage("assets/dancamdev.png")),
            ),
          ),
        ),
        title: Image.asset("assets/twitter.png", height: 30.0),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Icon(Icons.star_border_outlined, size: 30.0),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        selectedLabelStyle: const TextStyle(color: Colors.white),
        selectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.white.withOpacity(0.5),
        items: const [
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: ""),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.search), label: ""),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.bell), label: ""),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.mail), label: ""),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Center(
          child: Icon(CupertinoIcons.add),
        ),
      ),
      body: ListView.builder(
        itemCount: tweets.length * 2,
        itemBuilder: (_, index) => _Tweet(
          text: tweets[index % tweets.length],
        ),
      ),
    );
  }
}

class _Tweet extends StatelessWidget {
  final String text;
  const _Tweet({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Flexible(flex: 1, child: _ProfileImage(path: "assets/elon.jpg")),
              Flexible(flex: 5, child: _TextAndButtons(text: text)),
            ],
          ),
        ),
        Divider(thickness: 1, color: Colors.white.withOpacity(0.2)),
      ],
    );
  }
}

class _ProfileImage extends StatelessWidget {
  final String path;
  const _ProfileImage({Key? key, required this.path}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      width: 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        image: DecorationImage(image: AssetImage(path)),
      ),
    );
  }
}

class _TextAndButtons extends StatelessWidget {
  final String text;
  const _TextAndButtons({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                "Elon Musk",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0),
              ),
              Text(
                " @elonmusk",
                style: TextStyle(
                    color: Colors.white.withOpacity(0.5), fontSize: 16.0),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Text(
            text,
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                CupertinoIcons.chat_bubble,
                size: 20.0,
                color: Colors.white.withOpacity(0.5),
              ),
              const SizedBox(width: 60.0),
              Icon(
                CupertinoIcons.refresh,
                size: 20.0,
                color: Colors.white.withOpacity(0.5),
              ),
              const SizedBox(width: 60.0),
              Icon(
                CupertinoIcons.heart,
                size: 20.0,
                color: Colors.white.withOpacity(0.5),
              ),
              const SizedBox(width: 60.0),
              Icon(
                CupertinoIcons.share,
                size: 20.0,
                color: Colors.white.withOpacity(0.5),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

const tweet1 = "Good feedback from FSD Beta 10 users! 10.0.1 point release rolling out now. 10.1 rolls out a week from Friday with beta request button.";
const tweet2 = "The crew of #Inspiration4 had an incredible first day in space! They’ve completed more than 15 orbits around planet Earth since liftoff and made full use of the Dragon cupola.";
const tweet3 = "Just spoke with @inspiration4x crew. All is well.";
const tweet4 = "During their multi-day journey, the @Inspiration4x crew will conduct scientific research designed to advance human health on Earth and during future long-duration spaceflights";
const tweet5 = "Watch Countdown on Netflix about Inspiration4 mission launching today";
const tweet6 = "Our #Inspiration4 crew has completed astronaut training at @SpaceX’s headquarters in Hawthorne, CA and is en route to Kennedy Space Center in Florida for final preparations and launch!";

const tweets = [tweet1, tweet2, tweet3, tweet4, tweet5, tweet6];