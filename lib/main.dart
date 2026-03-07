import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'features/catalogo/data/repositories/mock_producto_repository_impl.dart';
import 'features/catalogo/presentation/bloc/catalogo_bloc.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/presentation/pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CatalogoBloc(MockProductoRepositoryImpl()),
        ),
        BlocProvider(
          create: (context) => AuthBloc(
            AuthRepositoryImpl(FirebaseAuth.instance, GoogleSignIn()),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Punto de Venta Patinetas',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: LoginPage(),
      ),
    );
  }
}

