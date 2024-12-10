//
//  Question.swift
//  MatchTrivia
//
//  Created by Josian van Efferen on 31/05/2023.
//

import Foundation

struct Question: Identifiable {
    let id: Int
    let name: String
    let correctAnswer: Answer
    let possibleAnswers: [Answer]
    let difficulty: Int
    let points: Int
    
    init(id: Int, name: String, correctAnswer: Answer, possibleAnswers: [Answer], difficulty: Int, points: Int) {
        self.id = id
        self.name = name
        self.correctAnswer = correctAnswer
        self.possibleAnswers = possibleAnswers
        self.difficulty = difficulty
        self.points = points
    }
    
    
}
