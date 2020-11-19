

import 'package:flutter/material.dart';

class ImageShow extends StatelessWidget {
  
  @override 
  Widget build(BuildContext context) {
    // Widget divider1 = Divider(color: Colors.blue);
    // Widget divider2 = Divider(color: Colors.yellow,);

    return Scaffold(
      appBar: AppBar(
        title: Text("image Show"),
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return ShowImageWidget();
          } 
          return ListTile(title: Text("$index"));
        },
        itemCount: 3,
        itemExtent: 1240,
      ),
    );
  }


}

class ShowImageWidget extends StatefulWidget {

  @override 
  _ShowImageState createState() => _ShowImageState();
}

class _ShowImageState extends State<ShowImageWidget> {
  // const _ShowImageState({Key key, @required this._expland, this._imageList,}): super(key: key);
  bool _expland = false;
  final List _imageList = ["https://pic4.58cdn.com.cn/p1/big/n_v26f39ae558ef44ac790a4c8113de8f116.jpg", "https://pic4.58cdn.com.cn/p1/big/n_v288659a1ad46047f5aa687d1ab6a8d820.jpg", "https://pic4.58cdn.com.cn/p1/big/n_v238dadfc5d47d4fb6b17122d752f27960.jpg", "https://pic4.58cdn.com.cn/p1/big/n_v2d0f47e91da4348e4b9688f3e69a10e4c.jpg"];  
  // List imageList

  final int CarMidImageUnFoldMaxCount = 3;

  Widget build(BuildContext context) {
    return Column(
      children: _buildImageShow(),
    );
  }

  List<Widget> _buildImageShow() {
    if (_imageList.length < CarMidImageUnFoldMaxCount) {
      return _buildAllImage();
    }

    List<Widget> widgetList = List();
    if (_expland) {
      widgetList = _buildAllImage();
    } else {
      widgetList = _buildPartImage();
    }
    widgetList.add(_buildButton());
    
    return widgetList;
  }

  List<Widget> _buildAllImage() {
    List<Widget> allImageList = List();

    for (var item in _imageList) {
      Widget imageBox = SizedBox(
        width: double.infinity,
        height: 285.0,
        child: Padding(
          padding: EdgeInsets.only(bottom: 5.0),
          child: Image.network(
            item,
            fit: BoxFit.cover,
          ),
        ),
      );
      
      allImageList.add(imageBox);
    }
    return allImageList;
  }

  List<Widget> _buildPartImage() {
    List<Widget> partImages = List();
    List tempUrlList = List();

    for (var i = 0; i < CarMidImageUnFoldMaxCount; i++) {
      
      if (i < 1) {
        Widget imageBox = SizedBox(
          width: double.infinity,
          height: 285.0,
          child: Padding(
            padding: EdgeInsets.only(bottom: 5.0),
            child: Image.network(
              _imageList[i],
              fit: BoxFit.cover,
            ),
          ),
        );
        partImages.add(imageBox);
      } else {
        tempUrlList.add(_imageList[i]);
        if (tempUrlList.length == 2) {
          partImages.add(Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.red,
                    padding: EdgeInsets.only(right: 2.5, bottom: 5),
                    height: 143.0,
                    child: Image.network(
                      tempUrlList[0],
                      fit: BoxFit.cover,
                    ),
                  )
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.only(left: 2.5,bottom: 5),
                    height: 143.0,
                    child: Image.network(
                      tempUrlList[1],
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              ],
            )
          );
          tempUrlList.removeRange(0, 2);
        }
      }
    }
    return partImages;
  }

  FlatButton _buildButton() {
    return FlatButton(
      onPressed: _handleEvent,
      color: Colors.yellow,
      padding: EdgeInsets.all(0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            _expland ? "收起" : "全部展开",
            style: TextStyle(
              color: Color(0x88888801),
              fontSize: 13
            ),
          ),
           Padding(
            padding: EdgeInsets.only(left: 5),
            child: _expland ? null : Icon(
              Icons.arrow_downward, 
              color: Colors.orange
            ),
          ),
        ],
      ),
    );
  }

  void _handleEvent() {
    setState(() {
      _expland = !_expland;
    });
  }
}

