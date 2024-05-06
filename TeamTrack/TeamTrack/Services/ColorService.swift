//
//  ColorService.swift
//  TeamTrack
//
//  Created by Maria Zaha on 02.05.2024.
//

import UIKit

class ColorService {
    
    static func title() -> UIColor {
        return .black
    }
    
    static func subtitle() -> UIColor {
        return title().withAlphaComponent(0.5)
    }
    
    static func systemBackground() -> UIColor {
        return .white
    }
    
    static func prominentButtonTitleColor() -> UIColor {
        return .white
    }
    
    static func buttonTitleColor() -> UIColor {
        return tintColor()
    }
    
    static func tintColor() -> UIColor {
        return UIColor(red: 0.29, green: 0.57, blue: 0.95, alpha: 1.00) // #4A91F3
    }
    
    static func placeholder() -> UIColor {
        return title().withAlphaComponent(0.25)
    }
    
}
