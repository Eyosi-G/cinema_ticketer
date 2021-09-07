import 'package:flutter_bloc/flutter_bloc.dart';
import './route.dart';
import 'package:flutter/material.dart';
import './src/bloc/bloc.dart';
import './src/data_providers/data_provider.dart';
import './src/repositories/repositories.dart';
import './src/screens/screens.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
//  initializeDateFormatting('pt_BR', null);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (BuildContext ctx) => LoginBloc(
            LoginRepository(
              LoginDataProvider(),
            ),
          ),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      onGenerateRoute: onGenerateRoute,
      home: Splash(),
    );
  }
}
