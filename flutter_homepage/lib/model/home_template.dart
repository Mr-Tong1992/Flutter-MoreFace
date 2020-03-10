
class HomeTemplate {
  int  unAuthStyle;
  String unAuthImg;
  int authStyle;
  String authBgImg;

  HomeTemplate({this.unAuthStyle, this.unAuthImg, this.authStyle,
  this.authBgImg});

  factory HomeTemplate.fromJson (Map<String,dynamic> json){
    return HomeTemplate(
        unAuthStyle:json['unAuthStyle'] as int,
        unAuthImg:json['unAuthImg'] as String,
        authStyle:json['authStyle'] as int,
        authBgImg:json['authBgImg'] as String,
    );
  }
  Map<String, dynamic> toJson() {
     return <String, dynamic>{
     "unAuthStyle": unAuthStyle,
      "unAuthImg": unAuthImg,
      "authStyle": authStyle,
      "authBgImg": authBgImg,
    };
  }

}