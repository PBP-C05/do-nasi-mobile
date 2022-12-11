import 'package:do_nasi/page/add_question.dart';
import 'package:do_nasi/utils/fetch_questions.dart';
import 'package:flutter/material.dart';

class QuestionsPage extends StatefulWidget {
  const QuestionsPage({Key? key}) : super(key: key);

  @override
  State<QuestionsPage> createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          const SizedBox(
            width: 500,
            height: 500,
            child: DecoratedBox(
              decoration: BoxDecoration(color: Color.fromARGB(255, 148, 209, 6)),
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.55,
            minChildSize: 0.55,
            maxChildSize: 0.9,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                padding: const EdgeInsets.only(top: 30),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 250, 250, 250),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: FetchPosts(
                  scrollController: scrollController
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(251, 192, 45, 1),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddQuestionForm(),
            ),
          ).then((_){
            // refresh the page after returning
            setState(() {});
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
