import 'package:f_complex_list/complex_list/cubit/cubit.dart';
import 'package:f_complex_list/complex_list/models/item.dart';
import 'package:f_complex_list/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ComplexListPage extends StatelessWidget {
  const ComplexListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complex list'),
      ),
      body: BlocProvider(
        create: (_) =>
            ListCubit(repository: context.read<Repository>())..fetchList(),
        child: const ComplexListView(),
      ),
    );
  }
}

class ItemTitle extends StatelessWidget {
  final Item item;
  final ValueSetter<String> onDeletePressed;

  const ItemTitle({
    Key? key,
    required this.item,
    required this.onDeletePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
        leading: Text('#${item.id}'),
        title: Text(item.value),
        trailing: item.isDeleting
            ? const CircularProgressIndicator()
            : IconButton(
                onPressed: () => onDeletePressed(item.id),
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
      ),
    );
  }
}

class ItemView extends StatelessWidget {
  final List<Item> items;
  const ItemView({
    Key? key,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return items.isEmpty
        ? const Center(
            child: Text('no content'),
          )
        : ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ItemTitle(
                item: items[index],
                onDeletePressed: (id) {
                  context.read<ListCubit>().deleteItem(id);
                },
              );
            },
          );
  }
}

class ComplexListView extends StatelessWidget {
  const ComplexListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ListCubit>().state;
    switch (state.status) {
      case ListStatus.failure:
        return const Center(child: Text('Oops something went wrong!'));
      case ListStatus.success:
        return ItemView(items: state.items);
      default:
        return const Center(
          child: CircularProgressIndicator(),
        );
    }
  }
}
