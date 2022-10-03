

class UserModel
{

  late final String name;
  late final String phone;
  late final  String email;
  late final String password;
  late final String bio;
  late final String cover;
  late final String image;
  late final String uId;

  UserModel(this.name,this.phone,this.email,this.password,this.bio,this.cover,this.image,this.uId);


  UserModel.fromJson(Map<String, dynamic> json)
  {
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    uId = json['uId'];
    image = json['image'];
    cover = json['cover'];
    bio = json['bio'];
    password =json['password'];
  }
  Map<String,dynamic> createUsers()
  {
    return{
      'name':name,
      'phone':phone,
      'email':email,
      'password' :password,
      'bio':bio,
      'cover':cover,
      'image':image,
      'uId':uId,

    };
  }

  Map<String,Object> updateUsersModel()
  {
    return{
      'name':name,
      'phone':phone,
      'email':email,
      'password' :password,
      'bio':bio,
      'cover':cover,
      'image':image,
      'uId':uId,

    };
  }

}