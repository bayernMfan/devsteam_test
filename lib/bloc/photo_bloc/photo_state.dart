part of 'photo_bloc.dart';

@immutable
abstract class PhotoState extends Equatable {
  const PhotoState();
  @override
  List<Object> get props => [];
}

class PhotoInitial extends PhotoState {}

class PhotoIsLoading extends PhotoState {}

class PhotoLoaded extends PhotoState {
  final _data;

  PhotoLoaded(this._data);

  List<PhotoModel> get getPhotos => _data;
  //List<String> get getProps => _data;
  @override
  List<Object> get props => [_data];
}

class PhotoNotLoaded extends PhotoState {
  final String _message;
  PhotoNotLoaded(this._message);
  get getMessage => _message;
  @override
  List<Object> get props => [_message];
}
