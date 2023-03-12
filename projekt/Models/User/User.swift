//
//  User.swift
//  projekt
//
//  Created by Самур Гусейнов on 07.03.2023.
//

import Foundation



class User {
    
    let token = UserDefaults.standard.string(forKey: "token")
    
    func userSetParametrs(name: String, email: String, age: String, clouser: @escaping (_ success: Bool) -> ()){
        let parameters = "{\n  \"token\": \"\(token ?? "")\",\n  \"name\": \"\(name)\",\n  \"email\": \"\(email)\",\n  \"age\": \(age)\n}"
        let postData = parameters.data(using: .utf8)
        
        var request = URLRequest(url: URL(string: "http://80.78.251.7/api/update_user")!,timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpMethod = "PUT"
        request.httpBody = postData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard data != nil else {
                return clouser(false)
            }
            if self.checkStatusCode(response: response){
                UserDefaults.standard.set(name, forKey: "name")
                UserDefaults.standard.set(age, forKey: "age")
                UserDefaults.standard.set(email, forKey: "email")
                UserDefaults.standard.set(String(name.prefix(2)), forKey: "logo")
                clouser(true)
            }else{
                clouser(false)
            }
        }
        
        task.resume()
    }
    
    
    func userSetPassword(password: String, clouser: @escaping (_ success: Bool) -> ()){
        let parameters = "{\n  \"token\": \"\(token ?? "")\",\n  \"password\": \"\(password)\"\n}"
        let postData = parameters.data(using: .utf8)
        
        var request = URLRequest(url: URL(string: "http://80.78.251.7/api/update_user")!,timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpMethod = "PUT"
        request.httpBody = postData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard data != nil else {
                return clouser(false)
            }
            if self.checkStatusCode(response: response){
                clouser(true)
            }else{
                clouser(false)
            }
        }
        
        task.resume()
    }
    
    
    private func checkStatusCode(response:URLResponse?) -> Bool {
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
            print("Invalid Response")
            return false
        }
        
        if statusCode != 200 {
            print("Invalid File")
            return false
        }
        return true
    }
    
}
