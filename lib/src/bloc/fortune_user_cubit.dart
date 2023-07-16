import 'package:dg_fortune/src/model/FortuneUser/fortune_user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class FortuneUserCubit extends Cubit<FortuneUser> {
  FortuneUserCubit() : super(FortuneUser());



  changeFortuneUser(FortuneUser fortuneUser){

    emit(fortuneUser);
  }

}
