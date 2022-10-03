
abstract class RegisterStates{}

class RegisterInitialState extends RegisterStates{}

class RegisterLoadingState extends RegisterStates{}

class RegisterSuccessState extends RegisterStates
{
  // final ShopLoginModel shopRegisterModel;
  //
  // ShopRegisterSuccessState(this.shopRegisterModel);
}

class RegisterErrorState extends RegisterStates
{
   late final String error;
   RegisterErrorState(this.error) ;
}

class CreateUsersLoadingState extends RegisterStates{}

class CreateUsersSuccessState extends RegisterStates
{
   // final ShopLoginModel shopRegisterModel;
   //
   // ShopRegisterSuccessState(this.shopRegisterModel);
}

class CreateUsersErrorState extends RegisterStates
{
   late final String error;
   CreateUsersErrorState(this.error) ;
}


class ChangeRegisterIconPassword extends RegisterStates{}