//
//  HabitModel.swift
//  projekt
//
//  Created by Самур Гусейнов on 08.03.2023.
//

import Foundation

struct HabitApiModel: Codable {
    let description: String
    let id: Int
    let image: String
    let min_description: String
    let userid: Int
    let name: String
    let streak: Int
    let completed: Bool
}
