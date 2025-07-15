part of '../view/home_view.dart';

class _HomeCategoriesWidget extends StatelessWidget {
  const _HomeCategoriesWidget({required this.categories});
  final List<CategoryModel> categories;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        itemCount: categories.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(4),
            child: GestureDetector(
              onTap: () {
                context.read<HomeCubit>().changeSelectedIndex(index);
              },
              child: Container(
                width: 110,
                height: 100,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(30),
                  border: _getBorder(index, context.read<HomeCubit>().selectedIndex),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipOval(
                        child: Image.network(
                          categories[index].image.toString(),
                          height: 60,
                          width: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        categories[index].name.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  BoxBorder? _getBorder(int index, int selectedIndex) {
    if (index == selectedIndex) {
      return Border.all(
        color: Colors.black,
        width: 4,
      );
    } else {
      return null;
    }
  }
}
