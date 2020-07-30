import 'package:equatable/equatable.dart';

abstract class AbsenState  {
  const AbsenState();
}

class InitialAbsenState extends AbsenState {
}

class LoadingAbsenState extends AbsenState{

}

class CompleteAbsenState extends AbsenState{

}