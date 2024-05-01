import SwiftUI
import UIKit
import SwiftData

struct ProgressBar: View {
    @Binding var downloadAmount: Double
    var body: some View {
        VStack {
            ProgressView("", value: downloadAmount, total: 10.0)
                .accentColor(Color(hex: "#333333"))
            .scaleEffect(x: 1, y: 4, anchor: .center)
        }
    }
}

struct FastReviewView: View {
    @Environment(\.modelContext) var modelContext
    
    @Environment(\.dismiss) var dismiss
    @Binding var fastReviewPost: String
    @State private var finalPost = ""
    @State private var downloadAmount : Double = 10.0
    @State private var isTimerFinished = false
    @State private var showingAlert = false
    
    let date = ""
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    
    
    var body: some View {
        NavigationStack{
            VStack {
//                ProgressView("", value: downloadAmount, total: 10.0)
                ProgressBar(downloadAmount: $downloadAmount)
                    .padding()
            }
            .onReceive(timer) { _ in
                if downloadAmount > 0 {
                    downloadAmount -= 1
                }
                else if downloadAmount == 0{
                    isTimerFinished = true
                }
            }
            .toolbar {
                Button("완료") {
                    print($fastReviewPost)
                    print($finalPost)
                    self.showingAlert.toggle()
                }
                .alert("회고를 저장할게요", isPresented: $showingAlert) {
                    Button("취소", role: .destructive) {
                        
                    }
                    Button("네", role: .cancel) {
//                        let oneDayAgo = Calendar.current.date(byAdding: .day, value: -4, to: Date())
                        let post = Post(fastReviewPost: fastReviewPost, finalPost: finalPost, date: Date())
//                        let post = Post(fastReviewPost: fastReviewPost, finalPost: finalPost, date: oneDayAgo!)
                        
                        modelContext.insert(post)
                        
                        dismiss()
                        dismiss()
                    }
                    } message: {
                        Text("지금 저장하면 더이상 수정이 불가능해요")
                    }

                }
            }
            
        //MARK: - 경고창
            VStack{
                TextEditor(text: $fastReviewPost)
                    .padding()
                
                if isTimerFinished {
                    VStack{
                        TextEditor(text: $finalPost)
                            .padding()
                            .scrollContentBackground(.hidden)
                            .background(Color(hex: "#F9F9F9"))
                            .cornerRadius(16)
                    }
                    .padding(20)
                }
            }
        }
    }

