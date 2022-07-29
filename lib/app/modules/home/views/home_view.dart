import 'package:flutter/material.dart';
import 'package:food_app/app/constants/app_constants.dart';
import 'package:food_app/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final GetStorage storage = GetStorage();
  String name = '';
  String email = '';
  String phone = '';
  String city = '';
  String zipCode = '';

  getUser() async {
    name = await storage.read('name');
    email = await storage.read('email');
    phone = await storage.read('phone');
    city = await storage.read('city');
    zipCode = await storage.read('pincode');
    setState(() {});
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        title: const Text('Home'),
        centerTitle: true,
      ),
      body: Padding(
        padding: AppConstants.kDefaultPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(
              title: const Text('Name'),
              subtitle: Text(name),
              trailing: const Icon(Icons.person),
            ),
            ListTile(
              title: const Text('Email'),
              subtitle: Text(email),
              trailing: const Icon(Icons.email_outlined),
            ),
            ListTile(
              title: const Text('Mobile'),
              subtitle: Text(phone),
              trailing: const Icon(Icons.phone_android),
            ),
            ListTile(
              title: const Text('City'),
              subtitle: Text(city),
              trailing: const Icon(Icons.location_city_outlined),
            ),
            ListTile(
              title: const Text('ZipCode'),
              subtitle: Text(zipCode),
              trailing: const Icon(Icons.pin_outlined),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                primary: theme.primaryColor,
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                storage.erase();
                Get.offNamedUntil(Routes.welcome, (route) => false);
              },
              child: const Text('Log Out'),
            )
          ],
        ),
      ),
    );
  }
}
