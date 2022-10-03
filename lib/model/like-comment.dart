class LikeCommentPost

{
  late final bool like;
 // late final bool comment;

  LikeCommentPost(this.like,);
  //this.comment

  LikeCommentPost.fromJson(Map<String,dynamic>json)
  {
    like = json['like'];
   // comment = json['comment'];

  }
  Map<String,dynamic> setLikeComment()
  {
    return{
    'like':like,
   // 'comment':comment,

  };


 }
}