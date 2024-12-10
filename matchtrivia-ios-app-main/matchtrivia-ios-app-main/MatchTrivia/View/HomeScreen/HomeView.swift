
import SwiftUI

struct HomeView: View {
    @ObservedObject private var vm: HomeViewModel
    
    init(vm: HomeViewModel) {
        UITabBar.appearance().backgroundColor = UIColor.red
        UITabBar.appearance().unselectedItemTintColor = UIColor.gray
        self.vm = vm
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Text(vm.question)
                ForEach((0..<vm.possibleAnswers.count), id: \.self) { i in
                    let answer: Answer = vm.possibleAnswers[i]
                    if (answer.name == vm.pickedAnswer?.name ?? "No Answer Selected") {
                        Button(answer.name, action: {vm.pickAnswer(answer: answer)}).buttonStyle(.borderedProminent)
                            .disabled(!vm.allowSelection)
                            .tint(.orange)
                            .overlay {
                                RoundedRectangle(
                                    cornerRadius: 5,
                                    style: .continuous
                                )
                                .stroke(.pink, lineWidth: 2)
                            }
                    } else {
                        Button(answer.name, action: {vm.pickAnswer(answer: answer)}).buttonStyle(.borderedProminent)
                            .disabled(!vm.allowSelection)
                    }
                    
                }
                if (vm.showResult) {
                    if (vm.result) {
                        Button("New Round", action: {vm.newRound()}).buttonStyle(.borderedProminent).tint(.green)
                    } else {
                        Button("New Round", action: {vm.newRound()}).buttonStyle(.borderedProminent).tint(.orange)
                    }
                } else {
                    Button("New Round", action: {vm.newRound()}).buttonStyle(.borderedProminent)
                }
                
                
                
            }.accentColor(Color(uiColor: .systemRed))
        }
    }
}

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}
