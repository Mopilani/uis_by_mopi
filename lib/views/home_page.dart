import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uis_by_mopi/views/amazon_view.dart';
import 'package:uis_by_mopi/views/cars_shop_view.dart';
import 'package:uis_by_mopi/views/club_house.dart';
import 'package:uis_by_mopi/views/course_view.dart';
import 'package:uis_by_mopi/views/courses_app.dart';
import 'package:uis_by_mopi/views/courses_app_2.dart';
import 'package:uis_by_mopi/views/facebook_view.dart';
import 'package:uis_by_mopi/views/instagram_view.dart';
import 'package:uis_by_mopi/views/login_screen.dart';
import 'package:uis_by_mopi/views/shoes_shoping_app_home.dart';
import 'package:uis_by_mopi/views/movies_app.dart';
import 'package:uis_by_mopi/views/spotify_view.dart';
import 'package:uis_by_mopi/views/twitter_view.dart';
import 'package:uis_by_mopi/views/view_xdl_servers.dart';
import 'package:uis_by_mopi/views/whatsapp_chat_ui.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class Item {
  Item(this.route, this.title);
  Widget route;
  String title;
}

class _HomePageState extends State<HomePage> {
  List<Item> pages = [
    Item(
      const ShoesShopHome(),
      'Shoes Shoping Home',
    ),
    Item(
      const CarsShopView(),
      'Cars Shop View',
    ),
    Item(
      const WhatsappChatView(),
      'Whatsapp Chat',
    ),
    Item(
      const TwitterUiView(),
      'Twitter UI',
    ),
    Item(
      const CoursesAppView(),
      'Courses App',
    ),
    Item(
      const CourseView(),
      'Course View',
    ),
    Item(
      const AmazonView(),
      'Amazon',
    ),
    Item(
      const SpotifyView(),
      'Spotify',
    ),
    Item(
      const MoviesApp(),
      'Movies App',
    ),
    Item(
      const AmazonView(),
      'Amazon App',
    ),
    Item(
      const LoginScreen(),
      'Login Screen',
    ),
    Item(
      const ClubHouseView(),
      'Club House',
    ),
    Item(
      const InstagramView(),
      'Instagram',
    ),
    Item(
      const FacebookView(),
      'Facebook',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          MaterialButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ViewXDLServers(),
                ),
              );
            },
            child: const Text('Connect to XDL'),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: pages.length,
        itemBuilder: (context, index) {
          var page = pages[index];
          return ListTile(
            leading: const Icon(Icons.pages_rounded),
            title: Text(page.title),
            onTap: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => page.route,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
