import 'package:f_complex_list/complex_list/complex_list.dart';
import 'package:f_complex_list/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends MaterialApp {
  App({required Repository repository})
      : super(
          home: RepositoryProvider.value(
            value: repository,
            child: const ComplexListPage(),
          ),
        );
}
