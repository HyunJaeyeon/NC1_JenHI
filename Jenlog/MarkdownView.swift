import SwiftUI
import MarkdownUI

struct TodayLogView: View {
    @State private var post: String = ""
    
    var body: some View {
        VStack {
            ZStack{
                Markdown(post)
                    .padding()
                    .border(Color.gray)
            }
            ZStack{
                TextEditor(text: $post)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
        }
        .padding()
        
    }
    
    func savePost() {
        print("Saved: \(post)")
    }
}

#Preview {
    TodayLogView()
}
