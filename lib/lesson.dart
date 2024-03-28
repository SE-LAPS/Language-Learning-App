import 'package:flutter/material.dart';
import 'forum.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  int _score = 0;
  int _achievementCount = 0;

  final List<Lesson> _lessons = [
    Lesson(
      title: 'Lesson 1: Introduction',
      content:
          'Welcome to the Language Learning App! In this lesson, you will learn basic greetings and introductions.',
      quiz: [
       
      ],
    ),
    Lesson(
      title: 'Lesson 2: Conversational Phrases',
      content:
          'In this lesson, you will learn common conversational phrases for everyday situations.',
      quiz: [
        
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Language Learning App'),
      ),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildBody() {
    if (_currentIndex == 2) {
      return const ForumPage();
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          _buildLessonContent(),
          _buildScoreAndAchievements(),
        ],
      ),
    );
  }

  Widget _buildLessonContent() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _lessons[_currentIndex].title,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              Text(_lessons[_currentIndex].content),
              const SizedBox(height: 16.0),
              const Text(
                'Quiz:',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ...(_lessons[_currentIndex].quiz.map((quiz) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16.0),
                    Text(quiz.question),
                    ...quiz.options.map((option) {
                      return ListTile(
                        title: Text(option),
                        leading: Radio<String>(
                          value: option,
                          groupValue: quiz.userAnswer,
                          onChanged: (String? value) {
                            setState(() {
                              quiz.userAnswer = value;
                            });
                          },
                        ),
                      );
                    }),
                  ],
                );
              }).toList()),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _submitQuiz,
                child: const Text('Submit Quiz'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScoreAndAchievements() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Score:',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '$_score',
                style: const TextStyle(fontSize: 24.0),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                'Achievements:',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '$_achievementCount',
                style: const TextStyle(fontSize: 24.0),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (int index) {
        setState(() {
          _currentIndex = index;
        });
        if (index == 2) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ForumPage()),
          );
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.book),
          label: 'Lesson 1',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.book),
          label: 'Lesson 2',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.forum),
          label: 'Forum',
        ),
      ],
    );
  }

  void _submitQuiz() {
    int correctAnswers = 0;
    for (var quiz in _lessons[_currentIndex].quiz) {
      if (quiz.userAnswer == quiz.correctAnswer) {
        correctAnswers++;
      }
    }
    setState(() {
      _score += correctAnswers;
      if (correctAnswers == _lessons[_currentIndex].quiz.length) {
        _achievementCount++;
      }
    });
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Quiz Results'),
          content: Text('You scored $correctAnswers out of ${_lessons[_currentIndex].quiz.length}'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

class Lesson {
  final String title;
  final String content;
  final List<Quiz> quiz;

  Lesson({
    required this.title,
    required this.content,
    required this.quiz,
  });
}

class Quiz {
  final String question;
  final List<String> options;
  final String correctAnswer;
  String? userAnswer;

  Quiz({
    required this.question,
    required this.options,
    required this.correctAnswer,
    this.userAnswer,
  });
}
