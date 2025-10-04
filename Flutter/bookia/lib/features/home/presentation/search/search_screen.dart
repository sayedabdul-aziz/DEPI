import 'package:bookia/components/inputs/custom_text_field.dart';
import 'package:bookia/core/extentions/debouncer.dart';
import 'package:bookia/features/home/presentation/cubit/home_cubit.dart';
import 'package:bookia/features/home/presentation/cubit/home_state.dart';
import 'package:bookia/features/home/presentation/home/widgets/all_books_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final Debouncer _debouncer = Debouncer(milliseconds: 700);

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      // Debounce the search query
      // _debouncer.run(
      // () => context.read<HomeCubit>().search(_searchController.text),
      // );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search')),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          var cubit = context.read<HomeCubit>();
          return Column(
            children: [
              CustomTextField(
                controller: _searchController,
                hintText: 'Search here',
              ),
              Expanded(child: AllBooksBuilder(products: [])),
            ],
          );
        },
      ),
    );
  }
}
