
import SwiftUI

struct DetailView: View {
    let url: String?
    
    var body: some View {
        WebView(urlString: url)
        //below code removes the white space between NavBar and WebView content
            .navigationBarTitle(Text(""), displayMode: .inline)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(url: "https://www.google.com")
    }
}
