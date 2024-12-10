//
//  HomeViewModel.swift
//  MatchTrivia
//
//  Created by Josian van Efferen on 31/05/2023.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    private let triviaService: TriviaService
    
    private var currentQuestion: Question?
    private var selectedAnswer: Answer?
    
    init(triviaService: TriviaService) {
        self.triviaService = triviaService
    }
    
    @Published var question: String = "Question"
    @Published var possibleAnswers: [Answer] = []
    @Published var pickedAnswer: Answer?
    @Published var allowSelection: Bool = true
    @Published var result: Bool = false
    @Published var showResult: Bool = false
    
    public func newRound() {
        currentQuestion = triviaService.getNewQuestion()
        guard let currentQuestion = currentQuestion else {
            print("No Question was given")
            return
        }
        DispatchQueue.main.async {
            self.allowSelection = true
            self.question = currentQuestion.name
            self.possibleAnswers = currentQuestion.possibleAnswers
            self.pickedAnswer = nil
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            self.endRound()
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
        guard let selectedAnswer = selectedAnswer else {
            return
        }
        guard let currentQuestion = currentQuestion else {
            return
        }
        let result = triviaService.checkAnswer(question: currentQuestion, selectedAnswer: selectedAnswer)
        
        if (result) {
            
        }
        DispatchQueue.main.async {
            self.result = result
            self.showResult = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.showResult = false
            self.pickedAnswer = nil
        }
    }
}
