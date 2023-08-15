import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ConnectToXDL extends StatefulWidget {
  const ConnectToXDL({super.key, required this.serverUrl});
  final String serverUrl;

  @override
  State<ConnectToXDL> createState() => _ConnectToXDLState();
}

class _ConnectToXDLState extends State<ConnectToXDL> {
  var body = {};
  late Timer timer;
  bool connectionLost = true;

  String serverUrl = 'http://167.172.167.245:8186';

  @override
  void initState() {
    serverUrl = widget.serverUrl;
    timer = Timer.periodic(const Duration(seconds: 2), (t) {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connect To XDL'),
        actions: [
          IconButton(
            tooltip: 'Refresh',
            icon: const Icon(Icons.refresh),
            onPressed: connectionLost
                ? null
                : () {
                    setState(() {});
                  },
          ),
          IconButton(
            icon: const Icon(Icons.update_rounded),
            tooltip: 'Recover',
            onPressed: connectionLost
                ? null
                : () async {
                    Get.back();
                    var res = await http.get(Uri.parse('$serverUrl/recover'));
                    if (res.statusCode == 200) {}
                  },
          ),
          MaterialButton(
            onPressed: connectionLost
                ? null
                : () async {
                    onUpdate(context);
                  },
            child: const Text('Update'),
          ),
        ],
      ),
      body: FutureBuilder(
        future: http.get(Uri.parse('$serverUrl/jsapi/tasks')),
        builder: (context, snap) {
          if (snap.hasError) {
            // print(snap.error);
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Waiting for successfull connection',
                    style: TextStyle(fontSize: 32),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(32, 64, 32, 64),
                    child: LinearProgressIndicator(),
                  ),
                  if (!snap.error.toString().contains('The sema') &&
                      !snap.error.toString().contains('A request'))
                    Text('${snap.error}'),
                  if (snap.error.toString().contains('A request'))
                    const Text('Device Not Connected to Internet!'),
                ],
              ),
            );
          }
          if (snap.hasData) {
            body = json.decode(snap.data!.body);
            connectionLost = false;
            return SingleChildScrollView(
              child: Column(
                children: [
                  ...() {
                    List<Widget> children = [];
                    for (var task in body['tasks']) {
                      children.add(
                        ListTile(
                          title: Text(
                            task['link'].split('/').last,
                            // style: const TextStyle(fontSize: 20),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                task['link'],
                                // task.toString(),
                              ),
                              Text(
                                '${!task['running'] ? 'In Waiting List - Retry After: ${task['tryAfter']} - ' : ''}'
                                'Size: ${task['size']} - Downloaded: ${task['downloaded']}',
                              ),
                            ],
                          ),
                          leading: Icon(
                            Icons.circle,
                            color: task['running']
                                ? Colors.yellow
                                : task['finished']
                                    ? Colors.green
                                    : Colors.red,
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.download),
                                onPressed: task['finished']
                                    ? null
                                    : () => onRedownload(
                                          context,
                                          task['link'],
                                        ),
                              ),
                              IconButton(
                                icon: task['running']
                                    ? const Icon(Icons.stop)
                                    : task['finished']
                                        ? const Icon(Icons.download_done)
                                        : const Icon(Icons.play_arrow),
                                onPressed: task['finished'] ? null : () {},
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    return children;
                  }(),
                ],
              ),
            );
          }
          return const LinearProgressIndicator();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: connectionLost
            ? null
            : () {
                addNewTask(context);
              },
        child: const Icon(Icons.add),
      ),
    );
  }

  void onUpdate(context) {
    dialog(context, [
      const Text(
        'Update Server',
        style: TextStyle(
          fontSize: 30,
        ),
      ),
      const Text(
        'All the server tasks will be paused!',
        style: TextStyle(
          fontSize: 18,
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          MaterialButton(
            padding: const EdgeInsets.all(16.0),
            minWidth: 150,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            onPressed: Get.back,
            child: const Text(
              'Cancel',
              style: TextStyle(
                fontSize: 20,
                color: Colors.red,
              ),
            ),
          ),
          MaterialButton(
            padding: const EdgeInsets.all(16.0),
            minWidth: 150,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            color: Colors.black,
            onPressed: () async {
              var res = await http.get(Uri.parse('$serverUrl/shutdown'));
              if (res.statusCode == 200) {
                Get.back();
              }
            },
            child: const Text(
              'Update',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    ]);
  }

  void onRedownload(context, String link) {
    dialog(context, [
      Text(
        'Redownload ${link.split('/').last}',
        style: const TextStyle(
          fontSize: 30,
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          MaterialButton(
            padding: const EdgeInsets.all(16.0),
            minWidth: 150,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            onPressed: Get.back,
            child: const Text(
              'Cancel',
              style: TextStyle(
                fontSize: 20,
                color: Colors.red,
              ),
            ),
          ),
          MaterialButton(
            padding: const EdgeInsets.all(16.0),
            minWidth: 150,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            color: Colors.black,
            onPressed: () async {
              var res = await http.post(Uri.parse('$serverUrl/redown'),
                  headers: {'link': link});
              if (res.statusCode == 200) {
                Get.back();
              }
            },
            child: const Text(
              'Redownload',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    ]);
  }

  Future addNewTask(context) async {
    TextEditingController linkCont = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Material(
            color: Colors.transparent,
            child: GestureDetector(
              onTap: () {},
              child: Card(
                margin: const EdgeInsets.all(100.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        'Add Task',
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      TextField(
                        controller: linkCont,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          hintText: 'Your link here...',
                        ),
                        onChanged: (t) {},
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          MaterialButton(
                            padding: const EdgeInsets.all(16.0),
                            minWidth: 150,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Cancel',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.red,
                              ),
                            ),
                          ),
                          MaterialButton(
                            padding: const EdgeInsets.all(16.0),
                            minWidth: 150,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            color: Colors.black,
                            onPressed: () async {
                              if (linkCont.text.isEmpty) {
                                return;
                              }
                              var res = await http
                                  .post(Uri.parse('$serverUrl/add'), headers: {
                                'link': linkCont.text,
                              });
                              if (res.statusCode == 200) {
                                // ignore: use_build_context_synchronously
                                Navigator.pop(context);
                              }
                            },
                            child: const Text(
                              'Add Task',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void dialog(context, children) {
    showDialog(
        context: context,
        builder: (context) {
          return GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Material(
                color: Colors.transparent,
                child: GestureDetector(
                    onTap: () {},
                    child: Card(
                        margin: const EdgeInsets.all(100.0),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: children),
                        ))),
              ));
        });
  }
}
