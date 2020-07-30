import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:mobile_absensi/repository/Client.dart';
import 'package:mobile_absensi/repository/user_sharedpref.dart';
import './bloc.dart';

class AbsenBloc extends Bloc<AbsenEvent, AbsenState> {
  @override
  AbsenState get initialState => InitialAbsenState();

  @override
  Stream<AbsenState> mapEventToState(
    AbsenEvent event,
  ) async* {
      if(event is UserAbsen){
        yield new LoadingAbsenState();
        var id = await UserSharedPref.UserId;
        var response = await Client.AbsenPegawai( id, event.placeId);
        print(response);
        yield new CompleteAbsenState();
      }
  }
}
