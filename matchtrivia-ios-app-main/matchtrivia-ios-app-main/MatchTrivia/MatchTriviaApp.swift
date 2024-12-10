//
//  MatchTriviaApp.swift
//  MatchTrivia
//
//  Created by Josian van Efferen on 31/05/2023.
//

import SwiftUI

@main
struct MatchTriviaApp: App {
    private let quizViewModel: QuizViewModel
    private let triviaService: TriviaService
    @State var showQuiz: Bool = false
    
    init() {
        self.triviaService = TriviaService()
        self.quizViewModel = QuizViewModel(triviaService: triviaService)
    }
    
    var body: some Scene {
        WindowGroup {
            if (!showQuiz) {
                TabView {
                    ZStack {
                        TimeView(showQuiz: $showQuiz)
                    }
                    .tabItem {
                        Label("Home", systemImage: "house").foregroundColor(Color.white)
                            
                    }
                    .preferredColorScheme(.light)
                        
                }.accentColor(.white)
            } else {
                QuizView(vm: quizViewModel)
            }
            
        }
    }
}
