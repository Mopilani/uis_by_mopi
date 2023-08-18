import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uis_by_mopi/views/cars_shop_view.dart';
import 'package:uis_by_mopi/views/course_view.dart';
import 'package:uis_by_mopi/views/courses_app.dart';
import 'package:uis_by_mopi/views/login_screen.dart';
import 'package:uis_by_mopi/views/shoes_shoping_app_home.dart';

import 'view_xdl_servers.dart';

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
      const CoursesAppView(),
      'Courses App',
    ),
    Item(
      const CourseView(),
      'Course View',
    ),
    Item(
      const LoginScreen(),
      'Login Screen',
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
