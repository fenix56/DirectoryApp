//
//  String+Extension.swift
//  DirectoryApp
//
//  Created by Przemek on 24/10/2022.
//

import Foundation

extension String {
    func toDateFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let date = dateFormatter.date(from: self)
        guard let date = date else {
            return "ERROR: Wrong date!"
        }
        dateFormatter.dateStyle = .long
        return dateFormatter.string(from: date)
    }
}
