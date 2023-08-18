import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'connect_to_xdl.dart';

class DownloadsView extends StatefulWidget {
  const DownloadsView({super.key});

  @override
  State<DownloadsView> createState() => _DownloadsViewState();
}

class _DownloadsViewState extends State<DownloadsView> {
  List<DownloadedItem> items = [];
  var itemsCounter = 0;
  var saveFile = File('file.maf.json');

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
                onAddItem(context);
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: () {
          itemsCounter = 0;
          return items.map(
            (e) {
              itemsCounter++;
              return ListTile(
                tileColor: itemsCounter.isEven ? null : Colors.black12,
                title: SelectableText(e.title),
                trailing: MaterialButton(
                  child: const Text('Add Part'),
                  onPressed: () {
                    onAddPart(context, itemsCounter - 1);
                  },
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SelectableText(e.link),
                    ...e.parts
                        .map(
                          (e) => Row(
                            children: [
                              SelectableText('${e.title} | ${e.link}'),
                            ],
                          ),
                        )
                        .toList(),
                  ],
                ),
              );
            },
          ).toList();
        }(),
      ),
    );
  }

  void onAddItem(context) {
    TextEditingController linkCont = TextEditingController();
    TextEditingController titleCont = TextEditingController();

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
              var item = DownloadedItem();
              item.title = titleCont.text;
              item.link = linkCont.text;
              items.add(item);
              setState(() {});
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

  void onAddPart(context, index) {
    TextEditingController linkCont = TextEditingController();
    TextEditingController titleCont = TextEditingController();
    TextEditingController sizeCont = TextEditingController();
    TextEditingController downloadedCont = TextEditingController();
    TextEditingController whoWantItCont = TextEditingController();
    FocusNode whoWantItNode = FocusNode();
    TextEditingController whoHaveItCont = TextEditingController();
    FocusNode whoHaveItNode = FocusNode();
    RxList<String> whoHaveIt = <String>[].obs;
    RxList<String> whoWantIt = <String>[].obs;
    var downloaded = false.obs;
    var checked = false.obs;
    var uploaded = false.obs;

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
          onChanged: (t) {},
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
          ],
        );
      }),
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
              var part = DownloadedPart();
              part.title = titleCont.text;
              part.link = linkCont.text;
              if (int.tryParse(sizeCont.text) != null) {
                part.size = int.parse(linkCont.text);
              }
              if (int.tryParse(downloadedCont.text) != null) {
                part.downloadedBytes = int.parse(linkCont.text);
              }
              part.downloaded = downloaded.value;
              part.checked = checked.value;
              part.uploaded = uploaded.value;
              part.whoWantIt = whoWantIt.toList();
              part.whoHaveIt = whoHaveIt.toList();
              items[index].parts.add(part);
              setState(() {});
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

  Map<String, dynamic> asMap() => {
        'link': link,
        'title': title,
        'parts': parts.map((e) => e.asMap()).toList(),
      };

  static DownloadedItem fromMap(Map data) {
    DownloadedItem part = DownloadedItem();
    part.title = data['title'];
    part.link = data['link'];
    part.parts = data['parts'];
    return part;
  }
}

class DownloadedPart {
  DownloadedPart();

  late String title, link;

  int size = 0, downloadedBytes = 0;
  bool downloaded = false, checked = false, uploaded = false;

  List<String> whoWantIt = [];
  List<String> whoHaveIt = [];

  Map<String, dynamic> asMap() => {
        'title': title,
        'link': link,
        'size': size,
        'downloadedBytes': downloadedBytes,
        'downloaded': downloaded,
        'checked': checked,
        'uploaded': uploaded,
        'whoWantIt': whoWantIt,
        'whoHaveIt': whoHaveIt,
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
    part.whoWantIt = data['whoWantIt'];
    part.whoHaveIt = data['whoHaveIt'];
    return part;
  }
}
