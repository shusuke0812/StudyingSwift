import Foundation

public struct DateHelper {
    public static func now() -> String {
        formatToStringForImageData(date: Date())
    }
    
    public static func formatToStringForImageData(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        
        formatter.dateFormat = "yyyy-MM-dd-HH-mm-ss-SSS"
        return formatter.string(from: date)
    }
}
