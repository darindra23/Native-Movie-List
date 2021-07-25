//
//  Utils.swift
//  Native Movie List
//
//  Created by Darindra R on 22/07/21.
//

import Foundation

class Utils {
    static func getDate(_ string: String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd, yyyy"

        if let date = dateFormatterGet.date(from: string) {
            return dateFormatterPrint.string(from: date)
        }

        return ""
    }

    static func emojiFlag(country: String) -> String {
        let base: UInt32 = 127397
        var s = ""
        for v in country.unicodeScalars {
            s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
        }
        return String(s)
    }
}
