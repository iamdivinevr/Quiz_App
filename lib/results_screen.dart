import 'package:flutter/material.dart';

import 'package:adv_basics/data/questions.dart';
import 'package:adv_basics/questions_summary/questions_summary.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({
    super.key,
    required this.chosenAnswers,
    required this.onRestart,
  });

  final void Function() onRestart;
  final List<String> chosenAnswers;

  List<Map<String, Object>> get summaryData {
    final List<Map<String, Object>> summary = [];

    for (var i = 0; i < chosenAnswers.length; i++) {
      if (i < questions.length) {
        summary.add(
          {
            'question_index': i,
            'question': questions[i].text,
            'correct_answer': questions[i].answers[0],
            'user_answer': chosenAnswers[i],
          },
        );
      }
    }

    return summary;
  }

  @override
  Widget build(BuildContext context) {
    if (chosenAnswers.isEmpty) {
      return Center(
        child: Text(
          'No answers provided!',
          style: GoogleFonts.lato(
            color: Colors.redAccent,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      );
    }

    final numTotalQuestions = questions.length;
    final numCorrectQuestions = summaryData.where((data) {
      final userAnswer = data['user_answer'] as String?;
      final correctAnswer = data['correct_answer'] as String?;
      return userAnswer != null && userAnswer == correctAnswer;
    }).length;

    const double marginSize = 40.0;
    const double spacingSize = 30.0;

    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(marginSize),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'You answered $numCorrectQuestions out of $numTotalQuestions questions correctly!',
                style: GoogleFonts.lato(
                  color: const Color.fromARGB(255, 230, 200, 253),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: spacingSize),
              QuestionsSummary(summaryData),
              SizedBox(height: spacingSize),
              TextButton.icon(
                onPressed: onRestart,
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                ),
                icon: const Icon(Icons.refresh),
                label: const Text('Restart Quiz!'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
