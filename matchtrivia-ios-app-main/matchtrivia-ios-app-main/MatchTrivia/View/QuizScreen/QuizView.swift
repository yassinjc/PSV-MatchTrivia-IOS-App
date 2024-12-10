//
//  QuizView.swift
//  MatchTrivia
//
//  Created by Yassin Chehlaoui on 01/06/2023.
//

import SwiftUI

struct QuizView: View {
    @ObservedObject private var vm: QuizViewModel
    
    

    
    
    
    
    init(vm: QuizViewModel) {
        UITabBar.appearance().backgroundColor = UIColor.red
        UITabBar.appearance().unselectedItemTintColor = UIColor.gray
        self.vm = vm
    }
    
    var body: some View {
        ZStack {
            Image("Background2")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .scaledToFill()
                .clipped()
                .edgesIgnoringSafeArea(.all)
                    
            VStack {
                if vm.showResultScreen {
                    ResultView(vm: vm)
                        .transition(.opacity) // Apply fade-in/fade-out transition to the result view
                    
                } else {
                    
                    VStack {
                        Text(vm.question)
                            .font(.custom("Menlo", size: 26))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.horizontal, 5)
                            .padding(.vertical, 1)
                            .background(Color.black)
                            .tracking(-1)
                            .padding(.bottom, 25)
                            .transition(.opacity) // Apply fade-in/fade-out transition to the question text
                        
                        VStack {
                            ForEach((0..<vm.possibleAnswers.count), id: \.self) { i in
                                let answer: Answer = vm.possibleAnswers[i]
                                @State var isSelected: Bool = answer.name == vm.pickedAnswer?.name ?? "No Answer Selected"
                                @State var isCorrect: Bool = answer.name == vm.correctAnswer?.name ?? "No Correct Answer"
                                
                                @State var opacity: Double = vm.showResult ? !isSelected ? 0.5 : 1.0 : !vm.allowSelection && !isSelected ? 0.5 : 1.0
                                //@State var backgroundColor: Color = vm.showResult && isSelected  ? Color.red : Color.white
                                
                                
                                Button(action: {
                                    vm.pickAnswer(answer: answer)
                                }) {
                                    HStack(spacing: 0) {
                                        Label("Filler",systemImage: "checkmark.circle.fill")
                                            .opacity(0)
                                            .labelStyle(.iconOnly)
                                            .padding(.leading, 10)
                                        Spacer()
                                        Text(answer.name)
                                            .font(.custom("Menlo", size: 17))
                                            .fontWeight(.bold)
                                            .foregroundColor(.black)
                                            .tracking(-1)
                                            .multilineTextAlignment(.center)
                                        Spacer()
                                        Label("Check Icon",systemImage: isCorrect ? "checkmark.circle.fill": "multiply.circle.fill")
                                            .opacity(vm.showResult ? 1 : 0)
                                            .foregroundColor(isCorrect ? .green : .red)
                                            .labelStyle(.iconOnly)
                                            .padding(.trailing, 10)
                                    }
                                    .frame(width: 250, height: 50)
                                    .background(.white)
                                    .opacity(opacity)
                                    
                                }.disabled(!vm.allowSelection)
                            }
                            .padding(.bottom, 10)
                            .transition(.opacity) // Apply fade-in/fade-out transition to the answer buttons
                        }
                        
                        if !vm.showResultScreen { // Only show the countdown if the result is not shown
                            Circle()
                                .trim(from: 0.0, to: CGFloat(vm.countdown) / 10)
                                .stroke(Color.white, lineWidth: 5)
                                .frame(width: 70, height: 70)
                                .rotationEffect(.degrees(-90))
                                .background(Color(red: 0.612, green: 0.0, blue: 0.0))
                                .cornerRadius(50)
                                .overlay(
                                    Text("\(vm.countdown)")
                                        .font(.custom("Menlo", size: 30))
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                )
                                .padding(.top, 20)
                                .transition(.opacity) // Apply fade-in/fade-out transition to the countdown timer
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .onAppear {
                        vm.initializeGame()
                    }
                    .overlay(
                        Button(action: {
                            // Handle xmark button action here
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .font(.title)
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                                .padding(30)
                                .padding(.vertical, 10)
                        }
                            .frame(alignment: .topLeading),
                        alignment: .topLeading
                    )
                    
                }
                
            }
        }
    }
}


struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        QuizView(vm: QuizViewModel(triviaService: TriviaService()))
    }
}
