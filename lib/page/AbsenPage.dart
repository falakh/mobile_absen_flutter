import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobile_absensi/bloc/absen_bloc/bloc/absen_bloc.dart';
import 'package:mobile_absensi/bloc/absen_bloc/bloc/absen_event.dart';
import 'package:mobile_absensi/bloc/absen_bloc/bloc/absen_state.dart';
import 'package:mobile_absensi/bloc/cabang_bloc/bloc.dart';
import 'package:mobile_absensi/model/CabangModel.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rflutter_alert/rflutter_alert.dart';


var cabangBloc = new CabangBlocBloc();
Position lastPositionGlobal = new Position(latitude: 0, longitude: 0);

class AbsenPage extends StatelessWidget {
  List<CabangModel> lastSeenCabang = new List();

  @override
  Widget build(BuildContext context) {
    getLastLocation();
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Absen"),
      ),
      body: Container(
          child: StreamBuilder<Position>(
        stream: Geolocator().getPositionStream(),
        initialData: new Position(altitude: 0, longitude: 0),
        builder: (context, lastPosition) {
          return BlocBuilder<CabangBlocBloc, CabangBlocState>(
            bloc: cabangBloc,
            builder: (context, state) {
              Geolocator()
                  .distanceBetween(
                      lastPosition.data.latitude,
                      lastPosition.data.longitude,
                      lastPositionGlobal.latitude,
                      lastPositionGlobal.longitude)
                  .then((jarak) {
                if (jarak >= 100) {
                  lastPositionGlobal = lastPosition.data;
                  print(lastPosition.data);
                  cabangBloc.add(new CabangEventGetNearestCabang(
                      longitude: lastPositionGlobal.longitude,
                      latitude: lastPositionGlobal.latitude));
                }
              });

              if (state is CabangStateFound) {
                lastSeenCabang = state.cabangList;
              } else if (state is CabangStateStillSearching) {
                return new Text("Sedang Mencari");
              }

              return Container(
                child: ListCabang(lastSeenCabang),
              );
            },
          );
        },
      )),
    );
  }

  getLastLocation() async {
    var permison = await Geolocator().isLocationServiceEnabled();
    if (!permison) {
      await AppSettings.openLocationSettings();
    }
    return await Geolocator().getCurrentPosition();
  }
}

class ListCabang extends StatelessWidget {
  var listCabang = new List<CabangModel>();

  ListCabang(this.listCabang);

  AbsenBloc _absenBloc = new AbsenBloc();

  @override
  Widget build(BuildContext context) {
    var progress = ProgressDialog(context);
    if (listCabang.length > 0) {
      return BlocBuilder<AbsenBloc, AbsenState>(
        bloc: _absenBloc,
        builder: (context, state) {
          if (state is LoadingAbsenState) {
            Future.delayed(Duration.zero, () {
              progress.show();
            });
          } else if (state is CompleteAbsenState) {
            Future.delayed(Duration.zero, () {
              progress.dismiss();
              Alert(
                  context: context,
                  title: "Status",
                  desc: "Absensi Selesai",
                  buttons: [
                    new DialogButton(
                        child: new Text("OK"),
                        onPressed: () => Navigator.pop(context))
                  ]).show();
              print("ini selesai");
            });
          }
          return Container(
            child: ListView.builder(
                itemCount: listCabang.length,
                itemBuilder: (context, id) => GestureDetector(
                    onTap: () => _absenBloc.add(UserAbsen(listCabang[id].id)),
                    child: CabangCard(listCabang[id]))),
          );
        },
      );
    } else {
      return Row(children: <Widget>[
        new Text("Cabang tidak Ditemukan"),
        new MaterialButton(onPressed:()=>cabangBloc.add(new CabangEventGetNearestCabang(longitude: lastPositionGlobal.longitude,latitude: lastPositionGlobal.latitude)))
      ],);
    }
  }

  Widget CabangCard(CabangModel model) {
    return new ListTile(
      title: new Text(model.name),
      subtitle: new Text(model.addres),
      trailing: (new Icon(
        Icons.today,
      )),
    );
  }
}
