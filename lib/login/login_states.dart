abstract class SocialLoginStates {}

class SocialLoginIntialState extends SocialLoginStates {}

class SocialLoginLodingState extends SocialLoginStates {}

class SocialLoginSucseesState extends SocialLoginStates {
  final String uid;
  SocialLoginSucseesState(this.uid);
}

class SocialLoginEroorState extends SocialLoginStates {}
