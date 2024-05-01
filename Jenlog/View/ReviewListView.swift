import SwiftUI
import SwiftData
import MarkdownUI

struct ReviewListView: View {
    @Environment(\.modelContext) var modelContext
    @Query var posts: [Post]
    
    @State var isShownFullScreenCover = false
    @Binding var currentWeek: Int
    @Binding var selectedWeek: Int
    
    @State private var selectedReview = ""
    @State private var isShowingModal = false
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "M.d E"
        return formatter
    }()
    
    var body: some View {
        ZStack(alignment: .bottomTrailing){
            ScrollView{
                VStack{
                    let selectedPosts = posts.filter { $0.week == selectedWeek }
                    if !selectedPosts.isEmpty {
                        ForEach(posts.filter { $0.week == selectedWeek }, id: \.date) { post in
                            VStack{
                                VStack{
                                    Text( dateFormatter.string(from: post.date))
                                        .font(.headline)
                                        .textCase(.uppercase)
                                    Spacer()
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                
                                HStack{
                                    Rectangle()
                                        .frame(width:3)
                                        .background(Color(hex: "#333333"))
                                        .padding(.trailing, 3)
                                    
                                    VStack{
                                        Text(post.finalPost)
                                            .font(.body)
                                            .padding(.vertical, 16)
                                            .padding(.horizontal, 20)
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(Color(hex: "#F9F9F9"))
                                    .onTapGesture {
                                        selectedReview = post.fastReviewPost
                                        isShowingModal = true
                                    }
                                    .cornerRadius(13)
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom, 12)
                        }
                        .sheet(isPresented: $isShowingModal, content: {
                            ReviewView(test: $selectedReview)
                                .presentationDetents([.medium, .large])
                        }
                        )
                    }
                    else {
                        Text("포스팅이 없어요")
                            .foregroundColor(.gray)
                            .font(.body)
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .ignoresSafeArea()
            
            Button(action: {
                self.isShownFullScreenCover.toggle()
            }, label: {
                VStack{
                    Text("TODAY")
                        .foregroundColor(Color.primary)
                        .font(.callout.weight(.semibold))
                        .padding(-3)
                    Image(systemName: "plus")
                        .font(.title.weight(.semibold))
                        .padding()
                        .background(Color.primary)
                        .foregroundColor(.white)
                        .clipShape(Rectangle())
                        .cornerRadius(14)
                }
            })
            .fullScreenCover(isPresented: $isShownFullScreenCover, content: {
                TodayView()
            })
            .padding()
        }
    }
}

//#Preview {
//    ReviewListView()
//}

struct ReviewView: View {
    @Binding var test : String
    
    var body: some View {
        ScrollView{
            VStack{
                Markdown(test)
                    .padding()
                    .padding(.top, 20)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
