import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/features/search/domain/entities/search_history_entity.dart';
import 'package:movify/features/search/presentation/cubits/search_cubit/search_cubit.dart';
import 'package:movify/features/search/presentation/views/search_view_body.dart';
import 'package:movify/features/search/presentation/widgets/search_text_field.dart';

/// Top-level Search screen with search bar and responsive body.
class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  late final TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _onQueryChanged(String query) {
    context.read<SearchCubit>().onQueryChanged(query);
  }

  void _onClear() {
    context.read<SearchCubit>().onQueryChanged('');
  }

  void _onHistoryItemTapped(SearchHistoryEntity item) {
    _textController.text = item.title;
    _textController.selection = TextSelection.fromPosition(
      TextPosition(offset: item.title.length),
    );
    context.read<SearchCubit>().onQueryChanged(item.title);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Space.lg),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              const SizedBox(height: Space.lg),
              Row(
                children: [
                  if (Navigator.of(context).canPop()) ...[
                    GestureDetector(
                      onTap: () => context.pop(),
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: colors.iconPrimary,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: Space.md),
                  ],
                  Expanded(
                    child: SearchTextField(
                      controller: _textController,
                      onChanged: _onQueryChanged,
                      onClear: _onClear,
                    ),
                  ),
                ],
              ),

              Expanded(
                child: SearchViewBody(onHistoryItemTap: _onHistoryItemTapped),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
