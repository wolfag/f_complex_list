import 'package:bloc/bloc.dart';
import 'package:f_complex_list/app.dart';
import 'package:f_complex_list/repository.dart';
import 'package:f_complex_list/simple_bloc_observer.dart';
import 'package:flutter/material.dart';

void main() {
  BlocOverrides.runZoned(
    () => runApp(
      App(
        repository: Repository(),
      ),
    ),
    blocObserver: SimpleBlocObserver(),
  );
}
