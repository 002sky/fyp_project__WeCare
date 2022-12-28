import 'package:flutter/material.dart';
import 'package:fyp_project_testing/modal/messageBox.dart';
import 'package:fyp_project_testing/provider/messageProvider.dart';
import 'package:provider/provider.dart';

import '../provider/auth.dart';

class MessageBoxPage extends StatefulWidget {
  String name;
  int receiver;

  MessageBoxPage(this.name, this.receiver, {super.key});

  @override
  State<MessageBoxPage> createState() => _MessageBoxPageState();
}

class _MessageBoxPageState extends State<MessageBoxPage> {
  late int senderID;
  late int receiverID;
  List<MessageBox>? _messageList = [];

  var _isInit = true;
  var _isLoading = false;

  TextEditingController _message = TextEditingController();

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      senderID = Provider.of<Auth>(context, listen: false).userID!;
      receiverID = widget.receiver;

      Provider.of<MessageProvider>(context, listen: false)
          .getAllMessage(senderID, receiverID)
          .then((_) {
        _messageList =
            Provider.of<MessageProvider>(context, listen: false).message;
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(widget.name),
      ),
      body: Column(
        children: <Widget>[
          _isLoading == false
              ? _messageList != null
                  ? Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        itemCount: _messageList!.length,
                        itemBuilder: (context, index) {
                          return Align(
                            alignment: _messageList![index].senderID == senderID
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Flexible(
                              fit: FlexFit.tight,
                              child: Container(
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                child: Text(
                                  _messageList![index].messageText,
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : Expanded(
                      child: Container(),
                    )
              : Expanded(child: Center(child: CircularProgressIndicator())),
          MessageBoxWidget(onSubmitted: (value) {}),
        ],
      ),
    );
  }
}

class MessageBoxWidget extends StatefulWidget {
  final ValueChanged<String> onSubmitted;

  const MessageBoxWidget({
    required this.onSubmitted,
  });

  @override
  _MessageBoxWidgetState createState() => _MessageBoxWidgetState();
}

class _MessageBoxWidgetState extends State<MessageBoxWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 40,
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Enter message...',
                  border: OutlineInputBorder(),
                ),
                onSubmitted: (value) {
                  widget.onSubmitted(value);
                  _controller.clear();
                },
              ),
            ),
            Container(
              width: 60,
              child: OutlinedButton(
                onPressed: () {
                  widget.onSubmitted(_controller.text);
                  _controller.clear();
                },
                child: Icon(Icons.send),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
