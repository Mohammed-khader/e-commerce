part of '../view/home_view.dart';

class HomeDrawerWidget extends StatelessWidget {
  const HomeDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary,
      child: SafeArea(
        child: ListTileTheme(
          textColor: Colors.white,
          iconColor: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: 128.0,
                height: 128.0,
                margin: const EdgeInsets.only(top: 24.0, bottom: 64.0),
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  color: Colors.black26,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    UserDataService.username ?? '',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.home),
                title:
                    Text('Home', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.account_circle_rounded),
                title: Text('Profile',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                        value: context.read<CartIconCubit>(),
                        child: const FavouritesView(),
                      ),
                    ),
                  );
                },
                leading: const Icon(Icons.favorite),
                title: Text('Favourites',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => const SettingView()));
                },
                leading: const Icon(Icons.settings),
                title: Text('Settings',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
              ),
              const Spacer(),
              ListTile(
                onTap: () async {
                  UserDataService.dispose();
                  await LocalStorageService.instance.removeAll();
                  if (context.mounted) {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => const LoginView()),
                      (route) => false,
                    );
                  }
                },
                leading: const Icon(Icons.logout),
                title: Text('Logout',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
