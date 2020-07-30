import 'package:meta/meta.dart';
import 'package:mobile_absensi/model/CabangModel.dart';

@immutable
abstract class CabangBlocState {}

class InitialCabangBlocState extends CabangBlocState {}

class CabangStateFound extends CabangBlocState{
  final List<CabangModel> cabangList;
  CabangStateFound(this.cabangList);
}

class CabangStateStillSearching extends CabangBlocState{

}
