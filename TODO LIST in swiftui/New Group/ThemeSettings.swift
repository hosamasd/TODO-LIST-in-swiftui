//
//  ThemeSettings.swift
//  TODO LIST in swiftui
//
//  Created by hosam on 10/28/20.
//


import SwiftUI



import SwiftUI

class ThemeSettings:ObservableObject {
    @Published var themeSettings:Int = UserDefaults.standard.integer(forKey: "Theme") {
        didSet{
            UserDefaults.standard.set(self.themeSettings, forKey: "Theme")
        }
    }
}
