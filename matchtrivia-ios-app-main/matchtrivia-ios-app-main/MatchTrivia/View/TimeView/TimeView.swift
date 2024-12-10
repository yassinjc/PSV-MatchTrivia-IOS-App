//
//  HomeView.swift
//  MatchTrivia
//
//  Created by Josian van Efferen on 31/05/2023.
//

import SwiftUI

struct TimeView: View {
    @State private var countdown = 1
    @State private var isCountdownOver = false
    @Binding var showQuiz: Bool
    
    init(showQuiz: Binding<Bool>) {
        UITabBar.appearance().backgroundColor = UIColor.red
        UITabBar.appearance().unselectedItemTintColor = UIColor.gray
        self._showQuiz = showQuiz
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            GeometryReader { geometry in
                Image("Background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .clipped()
            }

            VStack(alignment: .leading) {
                VStack(alignment: .center, spacing: -8) {
                    Text("MATCH")
                        .font(.custom("Menlo", size: 26))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .lineLimit(nil)
                        .tracking(-1.0)

                    Text("TRIVIA")
                        .font(.custom("Menlo", size: 25))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 4)
                        .tracking(-2)
                }
                .background(Color.black)
                .padding(.top, 60)
                .padding(.leading, 40)
            }

            ZStack {
                VStack {
                    if !isCountdownOver {
                        Text("QUIZ START IN")
                            .font(.custom("Menlo", size: 26))
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                    }

                    if isCountdownOver {
                        Button(action: {
                            self.showQuiz = true
                        }) {
                            Text("SPEEL MEE")
                            Image(systemName: "chevron.right")
                                .font(.title)
                        }
                        .font(.custom("Menlo", size: 50))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.vertical, 8.0)
                        .padding(.horizontal, 10.0)
                        .background(Color(red: 0.929, green: 0.0, blue: 0.0))
                        
                    } else {
                        Text(countdownFormat(countdown))
                            .font(.custom("Menlo", size: 60))
                            .multilineTextAlignment(.center)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.horizontal, 10.0)
                            .background(Color.black)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            startCountdown()
        }
    }

    func startCountdown() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            countdown -= 1

            if countdown > 0 {
                startCountdown()
            } else {
                isCountdownOver = true
            }
        }
    }

    func countdownFormat(_ seconds: Int) -> String {
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        let remainingSeconds = (seconds % 3600) % 60

        return String(format: "%02d:%02d:%02d", hours, minutes, remainingSeconds)
    }
}

//struct TimeView_Previews: PreviewProvider {
//    static var previews: some View {
//        TimeView()
//    }
//}
