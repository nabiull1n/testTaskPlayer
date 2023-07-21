//
//  ExtTimeInterval.swift
//  TestTask
//
//  Created by Денис Набиуллин on 20.07.2023.
//

import Foundation

extension TimeInterval {
    func formattedTimeString() -> String {
        let minutes = Int(self / 60)
        let seconds = Int(self.truncatingRemainder(dividingBy: 60))
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
