
import SwiftUI

struct ContentView: View {
    
   @ObservedObject var diceeModel = DiceeModel()
    
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            VStack {
                Image("diceeLogo")
                Spacer()
                HStack {
                    DiceView(n: diceeModel.leftDiceNumber)
                    DiceView(n: diceeModel.rightDiceNumber)
                }
                .padding(.horizontal)
                Spacer()
                Button(action: {
                    diceeModel.roll()
                }) {
                    Capsule()
                        .frame(width: 200, height: 70)
                        .foregroundColor(.red)
                        .overlay(Text("Roll")
                                    .font(.system(size: 50))
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding(.horizontal))
                }
            }
        }
    }
}

struct DiceView: View {
    let n: Int
    
    var body: some View {
        Image("dice\(n)")
            .resizable()
            .clipShape(Circle())
            .aspectRatio(1, contentMode: .fit)
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
