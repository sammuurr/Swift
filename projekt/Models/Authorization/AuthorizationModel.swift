//
//  AuthorizationModel.swift
//  projekt
//
//  Created by Самур Гусейнов on 05.03.2023.
//

import Foundation

struct AuthorizationModel: Codable{
    let token: String
    let name: String
    let age: Int
    let email: String
}

struct AuthorizationErrorModel: Codable{
    let detail: String
}

