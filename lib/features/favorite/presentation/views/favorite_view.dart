import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/core/utils/enums/content_type.dart';
import 'package:movify/features/favorite/presentation/cubits/sign_in_prompt_cubit.dart';
import 'package:movify/features/favorite/presentation/widgets/favorite_status_badge.dart';
import 'package:movify/features/favorite/presentation/widgets/favorites_tab.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = Theme.of(context).textTheme;

    return BlocProvider(
      create: (_) => SignInPromptCubit(),
      child: Scaffold(
        body: SafeArea(
          child: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Space.lg,
                    vertical: Space.md,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Favorites', style: textTheme.titleLarge),
                      const FavoriteStatusBadge(),
                    ],
                  ),
                ),
                TabBar(
                  labelColor: colors.textPrimary,
                  unselectedLabelColor: colors.textSecondary,
                  labelStyle: textTheme.titleSmall,
                  indicatorColor: colors.primaryDefault,
                  dividerColor: colors.surfaceDivider,
                  tabs: const [
                    Tab(text: 'Movies'),
                    Tab(text: 'Series'),
                  ],
                ),
                const Expanded(
                  child: TabBarView(
                    children: [
                      FavoritesTab(kind: ContentType.movies),
                      FavoritesTab(kind: ContentType.series),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
