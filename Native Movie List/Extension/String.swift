//
//  String.swift
//  Native Movie List
//
//  Created by Darindra R on 24/07/21.
//

import Foundation

extension String {
    func formatToDollar() -> String {
        if let value = Double(self) {
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.maximumFractionDigits = 2
            formatter.minimumFractionDigits = 2

            if let str = formatter.string(for: value) {
                let trimmed = str.replacingOccurrences(of: "$", with: "")
                return "$ \(trimmed)"
            }
        }
        return ""
    }

    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
