part of '../view/home_view.dart';

class _HomeSearchWidget extends StatelessWidget {
  const _HomeSearchWidget();

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: context.read<HomeCubit>().searchController,
      label: 'Search',
      prefixIcon: const Icon(Icons.search),
      onChanged: (name) {
        context.read<HomeCubit>().getSearchProduct(name);
      },
    );
  }
}
