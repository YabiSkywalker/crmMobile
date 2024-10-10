
 



import Foundation

struct Ticket: Identifiable, Codable {
    let id: Int?
    var customer: Customer
    var serviceType: String
    var serviceDetails: String
    var partsRequired: String
    var partQty: Int
    var laborHours: Int
    var laborRate: Double
    var preliminaryCost: Double
    var ticketStatus: String
    
    var uniqueID: Int { id ?? UUID().hashValue }}

struct Customer: Codable {
    var firstName: String
    var lastName: String
    var phoneNumber: String
    var email: String
    var vehicle: Vehicle
}

struct Vehicle: Codable {
    var make: String
    var model: String
    var vin: String
    var year: Int
}




