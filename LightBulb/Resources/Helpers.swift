//
//  Helpers.swift
//  LightBulb
//
//  Created by Kush on 15/01/23.
//

import SwiftUI

// To Store `Color` in @AppStorage
extension Color: RawRepresentable {
    public init?(rawValue: String) {
        
        guard let data = Data(base64Encoded: rawValue) else { self = .black; return }
        
        do {
            let color = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? UIColor ?? .black
            self = Color(color)
        } catch {
            self = .black
        }
    }

    public var rawValue: String {
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: UIColor(self), requiringSecureCoding: false) as Data
            return data.base64EncodedString()
            
        } catch {
            return ""
        }
    }
}

