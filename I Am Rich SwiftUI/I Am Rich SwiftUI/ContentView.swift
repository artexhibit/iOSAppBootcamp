//
//  ContentView.swift
//  I Am Rich SwiftUI
//
//  Created by Игорь Волков on 21.09.2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color(.systemTeal)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Image("diamond")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200, alignment: .center)
                Text("I Am Rich")
                    .font(.system(size: 40))
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)

            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
