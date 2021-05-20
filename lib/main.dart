import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_dictionary/bloc/dictionary_cubit.dart';
import 'package:online_dictionary/repo/word_repository.dart';
import 'package:online_dictionary/screens/home/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BlocProvider(
          child: HomeScreen(),
          create: (context) => DictionaryCubit(WordRepository()),
        ));
  }
}
