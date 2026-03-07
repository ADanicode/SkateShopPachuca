import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'features/catalogo/data/repositories/mock_producto_repository_impl.dart';
import 'features/catalogo/presentation/bloc/catalogo_bloc.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/carrito/presentation/bloc/carrito_bloc.dart';
import 'features/home/presentation/pages/home_router_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyCqWfGfWrHO6Xl4ho76bQSFHSX8XICy2BI",
        authDomain: "skateshoppachucadb.firebaseapp.com",
        projectId: "skateshoppachucadb",
        storageBucket: "skateshoppachucadb.firebasestorage.app",
        messagingSenderId: "1051365529659",
        appId: "1:1051365529659:web:3016cade347659f328a41e",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  // Configurar GoogleSignIn con clientId para web
  final GoogleSignIn googleSignIn = kIsWeb
      ? GoogleSignIn(
          clientId:
              '1051365529659-466b8f3tkgj9fiq4vnlun8dl9q15b54f.apps.googleusercontent.com',
        )
      : GoogleSignIn();

  runApp(MyApp(googleSignIn: googleSignIn));
}

class MyApp extends StatelessWidget {
  final GoogleSignIn googleSignIn;

  const MyApp({super.key, required this.googleSignIn});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CatalogoBloc(MockProductoRepositoryImpl()),
        ),
        BlocProvider(
          create: (context) =>
              AuthBloc(AuthRepositoryImpl(FirebaseAuth.instance, googleSignIn)),
        ),
        BlocProvider(create: (context) => CarritoBloc()),
      ],
      child: MaterialApp(
        title: 'Punto de Venta Patinetas',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true, // Habilitar Material 3
        ),
        home: const HomeRouterPage(), // Usar el router principal
      ),
    );
  }
}
