import 'package:flutter/material.dart';
import 'package:learn/utils/routes.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Theme.of(context).canvasColor,
        child: Column(
          children: [
            DrawerHeader(
              padding: const EdgeInsets.all(0),
              decoration: BoxDecoration(color: Theme.of(context).canvasColor),
              child: UserAccountsDrawerHeader(
                margin: const EdgeInsets.all(0),
                decoration: BoxDecoration(color: Theme.of(context).canvasColor),
                accountName: Text(
                  "Балаларға арналған оқу қолданбасы",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                accountEmail: Text(
                  "Жасаған Батырбаев Шыңғыс",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                currentAccountPicture: const CircleAvatar(

                  backgroundImage: AssetImage("assets/images/dp.png"),
                ),
              ),
            ),
            _buildListTile(
              icon: Icons.home,
              title: "Басты бет",
              onTap: () {
                Navigator.pushReplacementNamed(context, AllRoutes.homeRoute);
              },
              context: context,
            ),
            _buildListTile(
              icon: Icons.text_fields,
              title: "Әліппе А - Я",
              onTap: () {
                Navigator.pushNamed(context, AllRoutes.atozRoute);
              },
              context: context,
            ),
            _buildListTile(
              icon: Icons.pest_control_rodent_outlined,
              title: "Жануарлар",
              onTap: () {
                Navigator.pushNamed(context, AllRoutes.animalRoute);
              },
              context: context,
            ),
            _buildListTile(
              icon: Icons.egg,
              title: "Құстар",
              onTap: () {
                Navigator.pushNamed(context, AllRoutes.birdsRoute);
              },
              context: context,
            ),
            _buildListTile(
              icon: Icons.pentagon_outlined,
              title: "Пішіндер",
              onTap: () {
                Navigator.pushReplacementNamed(context, AllRoutes.shapesRoute);
              },
              context: context,
            ),
            _buildListTile(
              icon: Icons.back_hand_rounded,
              title: "Дене бөліктері",
              onTap: () {
                Navigator.pushNamed(context, AllRoutes.partsRoute);
              },
              context: context,
            ),
            _buildListTile(
              icon: Icons.sunny,
              title: "Күн жүйесі",
              onTap: () {
                Navigator.pushNamed(context, AllRoutes.solarRoute);
              },
              context: context,
            ),
            _buildListTile(
              icon: Icons.palette,
              title: "Colours",
              onTap: () {
                Navigator.pushNamed(context, AllRoutes.colourRoute);
              },
              context: context,
            ),
            _buildListTile(
              icon: Icons.question_mark_outlined,
              title: "Біз туралы",
              onTap: () {
                Navigator.pushNamed(context, AllRoutes.aboutRoute);
              },
              context: context,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      onTap: onTap,
    );
  }
}
