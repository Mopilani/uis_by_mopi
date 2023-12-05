import 'package:flutter/material.dart';

class ClubHouseView extends StatelessWidget {
  const ClubHouseView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff1eee4),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  _AppBar(),
                  const SizedBox(height: 24.0),
                  const _Room(
                    title: "Stocks and Options Talk 📈📉",
                    users: 300,
                    talking: 27,
                    image1: "assets/images/clubhouse/user0.jpeg",
                    image2: "assets/images/clubhouse/user1.jpeg",
                  ),
                  const SizedBox(height: 24.0),
                  const _Room(
                    title: "THE ART OF MARKETING: Mastering Social Media 📱",
                    users: 1200,
                    talking: 12,
                    image1: "assets/images/clubhouse/user3.jpeg",
                    image2: "assets/images/clubhouse/user4.jpeg",
                  ),
                  const SizedBox(height: 24.0),
                  const _Room(
                    title: "Talk less, Do more 🎉🎉",
                    users: 1100,
                    talking: 67,
                    image1: "assets/images/clubhouse/user5.jpeg",
                    image2: "assets/images/clubhouse/user6.jpeg",
                  ),
                ],
              ),
            ),
            Align(alignment: Alignment.bottomCenter, child: _BottomBar()),
          ],
        ),
      ),
    );
  }
}

class _Room extends StatelessWidget {
  final String title;
  final int users;
  final int talking;
  final String image1;
  final String image2;

  const _Room({
    Key? key,
    required this.title,
    required this.users,
    required this.talking,
    required this.image1,
    required this.image2,
  }) : super(key: key);

  void open(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return const RoomScreen();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => open(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          width: double.infinity,
          height: 250.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: Colors.white,
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 100.0,
                    width: 60.0,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        FractionalTranslation(
                          translation: const Offset(0.3, 0.3),
                          child: SizedBox(
                            width: 50.0,
                            height: 50.0,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16.0),
                              child: Image.asset(image2),
                            ),
                          ),
                        ),
                        FractionalTranslation(
                          translation: const Offset(-0.1, -0.1),
                          child: SizedBox(
                            width: 50.0,
                            height: 50.0,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16.0),
                              child: Image.asset(image1),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 50.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20.0),
                      const Text("user0 💬",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500)),
                      const Text("user2 💬",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500)),
                      const Text("user3 💬",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500)),
                      const Text("John Doe 💬",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 8.0),
                      Text("$users / $talking"),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(
            Icons.search,
            size: 40.0,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.mark_email_unread_outlined, size: 40.0),
              const SizedBox(width: 24.0),
              const Icon(Icons.calendar_today_outlined, size: 35.0),
              const SizedBox(width: 24.0),
              const Icon(Icons.notifications_none, size: 40.0),
              const SizedBox(width: 24.0),
              SizedBox(
                height: 40.0,
                width: 40.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Image.asset("assets/images/clubhouse/user0.jpeg"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            const Color(0xfff1eee4),
            Colors.white.withOpacity(0.1),
          ],
          stops: const [0.1, 1.0],
        ),
      ),
      child: Stack(
        children: [
          Center(
            child: Container(
              height: 60.0,
              width: 200.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60.0),
                color: const Color(0xff39ab64),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 40.0,
                  ),
                  Text(
                    "Start a room",
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: SizedBox(
                height: 40.0,
                width: 40.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    rowOfDots,
                    rowOfDots,
                    rowOfDots,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

final rowOfDots = Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    dot,
    dot,
    dot,
  ],
);

final Widget dot = Container(
  width: 8.0,
  height: 8.0,
  decoration: BoxDecoration(
    color: Colors.black,
    borderRadius: BorderRadius.circular(15.0),
  ),
);

class RoomScreen extends StatelessWidget {
  const RoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xfff1eee4),
      child: const Padding(
        padding: EdgeInsets.only(top: 60.0),
        child: Column(
          children: [
            _TopBar(),
            SizedBox(height: 40.0),
            Expanded(child: _MainView()),
          ],
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                RotatedBox(
                  quarterTurns: -1,
                  child:
                      Icon(Icons.chevron_left, color: Colors.black, size: 40.0),
                ),
                Text(
                  "All rooms",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.sd_card_alert_outlined, size: 35.0),
                const SizedBox(width: 24.0),
                SizedBox(
                  height: 35.0,
                  width: 35.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Image.asset("assets/images/clubhouse/user0.jpeg"),
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

class _MainView extends StatelessWidget {
  const _MainView();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50.0),
          topRight: Radius.circular(50.0),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(50.0),
          topRight: Radius.circular(50.0),
        ),
        child: Column(
          children: [
            const SizedBox(height: 24.0),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Welcome to clubhouse 🎉",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                  Icon(Icons.more_horiz, color: Colors.black, size: 35.0),
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                itemCount: 12,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (_, index) => _User(
                  name: "user$index",
                  image: "assets/images/clubhouse/user$index.jpeg",
                ),
              ),
            ),
            const _BottomBar2(),
          ],
        ),
      ),
    );
  }
}

class _User extends StatelessWidget {
  final String name;
  final String image;

  const _User({
    Key? key,
    required this.name,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 90.0,
          width: 90.0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(40.0),
            child: Image.asset(image),
          ),
        ),
        const SizedBox(height: 8.0),
        Text(name)
      ],
    );
  }
}

class _BottomBar2 extends StatelessWidget {
  const _BottomBar2();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 60.0, left: 16.0, right: 16.0),
      child: SizedBox(
        height: 90.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 200.0,
              height: 50.0,
              decoration: BoxDecoration(
                color: const Color(0xfff2f2f2),
                borderRadius: BorderRadius.circular(1000),
              ),
              child: const Center(
                child: Text(
                  "✌️ Leave quietly",
                  style: TextStyle(
                    color: Color(0xffe75b5b),
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: BoxDecoration(
                    color: const Color(0xfff2f2f2),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: const Center(
                    child: Icon(Icons.add, size: 30.0),
                  ),
                ),
                const SizedBox(width: 24.0),
                Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: BoxDecoration(
                    color: const Color(0xfff2f2f2),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: const Center(
                    child: Text(
                      "✋🏻",
                      style: TextStyle(
                        fontSize: 28.0,
                      ),
                    ),
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
