import 'package:flutter/material.dart';
import 'package:fyp_project_testing/page/MessageBoxPage.dart';
import 'package:fyp_project_testing/provider/auth.dart';
import 'package:fyp_project_testing/provider/messageProvider.dart';
import 'package:provider/provider.dart';

class MessageBoxMainPage extends StatefulWidget {
  const MessageBoxMainPage({super.key});

  @override
  State<MessageBoxMainPage> createState() => _MessageBoxMainPageState();
}

class _MessageBoxMainPageState extends State<MessageBoxMainPage> {
  String _searchTerm = '';
  var _isInit = true;
  var _isLoading = false;
  List<Map<String, dynamic>>? listOfReceiver = [];

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      bool usertype = Provider.of<Auth>(context, listen: false).isAdmin;

      Provider.of<MessageProvider>(
        context,
        listen: false,
      ).getMessageBoxList(usertype).then((_) {
        listOfReceiver =
            Provider.of<MessageProvider>(context, listen: false).listOfReceiver;

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
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('Message'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children: [
          TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Search...',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              // Perform search action here
              setState(() {
                _searchTerm = value;
              });
            },
          ),
          ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: listOfReceiver!.length,
              itemBuilder: (context, index) {
                final item = listOfReceiver![index]['name'];
                if (item.contains(_searchTerm)) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        title: Text(listOfReceiver![index]['name'].toString()),
                        leading: Text(listOfReceiver![index]['id'].toString()),
                        trailing: IconButton(
                          icon: Icon(Icons.message_outlined),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    MessageBoxPage(
                                        listOfReceiver![index]['name']
                                            .toString(),
                                        listOfReceiver![index]['id']),
                                fullscreenDialog: true,
                              ),
                            );
                          },
                        )),
                  );
                }
                return Container();
              })
        ],
      ),
    );
  }
}
