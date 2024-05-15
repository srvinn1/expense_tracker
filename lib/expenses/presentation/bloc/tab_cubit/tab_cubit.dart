import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TabCubit extends Cubit<int> {
  TabCubit() : super(0); 

  void updateTabIndex(int index) {
    emit(index);
  }

  Color get backgroundColor =>
      state == 0 ? const Color(0xFFFD3C4A) : const Color(0xFF00A86B);
}
