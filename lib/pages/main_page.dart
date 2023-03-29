import 'package:application/blocs/blocs.dart';
import 'package:application/pages/pages.dart';
import 'package:application/repositories/repositories.dart';
import 'package:application/values/values.dart';
import 'package:application/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatefulWidget {
  static const String id = 'main_page';

  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Tab> myTabs = <Tab>[
      const Tab(icon: Icon(Icons.home, size: 35.0)),
      Tab(
          child: _currentIndex == 1
              ? const PlayActiveIcon()
              : const PlayDeActiveIcon()),
      const Tab(icon: Icon(Icons.person, size: 35.0)),
    ];

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        bottomNavigationBar: TabBar(
          tabs: myTabs,
          padding: const EdgeInsets.only(top: 5.0),
          physics: const NeverScrollableScrollPhysics(),
          indicatorColor: AppColor.background,
          indicator: const UnderlineTabIndicator(borderSide: BorderSide.none),
          labelColor: AppColor.iconColorStart,
          unselectedLabelColor: AppColor.blur,
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
        body: TabBarView(
          children: [
            BlocProvider(
              create: (context) => HomeMovieBloc(HomeRepository()),
              child: const HomePage(),
            ),
            BlocProvider(
              create: (context) =>
                  DiscoverBloc(search: TextEditingController()),
              child: const DiscoverPage(),
            ),
            MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => ProfileBloc(),
                ),
                BlocProvider(
                  create: (context) => AvatarBloc(),
                ),
              ],
              child: const ProfilePage(),
            ),
          ],
          physics: const NeverScrollableScrollPhysics(),
        ),
      ),
    );
  }
}
