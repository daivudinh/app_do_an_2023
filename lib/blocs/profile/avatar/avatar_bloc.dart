import 'dart:io';

import 'package:application/apis/apis.dart';
import 'package:application/blocs/blocs.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class AvatarBloc extends Bloc<AvatarEvent, AvatarState> {
  AvatarBloc() : super(AvatarInitial()) {
    on<ChangeAvatarEvent>(_onChangeAvatarEvent);
  }

  Future<void> _onChangeAvatarEvent(
      ChangeAvatarEvent event, Emitter<AvatarState> emit) async {
    UserAPI userAPI = UserAPI();
    try {
      emit(ChangeAvatarLoading());

      String url = await getUrlImage(event.imagePath);
      await userAPI.uploadAvatar(event.user, url);
      emit(ChangeAvatarSuccess(imageUrl: url));
    } catch (_) {
      emit(ChangeAvatarFailure());
    }
  }

  Future<String> getUrlImage(String? imagePath) async {
    String filename = basename(imagePath ?? "");
    Reference storageReference = FirebaseStorage.instance.ref().child(filename);
    final UploadTask uploadTask = storageReference.putFile(File(imagePath!));
    final TaskSnapshot downloadUrl = (await uploadTask);
    final String url = await downloadUrl.ref.getDownloadURL();
    return url;
  }
}
