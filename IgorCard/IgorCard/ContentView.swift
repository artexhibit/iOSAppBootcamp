
import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color(red: 0.33, green: 0.43, blue: 0.90)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Image("igor")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200.0, height: 250.0)
                    .clipShape(Circle())
                    .overlay(
                        Circle().stroke(Color.white, lineWidth: 5)
                    )
                
                Text("Igor Volkov")
                    .font(Font.custom("Pacifico-Regular", size: 40))
                    .foregroundColor(.white)
                    .bold()
                Text("iOS Developer")
                    .font(.system(size: 25))
                    .foregroundColor(.white)
                Divider()
                VStack(spacing: -15) {
                    InfoView(text: "+7 (910) 433-87-65", imageName: "phone.fill")
                    InfoView(text: "moyapochtaigor@gmail.com", imageName: "envelope.fill")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
