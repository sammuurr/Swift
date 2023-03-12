//
//  ScreenController.swift
//  projekt
//
//  Created by Самур Гусейнов on 12.02.2023.
//

import Foundation

class ScreenController: ObservableObject {
    
    @Published var rootScreen = screens.mainScreen
    
    
    enum screens {
        case mainScreen
        case registerScreen
        case loginScreen
        case tabContentView
    }
}
