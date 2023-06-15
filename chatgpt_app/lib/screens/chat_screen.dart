// import 'dart:convert';

import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:chatgpt_app/Widgets/just_loadingwidget.dart';
import 'package:chatgpt_app/models/api_key.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
// import 'package:http/http.dart' as http;
// import 'package:chatgpt_app/models/api_key.dart';

import 'package:chatgpt_app/Widgets/chat_messages.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<ChatMessages> _messages = [];
  late OpenAI openAI;

  bool _isLoading = false;

  void _addMessage() {
    if (_controller.text.trim().isNotEmpty) {
      // print(ApiKey().apikey);
      setState(() {
        _messages.insert(
            0, ChatMessages(text: _controller.text, sender: "You"));
        gpt4(_controller.text);
      });
    }
    _controller.clear();
  }

  void gpt4(String message) async {
    setState(() {
      _isLoading = true;
    });
    final request = ChatCompleteText(messages: [
      Map.of({"role": "user", "content": message})
    ], maxToken: 200, model: ChatModel.gptTurbo);

    final response = await openAI.onChatCompletion(request: request);
    setState(() {
      _messages.insert(
          0,
          ChatMessages(
              text: response!.choices[0].message!.content, sender: "AI"));
      _isLoading = false;
    });

    // print(response!.choices[0].message!.content);
  }

  @override
  void initState() {
    openAI = OpenAI.instance.build(
        token: ApiKey().apikey,
        baseOption: HttpSetup(
            receiveTimeout: const Duration(seconds: 20),
            connectTimeout: const Duration(seconds: 20)),
        enableLog: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget _inputBar() {
      return Row(
        children: [
          if (_isLoading)
            const Expanded(
                child: Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                JustLoadingWidget(),
                Text(" Loading..."),
              ],
            )),
          if (!_isLoading)
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration.collapsed(
                  hintText: "send a message",
                ),
              ),
            ),
          IconButton(
            onPressed: _addMessage,
            icon: const Icon(Icons.send),
          )
        ],
      ).px16();
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        shadowColor: Color.fromARGB(255, 172, 64, 214),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Hero(
                tag: "chatgpt",
                child: Container(
                    width: 20,
                    height: 20,
                    child: Image.asset("assets/images/logo.png"))),
            Text(
              " Chat GPT",
            )
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
                child: ListView.builder(
              reverse: true,
              padding: Vx.m8,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _messages[index];
              },
            )),
            Container(
              decoration: BoxDecoration(
                color: context.cardColor,
              ),
              child: _inputBar(),
            )
          ],
        ),
      ),
    );
  }
}
