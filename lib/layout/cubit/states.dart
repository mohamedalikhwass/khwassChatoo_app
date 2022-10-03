
abstract class States {}

class InitialState extends States{}

class ChangeNavBarState extends States{}

class ChangeIconPassword extends States{}


class LoadingState extends States{}

class SuccessState extends States
{
  // final String uId;
  //
  // SuccessState(this.uId);

}

class ErrorState extends States
{
  late final String error;
  ErrorState(this.error);
}


class ChangeProfileImageSuccessState extends States {}

class ChangeProfileImageErrorState extends States {}

class ChangeCoverImageSuccessState extends States {}

class ChangeCoverImageErrorState extends States {}

class UploadProfileImageLoadingState extends States {}

class UploadProfileImageSuccessState extends States {}

class UploadProfileImageErrorState extends States {}

class UploadCoverImageLoadingState extends States {}

class UploadCoverImageSuccessState extends States {}

class UploadCoverImageErrorState extends States {}

class UpdateLoadingState extends States {}

class UpdateSuccessState extends States {}

class UpdateErrorState extends States {}

class ChangePostImageSuccessState extends States {}

class ChangePostImageErrorState extends States {}

class UploadPostImageLoadingState extends States {}

class UploadPostImageSuccessState extends States {}

class UploadPostImageErrorState extends States {}

class PostLoadingState extends States {}

class PostSuccessState extends States {}

class PostErrorState extends States {}

class RemovePostImageSuccessState extends States {}

class RemovePostImageErrorState extends States {}

class GetPostLoadingState extends States {}

class GetPostSuccessState extends States {}

class GetPostErrorState extends States {}

class LikePostLoadingState extends States {}

class LikePostSuccessState extends States {}

class LikePostErrorState extends States {}

class GetLikePostLoadingState extends States {}

class GetLikePostSuccessState extends States {}

class GetLikePostErrorState extends States {}

class CommentPostLoadingState extends States {}

class CommentPostSuccessState extends States {}

class CommentPostErrorState extends States {}

class GetUsersLoadingState extends States {}

class GetUsersSuccessState extends States {}

class GetUsersErrorState extends States {}

class SendMessageSuccessState extends States {}

class SendMessageErrorState extends States {}

class GetMessageSuccessState extends States {}

class GetMessageErrorState extends States {}









