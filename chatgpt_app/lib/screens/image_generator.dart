import 'dart:convert';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:chatgpt_app/Widgets/just_loadingwidget.dart';
import 'package:chatgpt_app/Widgets/loading_widget.dart';
import 'package:chatgpt_app/models/api_key.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'package:image_downloader/image_downloader.dart';

class ImageGenerator extends StatefulWidget {
  const ImageGenerator({super.key});

  @override
  State<ImageGenerator> createState() => _ImageGeneratorState();
}

class _ImageGeneratorState extends State<ImageGenerator> {
  final TextEditingController _input = TextEditingController();
  late OpenAI openAI;
  bool _imageGenerated = false;

  late Widget _body = const Center(
      child: Text(
    "No images Yet",
    style: TextStyle(color: Colors.white),
  ));

  bool _loading = false;
  void _makeRequest() {
    String prompt = _input.text;
    _input.clear();
    _getImage(prompt);
  }

  void _getImage(String prompt) async {
    setState(() {
      _loading = true;
    });
    final response = await http.post(
        Uri.parse("https://api.openai.com/v1/images/generations"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${ApiKey().apikey}",
        },
        body: jsonEncode({"prompt": prompt, "n": 2, "size": "1024x1024"}));
    final url = jsonDecode(response.body)["data"][0]['url'];
    print(jsonDecode(response.body)["data"][0]['url']);
    setState(() {
      _body = Image.network(
        url,
        fit: BoxFit.fill,
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
            ),
          );
        },
      );
      _imageGenerated = true;
      _loading = false;
    });
  }

  Widget content() {
    return SafeArea(
      child: Column(children: [
        if (!_loading)
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  if (_imageGenerated)
                    const SizedBox(
                      height: 150,
                    ),
                  _body,
                  if (_imageGenerated)
                    const SizedBox(
                      height: 25,
                    ),
                  if (_imageGenerated)
                    Align(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                            onPressed: () {}, child: Text("Download"))),
                ],
              ),
            ),
          ),
        if (_loading) const Expanded(child: SizedBox()),
        if (_loading) const LoadingWidget(),
        if (_loading) const Expanded(child: SizedBox()),
        Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            children: [
              if (_loading)
                Expanded(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      JustLoadingWidget(),
                      Text(" Loading..."),
                    ],
                  ),
                ),
              if (!_loading)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: TextField(
                      controller: _input,
                      decoration: const InputDecoration.collapsed(
                        hintText: "Send a message",
                      ),
                    ),
                  ),
                ),
              IconButton(
                onPressed: () {
                  _makeRequest();
                },
                icon: const Icon(Icons.send),
              ),
            ],
          ),
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        shadowColor: Color.fromARGB(255, 172, 64, 214),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Hero(
                tag: "dalle",
                child: Container(
                    width: 20,
                    height: 20,
                    child: Image.asset("assets/images/logo.png"))),
            Text(
              " DALL·E",
            )
          ],
        ),
      ),
      body: content(),
    );
  }
}
