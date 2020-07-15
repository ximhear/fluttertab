import 'package:flutter/material.dart';

class TabPage extends StatefulWidget {
  @override
  _TabPageState createState() => _TabPageState();
}
enum PkgTabEnum {
  providers,
  mine,
}

class PkgTab {
  PkgTab({this.text, this.type});
  String text;
  PkgTabEnum type;
}

class _TabPageState extends State<TabPage> with SingleTickerProviderStateMixin {
  final List<PkgTab> myTabs = <PkgTab>[
    PkgTab(text: "LEFT", type: PkgTabEnum.providers),
    PkgTab(text: "RIGHT", type: PkgTabEnum.mine),
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
                          labelText: '패키지 이름',
                            suffixIcon: IconButton(
                              onPressed: () => _textEditingController.clear(),
                              icon: Icon(Icons.clear),
                            )
                        ),
                        onChanged: (value) {
                          debugPrint(value);
                        },
                      ),
                    ),
                  ),
                ],
              )
            ),
            Container(
              padding: EdgeInsets.only(top: 10),
              child: TabBar(
                labelColor: Colors.black,
                controller: _tabController,
                tabs: myTabs.map((e) => Tab(text: e.text)).toList(),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: myTabs.map((PkgTab tab) {
                  if (tab.type == PkgTabEnum.providers) {

                    final String label = tab.text.toLowerCase();
                    return Center(
                      child: Text(
                        'This is the $label tab',
                        style: const TextStyle(fontSize: 36),
                      ),
                    );
                  }
                  else {

                    final String label = tab.text.toLowerCase();
                    return Center(
                      child: Text(
                        'This is the $label tab',
                        style: const TextStyle(fontSize: 36),
                      ),
                    );
                  }
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
