import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

class ViewXDLServers extends StatefulWidget {
  const ViewXDLServers({super.key});

  @override
  State<ViewXDLServers> createState() => _ViewXDLServersState();
}

class _ViewXDLServersState extends State<ViewXDLServers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('XDL Servers'),
      ),
      body: FutureBuilder(
        future: () async {
          var file = File('.s.xdl');
          if (await file.exists()) {
            return json.decode(await file.readAsString());
          } else {
            await file.writeAsString(json.encode('[]'));
          }
        }(),
        builder: (context, snap) {
          if (snap.hasError) {
            return Center(child: Text('${snap.error}'));
          }

          if (snap.hasData) {
            return Column(
              children: () {
                var children = <Widget>[];
                for (var host in snap.data) {
                  children.add(ListTile(
                    title: host,
                  ));
                }
                return children;
              }(),
            );
          }

          return const CircularProgressIndicator();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
      ),
    );
  }
}
