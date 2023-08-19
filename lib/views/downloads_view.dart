import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'connect_to_xdl.dart';
import 'dl_list_tile.dart';

class DownloadsView extends StatefulWidget {
  const DownloadsView({super.key});

  @override
  State<DownloadsView> createState() => _DownloadsViewState();
}

class _DownloadsViewState extends State<DownloadsView> {
  RxList<DownloadedItem> items = <DownloadedItem>[].obs;
  var saveFile = File('file.maf.json');
  RxInt downloadedCount = 0.obs;
  RxInt uploadedCount = 0.obs;
  RxInt checkedCount = 0.obs;

  @override
  void initState() {
    saveFile.readAsString().then((data) {
      var jsn = json.decode(data);
      for (var d in jsn) {
        var item = DownloadedItem.fromMap(d);
        items.add(item);
      }
    });
    super.initState();
  }

  void reCount() {
    downloadedCount.value = 0;
    uploadedCount.value = 0;
    checkedCount.value = 0;
    for (var e in items) {
      for (int i = 0; i < e.parts.length; i++) {
        var p = e.parts[i];
        if (p.downloaded) downloadedCount.value++;
        if (p.uploaded) uploadedCount.value++;
        if (p.checked) checkedCount.value++;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Downloads View'),
        actions: [
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: CircularProgressIndicator(),
          // ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                onAddItem(context, null);
              },
            ),
          ),
        ],
        flexibleSpace: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Obx(() {
                return Text(
                  'Downloaded: $downloadedCount  |  Checked: $checkedCount  |  Uploaded: $uploadedCount',
                );
              }),
            ),
          ],
        ),
      ),
      body: Obx(() {
        Future.delayed(const Duration(seconds: 1), () => reCount());
        return ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            var e = items[index];
            return DLListTile(
              tileColor: index.isEven ? Colors.black26 : Colors.black12,
              leading: Column(
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      onAddItem(context, index);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    color: Colors.red,
                    onPressed: () {
                      deleteItem(context, index);
                    },
                  ),
                ],
              ),
              trailing: Column(
                children: [
                  MaterialButton(
                    child: const Text('Add Part'),
                    onPressed: () {
                      onAddPart(context, index, null);
                    },
                  ),
                  Column(
                    children: e.parts.map((part) {
                      return Row(
                        children: [
                          SizedBox(
                            width: 25,
                            child: IconButton(
                              iconSize: 15,
                              padding: const EdgeInsets.all(2),
                              onPressed: () {},
                              color: part.uploaded ? Colors.green : Colors.red,
                              icon: const Icon(Icons.circle),
                            ),
                          ),
                          SizedBox(
                            width: 25,
                            child: IconButton(
                              iconSize: 15,
                              padding: const EdgeInsets.all(2),
                              onPressed: () {},
                              color: part.checked ? Colors.green : Colors.red,
                              icon: const Icon(Icons.circle),
                            ),
                          ),
                          SizedBox(
                            width: 25,
                            child: IconButton(
                              iconSize: 15,
                              onPressed: () {
                                part.downloaded = !part.downloaded;
                                var dryItems =
                                    items.map((e) => e.asMap()).toList();
                                var jsn = json.encode(dryItems);
                                saveFile.writeAsString(jsn);
                                Get.back();
                              },
                              padding: const EdgeInsets.all(2),
                              color:
                                  part.downloaded ? Colors.green : Colors.red,
                              icon: const Icon(Icons.circle),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  )
                ],
              ),
              title: SizedBox(height: 20, child: SelectableText(e.title)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SelectableText(e.link),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: e.parts.length,
                    itemBuilder: (context, partIndex) {
                      var p = e.parts[partIndex];
                      return Row(
                        children: [
                          Expanded(
                            child: SelectableText(
                                '${partIndex + 1}: ${p.link.contains('part') ? p.link.substring(p.link.indexOf('part'), p.link.indexOf('part') + 5) : p.link} | ${p.link}'),
                          ),
                          SizedBox(
                            height: 25,
                            child: IconButton(
                              icon: const Icon(Icons.edit),
                              iconSize: 15,
                              padding: const EdgeInsets.all(4),
                              onPressed: () {
                                onAddPart(context, index, partIndex);
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }

  void onAddItem(BuildContext context, int? index) {
    TextEditingController linkCont = TextEditingController();
    TextEditingController titleCont = TextEditingController();
    TextEditingController whoWantItCont = TextEditingController();
    FocusNode whoWantItNode = FocusNode();
    TextEditingController whoHaveItCont = TextEditingController();
    FocusNode whoHaveItNode = FocusNode();
    RxList<String> whoHaveIt = <String>[].obs;
    RxList<String> whoWantIt = <String>[].obs;

    if (index != null) {
      var item = items[index];
      linkCont.text = item.link;
      titleCont.text = item.title;
      whoHaveIt.addAll(item.whoHaveIt);
      whoWantIt.addAll(item.whoWantIt);
    }

    dialog(context, [
      const Text(
        'Add Item',
        style: TextStyle(
          fontSize: 30,
        ),
      ),
      TextField(
        controller: titleCont,
        decoration: InputDecoration(
          labelText: 'Title',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          hintText: 'Download title here...',
        ),
        onChanged: (t) {},
      ),
      TextField(
        controller: linkCont,
        decoration: InputDecoration(
          labelText: 'Link',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          hintText: 'Your link here...',
        ),
        onChanged: (t) {
          try {
            titleCont.text = (t.split('/').last.toUpperCase());
          } catch (e) {
            //
          }
        },
      ),
      Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 40,
              child: TextField(
                controller: whoWantItCont,
                focusNode: whoWantItNode,
                decoration: InputDecoration(
                  labelText: 'Who want it',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  contentPadding: const EdgeInsets.all(4),
                  hintText: 'example@email.com',
                ),
                onChanged: (t) {},
                onSubmitted: (t) {
                  whoWantIt.add(t);
                  whoWantItCont.clear();
                  whoWantItNode.requestFocus();
                },
              ),
            ),
          ),
          const SizedBox(width: 32),
          Expanded(
            child: SizedBox(
              height: 40,
              child: TextField(
                controller: whoHaveItCont,
                focusNode: whoHaveItNode,
                decoration: InputDecoration(
                  labelText: 'Who have it',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  contentPadding: const EdgeInsets.all(4),
                  hintText: 'example@email.com',
                ),
                onChanged: (t) {},
                onSubmitted: (t) {
                  whoHaveIt.add(t);
                  whoHaveItCont.clear();
                  whoHaveItNode.requestFocus();
                },
              ),
            ),
          ),
        ],
      ),
      Obx(() {
        return Wrap(
          children: [
            const Text('Want it: '),
            ...whoWantIt.map((e) => Text('$e, ')).toList()
          ],
        );
      }),
      Obx(() {
        return Wrap(
          children: [
            const Text('Have it: '),
            ...whoHaveIt.map((e) => SelectableText('$e, ')).toList()
          ],
        );
      }),
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
              if (titleCont.text.isEmpty) return;
              DownloadedItem item;
              if (index != null) {
                item = items[index];
              } else {
                item = DownloadedItem();
              }
              item.title = titleCont.text;
              item.link = linkCont.text;
              item.whoWantIt = whoWantIt.toList();
              item.whoHaveIt = whoHaveIt.toList();
              if (index != null) {
                items[index] = (item);
              } else {
                items.add(item);
              }
              setState(() {});
              // var res = await http.get(Uri.parse('$serverUrl/shutdown'));
              // print(res.body);
              // if (res.statusCode == 200) {
              var dryItems = items.map((e) => e.asMap()).toList();
              var jsn = json.encode(dryItems);
              saveFile.writeAsString(jsn);
              Get.back();
            },
            child: Text(
              index == null ? 'Add' : 'Update',
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    ]);
  }

  void deleteItem(BuildContext context, int? index) {
    dialog(context, [
      const Text(
        'Delete Item',
        style: TextStyle(
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
              items.removeAt(index!);
              var dryItems = items.map((e) => e.asMap()).toList();
              var jsn = json.encode(dryItems);
              saveFile.writeAsString(jsn);
              Get.back();
            },
            child: const Text(
              'Delete',
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

  void onAddPart(BuildContext context, int index, int? partindex) {
    TextEditingController linkCont = TextEditingController();
    TextEditingController titleCont = TextEditingController();
    TextEditingController sizeCont = TextEditingController();
    TextEditingController downloadedCont = TextEditingController();
    var downloaded = false.obs;
    var checked = false.obs;
    var uploaded = false.obs;
    var multiAdd = false.obs;

    if (partindex != null) {
      var part = items[index].parts[partindex];
      linkCont.text = part.link;
      titleCont.text = part.title;
      checked.value = part.checked;
      downloaded.value = part.downloaded;
      uploaded.value = part.uploaded;
      downloadedCont.text = part.downloadedBytes.toString();
      sizeCont.text = part.size.toString();
    }

    dialog(context, [
      const Text(
        'Add Part',
        style: TextStyle(
          fontSize: 30,
        ),
      ),
      SizedBox(
        height: 40,
        child: TextField(
          controller: titleCont,
          decoration: InputDecoration(
            labelText: 'Title',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            contentPadding: const EdgeInsets.all(4),
            hintText: 'Download title here...',
          ),
          onChanged: (t) {},
        ),
      ),
      SizedBox(
        height: 40,
        child: TextField(
          controller: linkCont,
          decoration: InputDecoration(
            labelText: 'Link',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            contentPadding: const EdgeInsets.all(4),
            hintText: 'Your link here...',
          ),
          onChanged: (t) {
            try {
              titleCont.text = (t.split('/').last.toUpperCase());
            } catch (e) {
              //
            }
          },
        ),
      ),
      Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 40,
              child: TextField(
                controller: sizeCont,
                decoration: InputDecoration(
                  labelText: 'Size',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  contentPadding: const EdgeInsets.all(4),
                  hintText: '4,234,567,890',
                ),
                onChanged: (t) {},
              ),
            ),
          ),
          const SizedBox(width: 32),
          Expanded(
            child: SizedBox(
              height: 40,
              child: TextField(
                controller: downloadedCont,
                decoration: InputDecoration(
                  labelText: 'Downloaded',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  contentPadding: const EdgeInsets.all(4),
                  hintText: '4,234,567,890',
                ),
                onChanged: (t) {},
              ),
            ),
          ),
        ],
      ),
      Obx(() {
        return Row(
          children: [
            Expanded(
              child: CheckboxListTile(
                value: downloaded.value,
                onChanged: (v) => downloaded.value = v ?? false,
                title: const Text('Downloaded'),
              ),
            ),
            Expanded(
              child: CheckboxListTile(
                value: checked.value,
                onChanged: (v) => checked.value = v ?? false,
                title: const Text('Checked'),
              ),
            ),
            Expanded(
              child: CheckboxListTile(
                value: uploaded.value,
                onChanged: (v) => uploaded.value = v ?? false,
                title: const Text('Uploaded'),
              ),
            ),
            Expanded(
              child: CheckboxListTile(
                value: multiAdd.value,
                onChanged: (v) => multiAdd.value = v ?? false,
                title: const Text('Multi Add'),
              ),
            ),
          ],
        );
      }),
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
              if (titleCont.text.isEmpty) return;
              DownloadedPart part;
              List<String> links = [];
              if (multiAdd.value) {
                links = linkCont.text.split('http');
                links.remove('');
                links = links.map((link) => 'http$link').toList();
              } else {
                links.add(linkCont.text);
              }
              for (int i = 0; i < links.length; i++) {
                var link = links[i];
                if (partindex != null && !multiAdd.value) {
                  part = items[index].parts[partindex];
                } else {
                  part = DownloadedPart();
                }
                // print(links); // print(links.length); // return; // if (multiAdd.value) { dynamic link = linkCont.text;
                //   link = link.split(link.substring(link.indexOf('part'), 1)); link = link.join('part${i + 1}');  linkCont.text = link;
                //   // p.link.contains('part') ? p.link.substring(p.link.indexOf('part'), p.link.indexOf('part') + 5) : p.link | p.link
                // }
                part.title = titleCont.text;
                if (multiAdd.value) {
                  part.link = link;
                } else {
                  part.link = linkCont.text;
                }
                if (int.tryParse(sizeCont.text) != null) {
                  part.size = int.parse(sizeCont.text);
                }
                if (int.tryParse(downloadedCont.text) != null) {
                  part.downloadedBytes = int.parse(downloadedCont.text);
                }
                part.downloaded = downloaded.value;
                part.checked = checked.value;
                part.uploaded = uploaded.value;
                if (partindex != null) {
                  part = items[index].parts[partindex] = part;
                } else {
                  items[index].parts.add(part);
                }
              }
              // return;
              // setState(() {});
              // var res = await http.get(Uri.parse('$serverUrl/shutdown'));
              // print(res.body);
              // if (res.statusCode == 200) {
              var dryItems = items.map((e) => e.asMap()).toList();
              var jsn = json.encode(dryItems);
              saveFile.writeAsString(jsn);
              Get.back();
              // }
            },
            child: const Text(
              'Add',
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
}

class DownloadedItem {
  DownloadedItem();

  late String title, link;

  List<DownloadedPart> parts = [];

  List<String> whoWantIt = [];
  List<String> whoHaveIt = [];

  Map<String, dynamic> asMap() => {
        'link': link,
        'title': title,
        'whoWantIt': whoWantIt,
        'whoHaveIt': whoHaveIt,
        'parts': parts.map((e) => e.asMap()).toList(),
      };

  static DownloadedItem fromMap(Map data) {
    DownloadedItem part = DownloadedItem();
    part.title = data['title'];
    part.link = data['link'];
    part.whoWantIt = <String>[...data['whoWantIt'] ?? []];
    part.whoHaveIt = <String>[...data['whoHaveIt'] ?? []];
    part.parts = <DownloadedPart>[
      ...(data['parts'])
          .map(
            (e) => DownloadedPart.fromMap(e),
          )
          .toList()
    ];
    return part;
  }
}

class DownloadedPart {
  DownloadedPart();

  late String title, link;

  int size = 0, downloadedBytes = 0;
  bool downloaded = false, checked = false, uploaded = false;

  Map<String, dynamic> asMap() => {
        'title': title,
        'link': link,
        'size': size,
        'downloadedBytes': downloadedBytes,
        'downloaded': downloaded,
        'checked': checked,
        'uploaded': uploaded,
      };

  static DownloadedPart fromMap(Map data) {
    DownloadedPart part = DownloadedPart();
    part.title = data['title'];
    part.link = data['link'];
    part.size = data['size'];
    part.downloadedBytes = data['downloadedBytes'];
    part.downloaded = data['downloaded'];
    part.checked = data['checked'];
    part.uploaded = data['uploaded'];
    return part;
  }
}
