import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myapp/screens/splash_screen/splash_screen.dart';
import 'app_binding/app_binding.dart';
import 'db/db_helper.dart';
import 'models/company_model.dart';
import 'models/product_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  await Hive.openBox<int>(DatabaseHelper.authenticationDB);
  await Hive.openBox<double>(DatabaseHelper.priceDB);
  Hive.registerAdapter(CompanyModelAdapter());
  Hive.registerAdapter(ProductModelAdapter());
  await Hive.openBox<CompanyModel>("companyDetails");
  await Hive.openBox<ProductModel>("productDetails");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          initialBinding: MyBinding(),
          debugShowCheckedModeBanner: false,
          title: "Invoice Generator",
          theme: ThemeData(
            textTheme: GoogleFonts.poppinsTextTheme(),
            scaffoldBackgroundColor: Color.fromARGB(255, 249, 221, 215),
          ),
          home: child,
        );
      },
      child: OurSplashScreen(),
    );
  }
}
