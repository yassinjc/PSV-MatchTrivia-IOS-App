//
//  TriviaService.swift
//  MatchTrivia
//
//  Created by Josian van Efferen on 31/05/2023.
//

import Foundation

class TriviaService {
    
    private var questions: [Question] = [
        Question(id: 0,
                 name: "WIE KREEG DE EERSTE GELE KAART?",
                 correctAnswer: Answer(id: 2, name: "Luuk De Jong"),
                        possibleAnswers: [
                            Answer(id: 0, name: "Denzel Dumfries"),
                            Answer(id: 1, name: "Xavi Simons"),
                            Answer(id: 2, name: "Luuk De Jong")],
                 difficulty: 1,
                 points: 1000),
        
        Question(id: 1,
                 name: "WELK TEAM HAD HET MEESTE BALBEZIT?",
                 correctAnswer: Answer(id: 0, name: "Thuis Team"),
                    possibleAnswers: [
                        Answer(id: 0, name: "Thuis Team"),
                        Answer(id: 1, name: "Uit Team"),
                        Answer(id: 2, name: "Evenveel")],
                 difficulty: 1,
                 points: 1000),
        
        Question(id: 2,
                 name: "HOEVEEL SHOTS OP BEIDE DOELEN WAREN ER?",
                 correctAnswer: Answer(id: 1, name: "12"),
                    possibleAnswers: [
                        Answer(id: 0, name: "9"),
                        Answer(id: 1, name: "12"),
                        Answer(id: 2, name: "14")],
                 difficulty: 1,
                 points: 1000),
        
        Question(id: 3,
                 name: "WELKE SPELER HEEFT HET MEESTE GEREND?",
                 correctAnswer: Answer(id: 0, name: "Xavi Simons"),
                    possibleAnswers: [
                        Answer(id: 0, name: "Xavi Simons"),
                        Answer(id: 1, name: "Luuk De Jong"),
                        Answer(id: 2, name: "Johan Bakayoko")],
                 difficulty: 1,
                 points: 1000),
        
        Question(id: 3,
                 name: "WELKE SPELER HEEFT DE MEESTE OVERTREDINGEN GEMAAKT?",
                 correctAnswer: Answer(id: 0, name: "Anwar El Ghazi"),
                    possibleAnswers: [
                        Answer(id: 0, name: "Anwar El Ghazi"),
                        Answer(id: 1, name: "Joey Veerman"),
                        Answer(id: 2, name: "Xavi Simons")],
                 difficulty: 1,
                 points: 1000)
    ]
    
    public func getNewQuestion() -> Question? {
        if (questions.count < 1) {
            return nil
        } else if (questions.count == 1) {
            let question: Question = questions[0]
            questions.remove(at: 0)
            print("QUESTIONS LEFT: \(questions.count)")
            return question
        }
        else {
            let randomInt = Int.random(in: 0..<questions.count - 1)
            let question: Question = questions[randomInt]
            questions.remove(at: randomInt)
            print("QUESTIONS LEFT: \(questions.count)")
            return question
        }
        
    }
    
    public func checkAnswer(question: Question, selectedAnswer: Answer) -> Bool {
        return question.correctAnswer.id == selectedAnswer.id
    }
}
