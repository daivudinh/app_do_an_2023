abstract class AvatarState{}

class AvatarInitial extends AvatarState{}

class ChangeAvatarSuccess extends AvatarState{
  final String imageUrl;

  ChangeAvatarSuccess({required this.imageUrl});
}

class ChangeAvatarLoading extends AvatarState{}

class ChangeAvatarFailure extends AvatarState{}
