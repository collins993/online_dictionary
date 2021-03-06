import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_dictionary/bloc/dictionary_cubit.dart';
import 'package:online_dictionary/screens/list/list_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  getDictionaryFromWidget(BuildContext context) {
    final cubit = context.watch<DictionaryCubit>();

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Spacer(),
          Text(
            "Dictionary App",
            style: TextStyle(
              color: Colors.white,
              fontSize: 34,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Search any word with speed",
            style: TextStyle(
              color: Colors.amber,
              fontSize: 14,
            ),
          ),
          SizedBox(
            height: 32,
          ),
          TextField(
            controller: cubit.queryController,
            decoration: InputDecoration(
              hintText: "Search a word",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(color: Colors.transparent),
              ),
              fillColor: Colors.grey[100],
              filled: true,
              prefixIcon: Icon(Icons.search),
              hintStyle: TextStyle(color: Colors.white),
            ),
          ),
          Spacer(),
          Container(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                cubit.getWordSearched();
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                padding: const EdgeInsets.all(16),
              ),
              child: Text("SEARCH", style: TextStyle(color: Colors.black),),
            ),
          )
        ],
      ),
    );
  }

  getLoadingWidget() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  gerErrorWidget(message) {
    return Center(
      child: Text(message),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<DictionaryCubit>();

    return BlocListener(
      listener: (context, state) {
        if (state is WordSearchedState && state.words != null) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ListScreen(state.words)));
        }
      },
      bloc: cubit,
      child: Scaffold(
        backgroundColor: Colors.blueGrey[900],
        body: cubit.state is WordSearchingState
            ? getLoadingWidget()
            : cubit.state is ErrorState
                ? gerErrorWidget("Some Error")
                : cubit.state is NoWordSearchedState
                    ? getDictionaryFromWidget(context)
                    : Container(),
      ),
    );
  }
}
