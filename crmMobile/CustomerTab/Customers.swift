
 



import Foundation

struct ticket: Identifiable, Codable, Hashable {
    var id: String?
    //Must be formatted like this: 2024-11-04 02:30 PM
    var dateTime: String
    var serviceEntity: [Service]
    var laborHours: Double
    var laborRate: Double
    var preliminaryCost: Double //estimate
    var ticketStatus: String
    var customer: Customer
}

struct Service: Codable, Hashable {
   // var id: UUID? = UUID()
    var serviceType: String
    var serviceDetails: String
    var partsRequired: [Part]
}
struct Part: Codable, Hashable {
    var partName: String
    var partQty: Int
    var partPrice: Double
}

struct Customer: Codable, Hashable {
    var id: String?
    var firstName: String
    var lastName: String
    var phoneNumber: String
    var email: String
    var vehicle: Vehicle
}

struct Vehicle: Codable, Hashable {
    var vehicleIddd: String?
    var make: String
    var model: String
    var vin: String
    var year: Int
}




