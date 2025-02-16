import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase cubit, Change change) {
    print(change);

    super.onChange(cubit, change);
  }

  @override
  void onClose(BlocBase cubit) {
    super.onClose(cubit);
  }

  @override
  void onCreate(BlocBase cubit) {
    print(cubit);

    super.onCreate(cubit);
  }

  @override
  void onError(BlocBase cubit, Object error, StackTrace stackTrace) {
    super.onError(cubit, error, stackTrace);
  }
}
