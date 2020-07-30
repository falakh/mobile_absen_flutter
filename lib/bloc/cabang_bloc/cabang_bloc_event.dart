import 'package:meta/meta.dart';

@immutable
abstract class CabangBlocEvent {}

class CabangEventGetNearestCabang extends CabangBlocEvent{
  double latitude,longitude;
  CabangEventGetNearestCabang({this.longitude,this.latitude});
}