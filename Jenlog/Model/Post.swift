import Foundation
import SwiftData

@Model
class Post {
    @Attribute(.unique) var id = UUID()
    var fastReviewPost: String
    var finalPost: String
    var date: Date
    var week: Int {
            return getWeekNumber(date: date)
        }
    
    init(fastReviewPost: String, finalPost: String, date: Date) {
        self.fastReviewPost = fastReviewPost
        self.finalPost = finalPost
        self.date = date
    }

    func getWeekNumber(date: Date) -> Int {
           let calendar = Calendar.current
           let formatter = DateFormatter()
           formatter.dateFormat = "yyyy-MM-dd"
           
           guard let march4Date = formatter.date(from: "2024-03-04") else {
               return 0
           }
           let currentDate = date
           let weekNumber = calendar.dateComponents([.weekOfYear], from: march4Date, to: currentDate).weekOfYear ?? 0
           
           return weekNumber + 1
       }
}
