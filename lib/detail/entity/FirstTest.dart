class FirstTest {
  int curPage;
  int size;

  @override
  String toString() {
    return 'FirstTest{curPage: $curPage, size: $size, total: $total, datas: $datas}';
  }

  int total;
  List<Item> datas;

  FirstTest({
    this.curPage,
    this.size,
    this.total
});

  factory FirstTest.fromJson(Map<String, dynamic> json) {
    var firstTest = FirstTest(curPage: json['curPage'], size: json['size'], total: json['total']);
    firstTest.datas = (List.from(json['datas'])).map((i) => Item.fromJson(i)).toList();
    return firstTest;
  }

}

class Item {
  String author;
  String desc;
  String envelopePic;
  String link;
  String projectLink;
  String nicDate;
  String title;
  int type;

  int visible;

  @override
  String toString() {
    return 'Item{author: $author, desc: $desc, envelopePic: $envelopePic, link: $link, projectLink: $projectLink, nicDate: $nicDate, title: $title, type: $type, visible: $visible}';
  }

  Item.fromJson(Map<String, dynamic> json) :
        author = json['author'],
        desc = json['desc'],
        envelopePic = json['envelopePic'],
        link = json['link'],
        projectLink = json['projectLink'],
        nicDate = json['nicDate'],
        title = json['title'],
        type = json['type'],
        visible = json['visible'];
}
