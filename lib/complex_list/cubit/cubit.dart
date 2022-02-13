import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:f_complex_list/complex_list/models/item.dart';
import 'package:equatable/equatable.dart';
import 'package:f_complex_list/repository.dart';

part './state.dart';

class ListCubit extends Cubit<ListState> {
  final Repository repository;

  ListCubit({required this.repository}) : super(const ListState.loading());

  Future<void> fetchList() async {
    try {
      final items = await repository.fetchItems();
      emit(ListState.success(items));
    } on Exception {
      emit(const ListState.failure());
    }
  }

  Future<void> deleteItem(String id) async {
    final deleteInprogress = state.items.map((item) {
      return item.id == id ? item.copyWith(isDeleting: true) : item;
    }).toList();

    emit(ListState.success(deleteInprogress));

    unawaited(repository.deleteItem(id).then((_) {
      final deleteSuccess = List.of(state.items)
        ..removeWhere((element) => element.id == id);

      emit(ListState.success(deleteSuccess));
    }));
  }
}
