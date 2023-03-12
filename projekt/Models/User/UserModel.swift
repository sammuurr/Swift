//
//  UserModel.swift
//  projekt
//
//  Created by Самур Гусейнов on 07.03.2023.
//

import Foundation

struct UserModel: Identifiable, Hashable {
    let id = UUID()
    var name: String
    var age: String
    var email: String
    var logo: String
}
    
