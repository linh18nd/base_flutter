import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';

/// Logs every state change and error from all blocs and cubits.
class AppBlocObserver extends BlocObserver {
  const AppBlocObserver(this._logger);

  final Logger _logger;

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    _logger.t('${bloc.runtimeType}: ${change.nextState}');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    _logger.e(
      '${bloc.runtimeType} error',
      error: error,
      stackTrace: stackTrace,
    );
    super.onError(bloc, error, stackTrace);
  }
}
