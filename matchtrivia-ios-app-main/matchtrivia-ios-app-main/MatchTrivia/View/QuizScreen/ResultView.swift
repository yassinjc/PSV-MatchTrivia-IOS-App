//
//  ResultView.swift
//  MatchTrivia
//
//  Created by Josian van Efferen on 08/06/2023.
//

import SwiftUI

struct ResultView: View {
    
    private let vm: QuizViewModel
    
    init(vm: QuizViewModel) {
        self.vm = vm
    }
    
    var body: some View {
        VStack {
            Text(vm.resultText)
                .font(.custom("Menlo", size: 26))
                .fontWeight(.bold)
                .foregroundColor(Color(red: 1.0, green: 0.0, blue: 0.0, opacity: 1.0))
                .padding(.horizontal, 5)
                .padding(.vertical, 1)
                .background(Color.white)
                .tracking(-1)
                .transition(.opacity) // Apply fade-in/fade-out transition to the result text
            
            Text("\(vm.resultCountdown)")
                .font(.custom("Menlo", size: 40))
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.top, 20)
                .padding(.bottom, 40)
                .transition(.opacity) // Apply fade-in/fade-out transition to the countdown text
            
            Text("AANTAL PUNTEN")
                .font(.custom("Menlo", size: 20))
                .fontWeight(.bold)
                .padding(.vertical, 1)
                .padding(.horizontal, 6)
                .background(.black)
                .foregroundColor(.white)
                .transition(.opacity) // Apply fade-in/fade-out transition to the "AANTAL PUNTEN" text
            
            Text("\(vm.points)")
                .font(.custom("Menlo", size: 20))
                .fontWeight(.bold)
                .foregroundColor(Color(red: 1.0, green: 0.0, blue: 0.0, opacity: 1.0))
                .padding(.horizontal, 5)
                .padding(.vertical, 1)
                .background(Color.white)
                .tracking(-1)
                .padding(.bottom, 30)
                .transition(.opacity) // Apply fade-in/fade-out transition to the points text
            
            Text("GOEDE VRAGEN")
                .font(.custom("Menlo", size: 20))
                .fontWeight(.bold)
                .padding(.vertical, 1)
                .padding(.horizontal, 6)
                .background(.black)
                .foregroundColor(.white)
                .transition(.opacity) // Apply fade-in/fade-out transition to the "GOEDE VRAGEN" text
            
            Text("\(vm.questionsGuessedRight)")
                .font(.custom("Menlo", size: 20))
                .fontWeight(.bold)
                .foregroundColor(Color(red: 1.0, green: 0.0, blue: 0.0, opacity: 1.0))
                .padding(.horizontal, 5)
                .padding(.vertical, 1)
                .background(Color.white)
                .tracking(-1)
                .transition(.opacity) // Apply fade-in/fade-out transition to the number of questions guessed right
        }
    }
}

//struct ResultView_Previews: PreviewProvider {
//    static var previews: some View {
//        ResultView()
//    }
//}
