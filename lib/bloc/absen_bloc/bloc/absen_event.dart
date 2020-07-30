import 'package:equatable/equatable.dart';

abstract class AbsenEvent {
  const AbsenEvent();
}

class UserAbsen extends AbsenEvent{
  int placeId ;
  UserAbsen(this.placeId);
}
