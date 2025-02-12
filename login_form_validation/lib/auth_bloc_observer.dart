import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);

    print("${bloc.runtimeType} ${bloc.state.toString()}");
  }

  @override 
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc,change);

    print("${change.runtimeType} ${change.toString()}");
  }
}
