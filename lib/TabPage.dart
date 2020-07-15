import 'package:flutter/material.dart';

class TabPage extends StatefulWidget {
  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> with SingleTickerProviderStateMixin {
  final List<Tab> myTabs = <Tab>[
    Tab(text: 'LEFT'),
    Tab(text: 'RIGHT'),
  ];

  TabController _tabController;
  TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    _tabController.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: myTabs.length);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _textEditingController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: '검색어를 입력하세요.',
                        ),
                        onSubmitted: (text) {

                          showDialog(context: context, builder: (context) {
                            return AlertDialog(title: Text(text), actions: <Widget>[
                              FlatButton(child: Text("확인"), onPressed: () {
                                Navigator.pop(context);
                              },)
                            ],);
                            return Text(text);
                          });
                        },
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                      var text = _textEditingController.text;
                      showDialog(context: context, builder: (context) {
                        return AlertDialog(title: Text(text), actions: <Widget>[
                          FlatButton(child: Text("확인"), onPressed: () {
                            Navigator.pop(context);
                          },)
                        ],);
                        return Text(text);
                      });
                    },
                  )
                ],
              )
            ),
            Container(
              padding: EdgeInsets.only(top: 10),
              child: TabBar(
                labelColor: Colors.black,
                controller: _tabController,
                tabs: myTabs,
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: myTabs.map((Tab tab) {
                  final String label = tab.text.toLowerCase();
                  return Center(
                    child: Text(
                      'This is the $label tab',
                      style: const TextStyle(fontSize: 36),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
