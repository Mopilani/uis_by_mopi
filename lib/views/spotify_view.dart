import 'package:flutter/material.dart';

class SpotifyView extends StatelessWidget {
  const SpotifyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF191919),
      appBar: AppBar(
        backgroundColor: const Color(0xFF191919),
        elevation: 0,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Icon(Icons.settings_outlined),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(0.8),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books_outlined),
            label: "Library",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shop),
            label: "Premium",
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text(
                "Good afternoon",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 24.0),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AlbumMini(
                    image: 'assets/images/spotify/kendrick.jpg',
                    text: "Kendrick\nLamar",
                  ),
                  AlbumMini(
                    image: 'assets/images/spotify/damn.jpg',
                    text: "Damn",
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8.0),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AlbumMini(
                    image: 'assets/images/spotify/jcole.jpg',
                    text: "J. Cole",
                  ),
                  AlbumMini(
                    image: 'assets/images/spotify/lofi.jpeg',
                    text: "Lo-Fi Beats",
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24.0),
            const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text(
                "Recently Played",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 24.0),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  const SizedBox(width: 16.0),
                  Column(
                    children: [
                      Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(90),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(90),
                          child: Image.asset(
                            'assets/images/spotify/kendrick.jpg',
                            filterQuality: FilterQuality.high,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      const Text(
                        "Kendrick Lamar",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 24.0),
                  Column(
                    children: [
                      Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(90),
                        ),
                        child: Image.asset(
                          'assets/images/spotify/damn.jpg',
                          filterQuality: FilterQuality.high,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      const Text(
                        "Damn",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 24.0),
                  Column(
                    children: [
                      Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(90),
                        ),
                        child: Image.asset(
                          'assets/images/spotify/2014.jpg',
                          filterQuality: FilterQuality.high,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      const Text(
                        "J. Cole - 2014...",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24.0),
            const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text(
                "Recommended for you",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 24.0),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  const SizedBox(width: 16.0),
                  Column(
                    children: [
                      SizedBox(
                        height: 120,
                        width: 120,
                        child: Image.asset(
                          'assets/images/spotify/top50global.PNG',
                          filterQuality: FilterQuality.high,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      const Text(
                        "Top 50 Global",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 24.0),
                  Column(
                    children: [
                      Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(90),
                        ),
                        child: Image.asset(
                          'assets/images/spotify/summerRewind.PNG',
                          filterQuality: FilterQuality.high,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      const Text(
                        "Summer Rewind",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 24.0),
                  Column(
                    children: [
                      Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(90),
                        ),
                        child: Image.asset(
                          'assets/images/spotify/top50italy.PNG',
                          filterQuality: FilterQuality.high,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      const Text(
                        "Top 50 Italy",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
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

class AlbumMini extends StatelessWidget {
  final String image;
  final String text;

  const AlbumMini({
    Key? key,
    required this.image,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 175,
      height: 60,
      decoration: BoxDecoration(
        color: const Color(0xFF313132),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Row(
          children: [
            SizedBox(
              width: 60,
              height: 60,
              child: Image.asset(
                image,
                filterQuality: FilterQuality.high,
              ),
            ),
            const SizedBox(width: 8.0),
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
