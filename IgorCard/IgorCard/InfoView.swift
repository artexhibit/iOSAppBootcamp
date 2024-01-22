//
//  InfoView.swift
//  IgorCard
//
//  Created by Игорь Волков on 22.09.2021.
//

import SwiftUI

struct InfoView: View {
    let text: String
    let imageName: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(Color("ButtonColor"))
            .frame(height: 50)
            .overlay(HStack {
                Image(systemName: imageName)
                    .foregroundColor(.purple)
                Text(text)
                    .foregroundColor(Color("TextColor"))
            })
            .padding(.all)
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView(text: "Hello", imageName: "phone.fill")
            .previewLayout(.sizeThatFits)
    }
}
