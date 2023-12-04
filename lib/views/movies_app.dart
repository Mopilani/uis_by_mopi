import 'package:flutter/material.dart';

class MoviesApp extends StatelessWidget {
  const MoviesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: false,
        title: const Text(
          "Now showing",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: ClipRRect(
          //     borderRadius: BorderRadius.circular(60.0),
          //     child: Image.asset("assets/images/movies/simo.png"),
          //   ),
          // ),
          const SizedBox(width: 8.0),
          const Icon(
            Icons.menu,
            color: Colors.black,
            size: 30.0,
          ),
          const SizedBox(width: 8.0),
        ],
      ),
      body: const SingleChildScrollView(
        child: _Body(),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 30.0,
            child: Row(
              children: [
                Text(
                  "Movies in Rome",
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0,
                  ),
                ),
                RotatedBox(
                  quarterTurns: -1,
                  child: Icon(
                    Icons.chevron_left,
                    color: Colors.grey[700],
                  ),
                )
              ],
            ),
          ),

          // Carousel
          const _Carousel(),

          // All movies
          const Text(
            "All movies",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8.0),

          SizedBox(
            height: 200,
            child: ListView(
              itemExtent: 110,
              scrollDirection: Axis.horizontal,
              children: const [
                _MovieListTile(
                  image: "assets/images/movies/irishman.png",
                  title: "The irishman",
                  length: "3h 29min",
                ),
                _MovieListTile(
                  image: "assets/images/movies/captain.png",
                  title: "Captain Phillips",
                  length: "2h 14min",
                ),
                _MovieListTile(
                  image: "assets/images/movies/mile22.png",
                  title: "Mile 22",
                  length: "1h 34min",
                ),
                _MovieListTile(
                  image: "assets/images/movies/majorgrom.png",
                  title: "Major Grom",
                  length: "2h 18min",
                ),
                _MovieListTile(
                  image: "assets/images/movies/irishman.png",
                  title: "The irishman",
                  length: "3h 29min",
                ),
                _MovieListTile(
                  image: "assets/images/movies/captain.png",
                  title: "Captain Phillips",
                  length: "2h 14min",
                ),
                _MovieListTile(
                  image: "assets/images/movies/mile22.png",
                  title: "Mile 22",
                  length: "1h 34min",
                ),
                _MovieListTile(
                  image: "assets/images/movies/majorgrom.png",
                  title: "Major Grom",
                  length: "2h 18min",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Carousel extends StatelessWidget {
  const _Carousel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 500,
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 150.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: _MovieCard(
                  image: "assets/images/movies/karatekid.png", height: 350),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 80.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: _MovieCard(
                  image: "assets/images/movies/suburra.png", height: 400),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: _MovieCard(
                image: "assets/images/movies/interstellar.png", height: 450),
          ),
        ],
      ),
    );
  }
}

class _MovieCard extends StatelessWidget {
  final String image;
  final double height;

  const _MovieCard({
    Key? key,
    required this.image,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24.0),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              spreadRadius: 30.0,
              blurRadius: 60.0,
            ),
          ],
        ),
        height: height,
        width: height / 4 * 2.7,
        child: Image.asset(image, fit: BoxFit.cover),
      ),
    );
  }
}

class _MovieListTile extends StatelessWidget {
  final String image;
  final String title;
  final String length;

  const _MovieListTile({
    Key? key,
    required this.image,
    required this.title,
    required this.length,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.0,
      width: 130.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Image.asset(image),
            ),
          ),
          const SizedBox(height: 4.0),
          Flexible(
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Flexible(
            child: Text(
              length,
            ),
          ),
        ],
      ),
    );
  }
}
