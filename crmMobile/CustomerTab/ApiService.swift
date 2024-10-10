//
//  ApiService.swift
//  crmMobile
//
//  Created by Yabsera Gebrekidan on 10/7/24.
//


import Foundation

class ApiService {
    static let shared = ApiService()
    
    private init() {}
    

    func fetchTickets(completion: @escaping ([Ticket]?) -> Void) {
        
        
        guard let url = URL(string: "http://localhost:8080/tickets/getAllTickets") else {
            print("Invalid URL")
            completion(nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("*/*", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data received")
                completion(nil)
                return
            }
            
            do {
                let tickets = try JSONDecoder().decode([Ticket].self, from: data)
                DispatchQueue.main.async {
                    completion(tickets)
                }
            } catch {
                print("Error decoding data: \(error)")
                completion(nil)
            }
        }.resume()
       
        
    }
    
    
    func createTicket(_ ticket: Ticket, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "http://localhost:8080/tickets/createTicket") else {
            print("Invalid URL")
            completion(false)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            let jsonData = try JSONEncoder().encode(ticket)
            request.httpBody = jsonData

            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error creating ticket: \(error)")
                    completion(false)
                    return
                }

                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    print("Invalid response")
                    completion(false)
                    return
                }

                DispatchQueue.main.async {
                    completion(true)
                }
            }.resume()
        } catch {
            print("Error encoding ticket: \(error)")
            completion(false)
        }
    }

}

