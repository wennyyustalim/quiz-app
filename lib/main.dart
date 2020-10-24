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
    Question(
      questionText: 'When is the National Day in Singapore?',
      correctAnswer: 2,
      choices: ['11 Aug', '10 Aug', '9 Aug', '8 Aug'],
    ),
    Question(
      questionText: 'What is the color of Singapore national flag?',
      correctAnswer: 0,
      choices: [
        'Red & white',
        'Red & blue',
        'White & yellow',
        'Green & blue',
      ],
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
          children: [
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
            ...question.choices.asMap().entries.map((choice) {
              final choiceIndex = choice.key;
              final correctAnswerIndex = question.correctAnswer;
              return RaisedButton(
                color: Theme.of(context).backgroundColor,
                onPressed: () {
                  if (choiceIndex == correctAnswerIndex) {
                    print('Correct answer!');
                    _showCorrectDialog(context);
                  } else {
                    print('Wrong answer!');
                  }
                },
                child: Text(
                  choice.value,
                  textAlign: TextAlign.center,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  void _showCorrectDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Correct answer!'),
        content: Text('You may proceed to the next question'),
        actions: [
          FlatButton(
            child: Text('Next question'),
            onPressed: () {
              Navigator.of(context).pop();
              _showNextQuestion();
            },
          )
        ],
      ),
    );
  }

  void _showNextQuestion() {
    if (_questionNumber < questions.length - 1) {
      _incrementquestionNumber();
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Congrats on finishing the quiz!'),
          content: Text('There are no more questions left.'),
          actions: [
            FlatButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      );
    }
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
