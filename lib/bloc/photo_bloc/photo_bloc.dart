import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:devsteam_test/repo/API/photo_API.dart';
import 'package:devsteam_test/repo/model/photo-model.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'photo_event.dart';
part 'photo_state.dart';

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  Photo photoRepo;
  PhotoBloc(this.photoRepo) : super(PhotoInitial());

  @override
  Stream<PhotoState> mapEventToState(
    PhotoEvent event,
  ) async* {
    if (event is GetPhoto) {
      yield PhotoIsLoading();

      try {
        List<PhotoModel> photos = await photoRepo.getPhotosList();
        yield PhotoLoaded(photos);
      } catch (exception) {
        yield PhotoNotLoaded(exception.toString());
      }
    } else if (event is ResetPhoto) {
      yield PhotoInitial();
    }
  }

  void dispose() {
    this.close();
  }
}
