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

  var running = 0.obs;
  var waiting = 0.obs;
  var finished = 0.obs;
  var started = 0.obs;

  String serverUrl = 'http://167.172.167.245:8186';

  @override
  void initState() {
    serverUrl = widget.serverUrl;
    timer = Timer.periodic(const Duration(milliseconds: 5000), (t) {
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
        title: Text('Connected to $serverUrl'),
        flexibleSpace: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 170, 16),
          child: Obx(() {
            return Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Waiting: $waiting - ',
                  style: const TextStyle(fontSize: 18),
                ),
                Text(
                  'Finished: $finished - ',
                  style: const TextStyle(fontSize: 18),
                ),
                Text(
                  'Started: $started -  ',
                  style: const TextStyle(fontSize: 18),
                ),
                Text(
                  'Running: $running',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            );
          }),
        ),
        actions: [
          IconButton(
            tooltip: 'Refresh',
            icon: const Icon(Icons.refresh),
            onPressed: connectionLost
                ? null
                : () {
                    // setState(() {});
                  },
          ),
          IconButton(
            icon: const Icon(Icons.update_rounded),
            tooltip: 'Recover',
            onPressed: connectionLost
                ? null
                : () async {
                    print('Recovering...');
                    var res = await http.get(Uri.parse('$serverUrl/recover'));
                    print('StatusCode: ${res.statusCode}');
                    print(res.body);
                    if (res.statusCode == 200) {
                      print('MSG: ${res.body}');
                    }
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
            Future.delayed(const Duration(milliseconds: 100), () {
              running.value = 0;
              waiting.value = 0;
              finished.value = 0;
              started.value = 0;
            });
            body = json.decode(snap.data!.body);
            var idx = 0;
            List<Map> tasks = (body['tasks'] as List)
                .map(
                  (e) {
                    Future.delayed(const Duration(milliseconds: 100), () {
                  if (e['running'] ?? false) running.value++;
                  if (e['waiting'] ?? false) waiting.value++;
                  if (e['finished'] ?? false) finished.value++;
                  if (e['started'] ?? false) started.value++;
                });
                    return {++idx: e};
                  },
                )
                .toList()
                .reversed
                .toList();
            connectionLost = false;
            return ListView.builder(
              itemCount: body['tasks'].length + 1,
              itemBuilder: (context, index) {
                if (body['tasks'].length == index) {
                  return const SizedBox(height: 80);
                }
                // for (var task in body['tasks']) {
                var task = tasks[index].values.first;
                // print(index);

                // children.add(
                return ListTile(
                  title: SelectableText(
                    task['link'].split('/').last,
                    // style: const TextStyle(fontSize: 20),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SelectableText(
                            task['link'],
                          ),
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => refreshLink(context, task['link']),
                          )
                        ],
                      ),
                      SelectableText(
                        '${!task['running'] ? 'In Waiting List - Retry After: ${task['tryAfter']} - ' : ''}'
                        'Size: ${nformate(task['size'])} - Downloaded: ${nformate(task['downloaded'])}',
                      ),
                    ],
                  ),
                  leading: CircleAvatar(
                    // Icons.circle,
                    backgroundColor: task['running']
                        ? Colors.yellow
                        : task['finished']
                            ? Colors.green
                            : Colors.red,
                    child: Text((tasks[index].keys.first).toString()),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.delete),
                        color: Colors.red,
                        onPressed: () async {
                          var res = await http.get(
                            Uri.parse('$serverUrl/remove'),
                            headers: {'link': task['link']},
                          );
                          print(res.body);
                          if (res.statusCode == 200) {
                            setState(() {});
                          }
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.download),
                        onPressed: () => onRedownload(context, task['link']),
                      ),
                      IconButton(
                        icon: task['running']
                            ? const Icon(Icons.stop)
                            : task['finished']
                                ? const Icon(Icons.download_done)
                                : const Icon(Icons.play_arrow),
                        onPressed: task['finished']
                            ? null
                            : task['running']
                                ? () async {
                                    var res = await http.get(
                                      Uri.parse('$serverUrl/stop'),
                                      headers: {'link': task['link']},
                                    );
                                    print(res.body);
                                    if (res.statusCode == 200) {}
                                  }
                                : () async {
                                    var res = await http.get(
                                      Uri.parse('$serverUrl/resume'),
                                      headers: {'link': task['link']},
                                    );
                                    print(res.body);
                                    if (res.statusCode == 200) {}
                                  },
                      ),
                    ],
                  ),
                );
                // ),
                // }
                // );
                // return children;
              },
              // ],
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
              print(res.body);
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
              print(res.body);
              if (res.statusCode == 200) Get.back();
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
    var fastDownload = false.obs;
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
                      SizedBox(
                        height: 50,
                        width: 200,
                        child: Row(
                          children: [
                            Obx(() {
                              return Expanded(
                                child: CheckboxListTile(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  title: const Text('Fast Download'),
                                  value: fastDownload.value,
                                  onChanged: (v) => fastDownload.value =
                                      v ?? fastDownload.value,
                                ),
                              );
                            })
                          ],
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
                              http.Response res;
                              if (fastDownload.value) {
                                res = await http.post(
                                    Uri.parse('$serverUrl/fdl'),
                                    headers: {
                                      'link': linkCont.text,
                                    });
                              } else {
                                res = await http.post(
                                    Uri.parse('$serverUrl/add'),
                                    headers: {
                                      'link': linkCont.text,
                                    });
                              }
                              print(res.body);
                              if (res.statusCode == 200) Get.back();
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

  Future refreshLink(context, oldlink) async {
    TextEditingController linkCont = TextEditingController(text: oldlink);
    dialog(context, [
      const Text(
        'Update Link',
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
          hintText: 'Your link new here...',
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
              var res =
                  await http.get(Uri.parse('$serverUrl/refresh/na'), headers: {
                'link': oldlink,
                'nLink': linkCont.text,
              });
              print(res.body);
              if (res.statusCode == 200) Get.back();
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

String nformate(int nm) {
  if (nm.toString().length < 3) return nm.toString();
  // return nm.toString();
  var segs = <String>[];
  for (int i = 0; i < nm.toString().length; null) {
    var seg = '';
    var nmstr = nm.toString().split('').reversed.toList();
    for (var j = 0; j < 3; j++) {
      try {
        seg += nmstr[i + 1 > nm.toString().length ? i : i++];
      } catch (e) {
        // print(e);
      }
    }
    segs.add(seg.split('').reversed.join());
  }
  return segs.reversed.toList().join(',');
}
