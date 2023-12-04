import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';


class WhatsappChatView extends StatefulWidget {
  const WhatsappChatView({Key? key}) : super(key: key);

  @override
  State<WhatsappChatView> createState() => _WhatsappChatViewState();
}

class _WhatsappChatViewState extends State<WhatsappChatView> {
  final messages = ["test"];

  @override
  Widget build(BuildContext context) {
    final isListEven = messages.length % 2 == 0;

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/background.png"), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: const Icon(Icons.arrow_back),
          title: Row(
            children: [
              Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40.0),
                  image: const DecorationImage(
                      image: AssetImage("assets/dancamdev.png")),
                ),
              ),
              const SizedBox(width: 16.0),
              const Expanded(
                child: SizedBox(
                  height: 40.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Dancamdev"),
                      Text(
                        "Last seen today",
                        style: TextStyle(
                            fontSize: 12.0, fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          actions: const [
            Icon(Icons.video_call, size: 40.0),
            SizedBox(width: 16.0),
            Icon(Icons.call),
            SizedBox(width: 16.0),
            Icon(Icons.more_vert),
            SizedBox(width: 16.0),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                reverse: true,
                itemCount: messages.length,
                itemBuilder: (_, index) {
                  final isSender = isListEven ? index % 2 == 0 : !(index % 2 == 0);

                  return BubbleSpecialOne(
                    text: messages[index],
                    isSender: isSender,
                    color: isSender ? const Color(0xffe2fec9) : Colors.white,
                    textStyle: const TextStyle(fontSize: 18.0), 
                  );
                },
              ),
            ),
            const SizedBox(height: 24.0),
            _WritingRow(
              onMessageSent: (message) =>
                  setState(() => messages.insert(0, message)),
            ),
          ],
        ),
      ),
    );
  }
}

class _WritingRow extends StatefulWidget {
  final Function(String message) onMessageSent;

  const _WritingRow({Key? key, required this.onMessageSent}) : super(key: key);

  @override
  __WritingRowState createState() => __WritingRowState();
}

class __WritingRowState extends State<_WritingRow> {
  final controller = TextEditingController();

  bool showSend = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 60.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40.0),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.emoji_emotions_outlined,
                        size: 40.0,
                        color: Colors.grey[500],
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: TextField(
                          controller: controller,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Message",
                          ),
                          onChanged: (value) =>
                              setState(() => showSend = value.isNotEmpty),
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Icon(
                        Icons.attachment,
                        size: 30.0,
                        color: Colors.grey[500],
                      ),
                      const SizedBox(width: 16.0),
                      Icon(
                        Icons.camera_alt,
                        size: 30.0,
                        color: Colors.grey[500],
                      ),
                      const SizedBox(width: 16.0),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            GestureDetector(
              onTap: () {
                if (controller.text.isNotEmpty) {
                  widget.onMessageSent(controller.text);
                  controller.text = "";
                }
              },
              child: Container(
                width: 60.0,
                height: 60.0,
                decoration: BoxDecoration(
                  color: const Color(0xff208679),
                  borderRadius: BorderRadius.circular(60.0),
                ),
                child: Center(
                  child: !showSend
                      ? const Icon(Icons.mic, color: Colors.white)
                      : const Icon(Icons.send, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(width: 8.0),
          ],
        ),
      ),
    );
  }
}
