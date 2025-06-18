part of '../view/home_view.dart';

class _HomeCircleAvatar extends StatelessWidget {
  const _HomeCircleAvatar({required this.categories});
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
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(50),
                  border: _getBorder(index, context.read<HomeCubit>().selectedIndex),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipOval(
                        child: Image.network(
                          categories[index].image.toString(),
                          height: 50,
                          width: 50,
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
