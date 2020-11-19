

class Tag {
  String text;
  String color;
  String bdcolor;
  String bgcolor;
  String img_url;
  Tag();

  factory Tag.fromjson(Map<String, dynamic> json) {
    var tag = Tag();
    tag.text = json['text'];
    tag.color = json['color'];
    tag.bdcolor = json['bdcolor'];
    tag.bgcolor = json['bgcolor'];
    tag.img_url = json['img_url'];
    return tag;
  }
}