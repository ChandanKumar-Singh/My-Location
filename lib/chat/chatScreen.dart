import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_location/chat/jsonMessages.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    // final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Chat Screen',
          style: TextStyle(color: Colors.pink),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  color: Colors.grey,
                  width: w,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                        itemCount: messages.length,
                        itemBuilder: (context, i) {
                          return Row(
                            mainAxisAlignment: messages[i]['uid'] == 123
                                ? MainAxisAlignment.start
                                : MainAxisAlignment.end,
                            children: [
                              Column(
                                crossAxisAlignment: messages[i]['uid'] == 123
                                    ? CrossAxisAlignment.start
                                    : CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: messages[i]['uid'] == 123
                                            ? Radius.circular(0)
                                            : Radius.circular(20),
                                        topRight: messages[i]['uid'] == 123
                                            ? Radius.circular(20)
                                            : Radius.circular(0),
                                        bottomRight: Radius.circular(20),
                                        bottomLeft: Radius.circular(20),
                                      ),
                                      color: messages[i]['uid'] == 123
                                          ? Color(0x88DDE784)
                                          : Color(0x746B80C7),
                                    ),
                                    constraints:
                                        BoxConstraints(maxWidth: w * 0.70),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 18.0, vertical: 8),
                                      child: Text(
                                        messages[i]['text'],
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                        softWrap: true,
                                        textAlign: messages[i]['uid'] == 123
                                            ? TextAlign.left
                                            : TextAlign.right,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: formateTime(messages[i]['time']),
                                  ),
                                ],
                              ),
                            ],
                          );
                        }),
                  ),
                ),
              ),
              Container(
                height: 60,
                color: Colors.grey,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white54,
                        ),
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon:
                                    const Icon(Icons.emoji_emotions_outlined)),
                            const Expanded(
                              child: TextField(
                                decoration:
                                    InputDecoration(border: InputBorder.none),
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon:
                                        const Icon(Icons.attach_file_rounded)),
                                IconButton(
                                    onPressed: () {},
                                    icon:
                                        const Icon(Icons.attach_money_rounded)),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.send)),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.green,
                        ),
                        child: IconButton(
                            onPressed: () {}, icon: const Icon(Icons.mic)),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      // bottomNavigationBar: Container(
      //   height: 60,
      //   child: Row(
      //     children: [
      //       Expanded(
      //         child: Container(
      //           decoration: BoxDecoration(
      //             borderRadius: BorderRadius.circular(30),
      //             color: Colors.white38,
      //           ),
      //           child: Row(
      //             children: [
      //               IconButton(
      //                   onPressed: () {},
      //                   icon: const Icon(Icons.emoji_emotions_outlined)),
      //               const Expanded(
      //                 child: TextField(),
      //               ),
      //               IconButton(
      //                   onPressed: () {},
      //                   icon: const Icon(Icons.attach_file_rounded)),
      //               IconButton(
      //                   onPressed: () {},
      //                   icon: const Icon(Icons.attach_money_rounded)),
      //
      //               IconButton(onPressed: () {}, icon: const Icon(Icons.send)),
      //             ],
      //           ),
      //         ),
      //       ),
      //       Padding(
      //         padding: const EdgeInsets.all(4.0),
      //         child: Container(
      //           decoration: BoxDecoration(
      //             borderRadius: BorderRadius.circular(30),
      //             color: Colors.green,
      //           ),
      //           child: IconButton(onPressed: () {}, icon: Icon(Icons.mic)),
      //         ),
      //       )
      //     ],
      //   ),
      // ),
    );
  }

  Widget formateTime(DateTime dateTime) {
    return Text(DateFormat('kk:mm').format(dateTime));
  }
}
