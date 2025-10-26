import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

class MyBlocObserver extends BlocObserver {
  final Logger _logger = Logger();

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    _logger.d('onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    _logger.d('onChange -- ${bloc.runtimeType}, $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    _logger.e('onError -- ${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    _logger.d('onClose -- ${bloc.runtimeType}');
  }
}
