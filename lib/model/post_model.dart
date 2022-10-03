

class PostModel
{

  late final String name;
  late final String image;
  late final String uId;
  late final String dateTime;
  late final String text;
  late final String postImage;

  PostModel(this.name,this.image,this.uId,this.dateTime,this.text,this.postImage);


  PostModel.fromJson(Map<String, dynamic> json)
  {

    name = json['name'];
    uId = json['uId'];
    image = json['image'];
    dateTime = json['dateTime'];
    text = json['text'];
    postImage = json['postImage'];


  }
  Map<String,dynamic> createPost()
  {
    return{
      'name':name,
      'image':image,
      'uId':uId,
      'dateTime':dateTime,
      'text':text,
      'postImage':postImage,



    };
  }


}