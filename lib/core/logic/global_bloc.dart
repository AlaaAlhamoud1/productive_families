import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:productive_families/app_store/app_store.dart';
import 'package:productive_families/configure_di.dart';

part 'global_event.dart';
part 'global_state.dart';

class GlobalBloc extends Bloc<GlobalEvent, GlobalState> {
  GlobalBloc()
      : super(GlobalState.initial(
            languageCode: getIt<AppStore>().selectedLanguageCode,
            isDarkTheme: getIt<AppStore>().isDarkMode)) {
    on<LanguageChanged>((event, emit) {
      debugPrint('LanguageChanged');
      emit(state.copyWith(languageCode: event.language));
    });

    on<ThemeChanged>((event, emit) {
      emit(state.copyWith(isDarkTheme: event.isDark));
    });
  }
}
