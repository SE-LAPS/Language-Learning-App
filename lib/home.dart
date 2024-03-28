import 'package:flutter/material.dart';
import 'lesson.dart';
import 'forum.dart'; // Import the forum.dart file

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
        Quiz(
  question: '1-What programming language is commonly used for developing Android apps?',
  options: ['Java', 'Swift', 'Python', 'C#'],
  correctAnswer: 'Java',
),
Quiz(
  question: '2-Which IDE is widely used for developing Android apps?',
  options: ['Android Studio', 'Xcode', 'Eclipse', 'Visual Studio'],
  correctAnswer: 'Android Studio',
),
Quiz(
  question: '3-What framework is used for building cross-platform mobile apps?',
  options: ['Flutter', 'React Native', 'Ionic', 'Xamarin'],
  correctAnswer: 'Flutter',
),
Quiz(
  question: '4-Which of the following is NOT a mobile app architecture pattern?',
  options: ['MVVM', 'MVC', 'VIPER', 'Redux'],
  correctAnswer: 'Redux',
),
Quiz(
  question: '5-What is the purpose of Gradle in Android development?',
  options: ['Build automation', 'UI design', 'Database management', 'Version control'],
  correctAnswer: 'Build automation',
),
Quiz(
  question: '6-What is the purpose of CocoaPods in iOS development?',
  options: ['Dependency management', 'UI design', 'Database management', 'Version control'],
  correctAnswer: 'Dependency management',
),
Quiz(
  question: '7-Which file format is used for storing Android app resources?',
  options: ['.xml', '.json', '.yaml', '.html'],
  correctAnswer: '.xml',
),
Quiz(
  question: '8-What does APK stand for in Android development?',
  options: ['Android Package', 'Application Package', 'Android Program Kit', 'Application Program Kit'],
  correctAnswer: 'Android Package',
),
Quiz(
  question: '9-Which mobile platform uses Objective-C and Swift for app development?',
  options: ['iOS', 'Android', 'Windows', 'BlackBerry'],
  correctAnswer: 'iOS',
),
Quiz(
  question: '10-What is the main purpose of a manifest file in Android development?',
  options: ['Declare the app\'s components', 'Write code for the app', 'Design the UI layout', 'Handle user input'],
  correctAnswer: 'Declare the app\'s components',
),

        
      ],
    ),
    Lesson(
      title: 'Lesson 2: Conversational Phrases',
      content:
          'In this lesson, you will learn common conversational phrases for everyday situations.',
      quiz: [
        Quiz(
  question: '1-Which programming language is primarily used for iOS app development?',
  options: ['Swift', 'Java', 'Kotlin', 'Objective-C'],
  correctAnswer: 'Swift',
),
Quiz(
  question: '2-What is the purpose of Interface Builder in iOS development?',
  options: ['Designing user interfaces', 'Writing code logic', 'Managing databases', 'Version control'],
  correctAnswer: 'Designing user interfaces',
),
Quiz(
  question: '3-Which file is used to configure dependencies in a Flutter project?',
  options: ['pubspec.yaml', 'package.json', 'build.gradle', 'Podfile'],
  correctAnswer: 'pubspec.yaml',
),
Quiz(
  question: '4-What is the primary purpose of a storyboard in iOS development?',
  options: ['Designing user interfaces', 'Writing code logic', 'Managing databases', 'Version control'],
  correctAnswer: 'Designing user interfaces',
),
Quiz(
  question: '5-What is the main function of the MaterialApp widget in Flutter?',
  options: ['Configuring the overall app structure', 'Creating UI components', 'Handling user input', 'Performing network requests'],
  correctAnswer: 'Configuring the overall app structure',
),
Quiz(
  question: '6-Which tool is commonly used for version control in mobile app development?',
  options: ['Git', 'SVN', 'Mercurial', 'Perforce'],
  correctAnswer: 'Git',
),
Quiz(
  question: '7-What is the purpose of the initState() method in Flutter?',
  options: ['Initializing state variables', 'Handling user gestures', 'Rendering UI elements', 'Performing asynchronous operations'],
  correctAnswer: 'Initializing state variables',
),
Quiz(
  question: '8-Which component is used for managing navigation between screens in Flutter?',
  options: ['Navigator', 'AppBar', 'Scaffold', 'BottomNavigationBar'],
  correctAnswer: 'Navigator',
),
Quiz(
  question: '9-What is the purpose of a View Controller in iOS development?',
  options: ['Managing user interface logic', 'Handling database operations', 'Networking', 'Version control'],
  correctAnswer: 'Managing user interface logic',
),
Quiz(
  question: '10-Which file is responsible for defining the UI layout in an Android app?',
  options: ['XML layout files', 'Java files', 'Gradle files', 'Manifest file'],
  correctAnswer: 'XML layout files',
),

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
              ..._lessons[_currentIndex].quiz.map((quiz) {
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
              }),
              const SizedBox(height: 16.0),
              ElevatedButton(
                 onPressed: _submitQuiz,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, 
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0), 
                    ),
                  ),
                  child: const Text(
                    'Submit Quiz',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
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
