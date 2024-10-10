//
//  ApiService.swift
//  crmMobile
//
//  Created by Yabsera Gebrekidan on 10/7/24.
//

import Foundation
import os
struct ApiService {
    
    // CALLING THE customers_entity table

    
    static let shared = ApiService()

    func getCustomers(completion: @escaping ([Customer]?) -> Void) {
        guard let url = URL(string: "http://localhost:8080/customers/getAllCustomers") else { return }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let customers = try JSONDecoder().decode([Customer].self, from: data)
                    DispatchQueue.main.async {
                        completion(customers)
                    }
                } catch {
                    print("Failed to decode customers: \(error)")
                    completion(nil)
                }
            } else {
                print("Failed to fetch customers: \(error?.localizedDescription ?? "Unknown error")")
                completion(nil)
            }
        }
        task.resume()
        print(task)
    }
    
}
