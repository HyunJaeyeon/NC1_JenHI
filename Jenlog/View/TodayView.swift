import SwiftUI

struct TodayView: View {
    @Environment(\.dismiss) var dismiss
    @State private var post = ""
    @State private var trimmedPost = ""
    @State private var showingAlert = false
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY년 M월 d일"
        return formatter
    }()
    
    var body: some View {
        NavigationStack{
            TextEditor(text: $post)
//                .overlay(alignment: .topLeading) {
//                    Text("Placeholder")
//                        .foregroundStyle(.gray)
//                }
                .padding()
                .onAppear {
                    post = dateFormatter.string(from: Date()) +
                    "\n" + "---------------------------" +
                    "\n" + "## 오늘은 무엇을 했나요?" + "\n" + "- "
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Cancel") {
                            self.showingAlert.toggle()
                        }
                        .alert("오늘 회고를 그만할까요?", isPresented: $showingAlert) {
                            Button("그만하기", role: .destructive) {
                                dismiss()
                            }
                            Button("아니요, 계속할래요", role: .cancel) {
                            }
                            }
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                        }){
                            NavigationLink(
                                destination: FastReviewView(fastReviewPost: $trimmedPost),
                                label: {Text("다음")})
                        }
                    }
                }
        }
        .onChange(of: post) {
            trimmedPost = post
                .replacingOccurrences(of: "- ", with: "## ")
                .replacingOccurrences(of: "## 오늘은 무엇을 했나요?\n", with: "")
        }
    }
}

//#Preview {
//    TodayView()
//}
