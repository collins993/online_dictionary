import 'package:flutter/material.dart';
import 'package:online_dictionary/model/word_response.dart';

class DetailScreen extends StatelessWidget {
  final WordResponse wordResponse;

  DetailScreen(this.wordResponse);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: Container(
        padding: const EdgeInsets.all(32),
        width: double.infinity,
        child: Column(
          children: [
            Text(
              "${wordResponse.word}",
              style: TextStyle(
                color: Colors.white,
                fontSize: 36,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  final meaning = wordResponse.meanings[index];
                  final definitions = meaning.definitions;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        meaning.partOfSpeech,
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: 8,),
                      ListView.separated(itemBuilder: (context, index) => Column(
                        children: [
                          Text("Definition : " + definitions[index].definition),
                          SizedBox(height: 4,),
                          Text("Sentence : ${definitions[index].example}"),
                        ],
                        crossAxisAlignment:  CrossAxisAlignment.start,

                      ),
                        separatorBuilder: (context, index) => SizedBox(height: 32,),
                        itemCount: definitions.length,
                      shrinkWrap: true,),
                    ],
                  );
                },
                separatorBuilder: (context, index) => SizedBox(height: 32,),
                itemCount: wordResponse.meanings.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
