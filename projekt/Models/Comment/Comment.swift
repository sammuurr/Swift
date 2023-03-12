//
//  Comment.swift
//  projekt
//
//  Created by Самур Гусейнов on 06.03.2023.
//

import Foundation

class Comment {
    
    func addComent(commenet: String, status: Int, clouser: @escaping (_ success: Bool) -> ()){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let dateString = dateFormatter.string(from: Date())
        
        let token = UserDefaults.standard.string(forKey: "token")
        
        let parameters = "{\n  \"token\": \"\(token ?? "")\",\n  \"comment\": \"\(commenet)\",\n  \"user_status\": \(status),\n  \"datet\": \"\(dateString)\"\n}"
        let postData = parameters.data(using: .utf8)
        
        var request = URLRequest(url: URL(string: "http://80.78.251.7/api/add_comment")!,timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpMethod = "POST"
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
    
    
    func getComment(dataT: Date, clouser: @escaping (_ comment: ComentModel?) -> ()){
        let endDate = Calendar.current.date(byAdding: .second, value: 4, to: dataT)
        let dateFormatter = ISO8601DateFormatter()
        let formattedString = dateFormatter.string(from: endDate!) // "2023-03-07T00:43:06Z"
        
        let token = UserDefaults.standard.string(forKey: "token")
        
        let parameters = "{\n  \"token\": \"\(token ?? "")\",\n  \"datet\": \"\(formattedString)\"\n}"
        let postData = parameters.data(using: .utf8)
        
        var request = URLRequest(url: URL(string: "http://80.78.251.7/api/get_comment")!,timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpMethod = "POST"
        request.httpBody = postData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                return clouser(nil)
            }
            
            let decodeData = try? JSONDecoder().decode(ComentModel.self, from: data)
            clouser(decodeData)
            
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
