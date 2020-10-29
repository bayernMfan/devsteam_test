part of 'photo_bloc.dart';

@immutable
abstract class PhotoEvent extends Equatable {
  const PhotoEvent();
  @override
  List<Object> get props => [];
}

class GetPhoto extends PhotoEvent {
  final String _token;
  GetPhoto([this._token]);
  get getParams => _token;
  @override
  List<Object> get props => [_token];
}

class ResetPhoto extends PhotoEvent {}
