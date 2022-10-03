class CommentModel

{
  // late final bool like;
  late final String comment;

  CommentModel(this.comment,);
  //this.comment

  CommentModel.fromJson(Map<String,dynamic>json)
  {
    // like = json['like'];
    comment = json['comment'];

  }
  Map<String,dynamic> setComment()
  {
    return{
      // 'like':like,
      'comment':comment,

    };


  }
}