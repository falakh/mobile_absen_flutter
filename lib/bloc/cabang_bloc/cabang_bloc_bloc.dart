import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:mobile_absensi/model/CabangModel.dart';
import 'package:mobile_absensi/repository/Client.dart';
import './bloc.dart';

class CabangBlocBloc extends Bloc<CabangBlocEvent, CabangBlocState> {
  @override
  CabangBlocState get initialState => InitialCabangBlocState();

  @override
  Stream<CabangBlocState> mapEventToState(
    CabangBlocEvent event,
  ) async* {
    if(event is CabangEventGetNearestCabang){
      yield new CabangStateStillSearching();
      var nearCabangResponse = await Client.GetNearestCabang(event.latitude, event.longitude);
      var decode = jsonDecode(nearCabangResponse);
      var cabangModelList = new List<CabangModel>();
      var cabangList = decode["cabang"] as List;

      for(var i in cabangList){
        cabangModelList.add(new CabangModel.fromJson(i));
      }


      yield CabangStateFound(cabangModelList);
    }
  }
}
