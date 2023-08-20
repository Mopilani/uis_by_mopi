import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:uis_by_mopi/views/connect_to_xdl.dart';

class ViewXDLServers extends StatefulWidget {
  const ViewXDLServers({super.key});

  @override
  State<ViewXDLServers> createState() => _ViewXDLServersState();
}

class _ViewXDLServersState extends State<ViewXDLServers> {
  var xdlServersFile = File('.s.xdl');
  late Timer timer;

  @override
  void initState() {
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
        title: const Text('XDL Servers'),
      ),
      body: FutureBuilder(
        future: () async {
          if (await xdlServersFile.exists()) {
            return json.decode(await xdlServersFile.readAsString());
          } else {
            await xdlServersFile.writeAsString(json.encode([]));
          }
        }(),
        builder: (context, snap) {
          if (snap.hasError) {
            return Center(child: Text('${snap.error}'));
          }

          if (snap.hasData) {
            return ListView.builder(
              itemCount: snap.data.length,
              itemBuilder: (context, index) {
                // for (var host in snap.data) {
                var host = snap.data[index];
                return FutureBuilder<http.Response>(future: () async {
                  // print(host + '/ping');
                  return http.get(Uri.parse(host + '/ping'));
                }(), builder: (context, snap) {
                  return ListTile(
                    onTap: () {
                      Get.to(ConnectToXDL(serverUrl: host));
                    },
                    leading: FutureBuilder<http.Response>(
                      // future: () async {
                      //   // print(host + '/ping');
                      //   return http.get(Uri.parse(host + '/ping'));
                      // }(),
                      builder: (contedxt, snadp) {
                        // print(snap.data?.statusCode);
                        if (snap.hasData) {
                          // print(snap.data!.body);
                          return Icon(
                            Icons.circle,
                            color: snap.data!.statusCode == 200
                                ? Colors.green
                                : Colors.red,
                          );
                        }
                        return const Icon(
                          Icons.circle,
                          color: Colors.red,
                        );
                      },
                    ),
                    title: Text(
                      host,
                      style: const TextStyle(fontSize: 20),
                    ),
                    subtitle: Text(
                      '${snap.data?.body.toString()}',
                      // style: const TextStyle(fontSize: 20),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.disabled_by_default_rounded),
                      color: Colors.red,
                      onPressed: () async {
                        var servers =
                            json.decode(await xdlServersFile.readAsString());

                        servers.remove(host);
                        await xdlServersFile
                            .writeAsString(json.encode(servers));
                        setState(() {});
                      },
                    ),
                  );
                });
                // }
              },
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => connect(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Future connect(context) async {
    TextEditingController linkCont = TextEditingController();
    var msg = ''.obs;

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
              child: Obx(() {
                if (msg.value == '') null;
                return Card(
                  margin: const EdgeInsets.all(100.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text(
                          'Connect to Server',
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
                            hintText: '64.128.250.125:8186',
                            prefix: const Text(
                              'http://',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            suffixIcon: (msg.value == 'Connecting...')
                                ? const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: CircularProgressIndicator(),
                                  )
                                : null,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(width: 16),
                            Text(msg.value),
                          ],
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
                                Get.back();
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
                                msg.value = 'Connecting...';
                                var res = await http.get(
                                    Uri.parse('http://${linkCont.text}/ping'));

                                print('Status 200');
                                if (res.statusCode == 200) {
                                  var servers = json.decode(
                                      await xdlServersFile.readAsString());

                                  await xdlServersFile.writeAsString(
                                    json.encode(
                                      [...servers, 'http://${linkCont.text}'],
                                    ),
                                  );

                                  Get.back();
                                  setState(() {});
                                  Get.to(ConnectToXDL(
                                      serverUrl: 'http://${linkCont.text}'));
                                  return;
                                }
                                msg.value = 'Cannot connect to this server';
                              },
                              child: const Text(
                                'Connect',
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
                );
              }),
            ),
          ),
        );
      },
    );
  }
}
