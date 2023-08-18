import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'downloads_view.dart';
import 'view_xdl_servers.dart';

class XDLHomePage extends StatefulWidget {
  const XDLHomePage({super.key});

  @override
  State<XDLHomePage> createState() => _HomePageState();
}

class Item {
  Item(this.route, this.title);
  Widget route;
  String title;
}

class _HomePageState extends State<XDLHomePage> {
  List<Item> pages = [
    Item(
      const ViewXDLServers(),
      'View XDL Servers',
    ),
    Item(
      const DownloadsView(),
      'Downloads View',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('XDL App Home Page')),
      body: GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
        itemCount: pages.length,
        itemBuilder: (context, index) {
          var page = pages[index];
          return InkWell(
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Icon(
                    Icons.pages_rounded,
                    size: 50,
                  ),
                  Text(
                    page.title,
                    style: const TextStyle(fontSize: 22),
                  ),
                ],
              ),
            ),
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
