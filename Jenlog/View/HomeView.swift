import SwiftUI
import SwiftData
import MarkdownUI

struct DailyReview{
    var date: String
    var post: String
}

struct HomeView: View {
    @State private var currentWeek = 1
    @State private var selectedWeek = 1
    
    @Query var posts: [Post]
    
    var body: some View {
        NavigationStack(){
            VStack{
                HStack{
                    Text("젠-하!")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(Color(hex: "#BEBEBE"))
                    Spacer()
                }
                HStack{
                    Menu {
                        Picker("Options", selection: $selectedWeek){
                            ForEach(1...currentWeek, id: \.self) { i in
                                Button("Week \(i)", action: {})
                            }
                        }
                    } label: {
                        Text("Week \(selectedWeek)")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(Color(hex: "#333333"))
                        Image(systemName: "chevron.down")
                            .font(.title)
                            .bold()
                            .foregroundColor(Color(hex: "#333333"))
                    }
                    Spacer()
                }
            }
            .padding()
            
            ReviewListView(currentWeek: $currentWeek, selectedWeek: $selectedWeek)
        }
        .onAppear{
            let postWeeks = posts.map { $0.week }
            
            if let lastNumber = postWeeks.last {
                currentWeek = lastNumber
                selectedWeek = currentWeek
            }
        }
    }
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >>  8) & 0xFF) / 255.0
        let b = Double((rgb >>  0) & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b)
    }
}

#Preview {
    HomeView()
}
