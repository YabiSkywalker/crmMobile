//
//  ApiService.swift
//  crmMobile
//
//  Created by Yabsera Gebrekidan on 10/7/24.
//"https://6814-2601-241-8500-5f30-147d-4518-427d-e364.ngrok-free.app/tickets/getAllTickets"
//http://localhost:8080


import Foundation

class ApiService {
    static let shared = ApiService()
    
    private init() {}
    
    //GET ALL TICKETS
    func fetchTickets(completion: @escaping ([ticket]?) -> Void) {
        guard let url = URL(string: "https://6814-2601-241-8500-5f30-147d-4518-427d-e364.ngrok-free.app/tickets/getAllTickets") else {
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
                let tickets = try JSONDecoder().decode([ticket].self, from: data)
                DispatchQueue.main.async {
                    completion(tickets)
                }
            } catch {
                print("Error decoding data: \(error)")
                completion(nil)
            }
        }.resume()
       
        
    }
    
    //NGROK tunnel URL "https://64ec-2601-241-8500-5f30-b129-bb56-93af-9223.ngrok-free.app/tickets/createTicket"
    func createTicket(_ ticket: ticket, completion: @escaping (Bool) -> Void) {
            guard let url = URL(string: "https://6814-2601-241-8500-5f30-147d-4518-427d-e364.ngrok-free.app/tickets/createTicket") else {
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
            } catch {
                print("Failed to encode ticket: \(error)")
                completion(false)
                return
            }
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error during ticket creation: \(error)")
                    completion(false)
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode == 201 {
                        // Successfully received HTTP 200 OK status
                        print("Ticket created successfully!")
                        completion(true)
                    } else {
                        // Handle non-200 responses
                        print("Failed with status code: \(httpResponse.statusCode)")
                        completion(false)
                    }
                } else {
                    print("Failed to receive a valid response")
                    completion(false)
                }
            }.resume()
        }

    
    func updateTicket(_ ticket: ticket, completion: @escaping (Bool) -> Void) {
        guard let id = ticket.id else {
            print("id not present")
            completion(false)
            return
        }
        
        guard let url = URL(string: "https://6814-2601-241-8500-5f30-147d-4518-427d-e364.ngrok-free.app/tickets/\(id)/update") else {
            print("Invalid URL")
            completion(false)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONEncoder().encode(ticket)
            request.httpBody = jsonData
        } catch {
            print("Failed to encode ticket: \(error)")
            completion(false)
            return
        }
        
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error during ticket creation: \(error)")
                completion(false)
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    // Successfully received HTTP 200 OK status
                    print("Ticket created successfully!")
                    completion(true)
                } else {
                    // Handle non-200 responses
                    print("Failed with status code: \(httpResponse.statusCode)")
                    completion(false)
                }
            } else {
                print("Failed to receive a valid response")
                completion(false)
            }
        }.resume()
        
        
    }
    
    func fetchCustomers(completion: @escaping ([Customer]?) -> Void) {
        guard let url = URL(string: "https://6814-2601-241-8500-5f30-147d-4518-427d-e364.ngrok-free.app/customers/getAllCustomers") else {
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
                let tickets = try JSONDecoder().decode([Customer].self, from: data)
                DispatchQueue.main.async {
                    completion(tickets)
                }
            } catch {
                print("Error decoding data: \(error)")
                completion(nil)
            }
        }.resume()
       
        
    }
}

