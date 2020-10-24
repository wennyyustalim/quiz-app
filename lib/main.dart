import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'How well do you know Singapore?'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _questionNumber = 0;

  // ignore: todo
  // TODO: Replace this according to question size.
  static const _questionSize = 12;
  static const questions = [
    Question(
      questionText: 'How many MRT stations are there in Oct 2020?',
      correctAnswer: 1,
      choices: ['120', '130', '140', '150'],
    ),
  ];
  void _incrementquestionNumber() {
    setState(() {
      _questionNumber++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[_questionNumber];
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Question ${_questionNumber + 1}/$_questionSize',
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 48.0),
              child: Text(
                question.questionText,
                textAlign: TextAlign.center,
              ),
            ),
            for (final choice in question.choices) ...[
              const SizedBox(height: 20.0),
              RaisedButton(
                color: Theme.of(context).backgroundColor,
                onPressed: () => print('pressed'),
                child: Text(
                  choice,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _questionNumber < questions.length - 1
            ? _incrementquestionNumber
            : null,
        tooltip: 'Next question',
        child: Icon(Icons.navigate_next),
      ),
    );
  }
}

class Question {
  const Question({
    @required this.questionText,
    @required this.choices,
    @required this.correctAnswer,
  });

  final String questionText;
  final List<String> choices;
  final int correctAnswer;
}
