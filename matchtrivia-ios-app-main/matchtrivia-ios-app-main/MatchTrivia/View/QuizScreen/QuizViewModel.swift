//
//  HomeViewModel.swift
//  MatchTrivia
//
//  Created by Josian van Efferen on 31/05/2023.
//

import Foundation

class QuizViewModel: ObservableObject {
    
    private let triviaService: TriviaService
    
    private var currentQuestion: Question?
    private var selectedAnswer: Answer?
    
    init(triviaService: TriviaService) {
        self.triviaService = triviaService
    }
    
    @Published var question: String = "Question"
    @Published var possibleAnswers: [Answer] = []
    @Published var pickedAnswer: Answer?
    @Published var correctAnswer: Answer?
    @Published var allowSelection: Bool = true
    @Published var result: Bool = false
    @Published var showResult: Bool = false
    @Published var countdown: Int = 10
    @Published var questionNumber = 0
    
    @Published var resultCountdown = 5
    @Published var showResultScreen = false
    @Published var resultText = ""
    @Published var points = 0
    @Published var questionsGuessedRight = 0
    
    private var gameInitialized = false
    
    public func initializeGame() {
        //newRound()
        
//        // Start countdown for answering the question
//        startCountdown() { success in
//            if success {
//                // End the round after 10 seconds
//                DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
//                    self.endRound() { success in
//                        if success {
//                            // Show the result screen after 5 seconds
//                            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
//                                self.startResultScreen() { success in
//                                    if success {
//                                        // Start a new round after the result screen
//                                        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
//                                            self.initializeGame()
//                                        }
//                                    }
//                                }
//                            }
//                        }
//                    }
//                }
//            }
//        }
        
        guard !gameInitialized else {
                return // Exit if the game is already initialized
            }
        gameInitialized = true
        newRound()
        startCountdown()
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            self.endRound()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 15) {
            self.startResultScreen()
            self.startResultSreenCountdown()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 20) {
            self.restartGame()
        }
    }
    
    public func restartGame() {
        gameInitialized = false
        initializeGame()
    }



    
    public func newRound() {
        print("new round")
        currentQuestion = triviaService.getNewQuestion()
        
        guard let currentQuestion = currentQuestion else {
            print("No Question was given")
            return
        }
        DispatchQueue.main.async {
            self.questionNumber += 1
            self.countdown = 10
            self.resultCountdown = 5
            self.showResultScreen = false
            self.allowSelection = true
            self.question = currentQuestion.name
            self.possibleAnswers = currentQuestion.possibleAnswers
            self.pickedAnswer = nil
            self.selectedAnswer = self.pickedAnswer
        }
    }
    
    public func pickAnswer(answer: Answer) {
        selectedAnswer = answer
        DispatchQueue.main.async {
            self.allowSelection = false
            self.pickedAnswer = answer
        }
    }
    
    public func endRound() {
        print("end round")
        guard let currentQuestion = currentQuestion else {
            return
        }
        
        var result: Bool = false
        
        if (selectedAnswer != nil) {
            result = triviaService.checkAnswer(question: currentQuestion, selectedAnswer: selectedAnswer!)
        }
        
        if (result) {
            self.points += currentQuestion.points
            self.questionsGuessedRight += 1
        }
        
        DispatchQueue.main.async {
            print("show results")
            self.result = result
            self.correctAnswer = self.currentQuestion?.correctAnswer
            self.showResult = true
            self.allowSelection = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            print("go to resultscreen")
            self.showResult = false
            self.pickedAnswer = nil
            //completion(true)
        }
    }
    
    public func startCountdown() {
        print("start timer")
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if self.countdown > 0 {
                self.countdown -= 1
            } else {
                timer.invalidate()
                //completion(true)
                print("timer done")
                return
            }
        }
    }
    
    public func startResultSreenCountdown() {
        print("start result timer")
        self.resultCountdown = 5
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if self.resultCountdown > 0 {
                DispatchQueue.main.async {
                    self.resultCountdown -= 1
                }
            } else {
                timer.invalidate()
                //completion(true)
                print("Result screen timer done")
                return
            }
        }
    }

    
    func startResultScreen() {
        print("show results screen")
        DispatchQueue.main.async {
            self.showResultScreen = true
            self.resultText = "VOLGENDE VRAAG IN"
        }
        
        
    }
}
