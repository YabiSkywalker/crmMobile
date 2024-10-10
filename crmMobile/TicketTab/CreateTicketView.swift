import SwiftUI

struct CreateTicketView: View {
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var phoneNumber: String = ""
    @State private var email: String = ""
    @State private var vehicleMake: String = ""
    @State private var vehicleModel: String = ""
    @State private var vehicleVin: String = ""
    @State private var vehicleYear: String = "" // Keep as String for input purposes
    @State private var serviceType: String = ""
    @State private var serviceDetails: String = ""
    @State private var partsRequired: String = ""
    @State private var partQty: Int = 0
    @State private var laborHours: Int = 0
    @State private var laborRate: Double = 0.0
    @State private var preliminaryCost: Double = 0.0

    var body: some View {
        VStack {
            Text("Create Ticket")
                .font(.title3)
                .padding()

            Form {
                Section(header: Text("Customer Info")) {
                    TextField("First Name", text: $firstName)
                    TextField("Last Name", text: $lastName)
                    TextField("Phone Number", text: $phoneNumber)
                    TextField("Email", text: $email)
                }
                Section(header: Text("Vehicle Info")) {
                    TextField("Make", text: $vehicleMake)
                    TextField("Model", text: $vehicleModel)
                    TextField("VIN", text: $vehicleVin)
                    TextField("Year", text: $vehicleYear)
                        .keyboardType(.numberPad) // Optional: numeric keyboard
                }
                Section(header: Text("Service Info")) {
                    TextField("Service Type", text: $serviceType)
                    TextField("Service Details", text: $serviceDetails)
                    TextField("Parts Required", text: $partsRequired)
                    Stepper("Part Quantity: \(partQty)", value: $partQty, in: 0...100)
                    Stepper("Labor Hours: \(laborHours)", value: $laborHours, in: 0...100)
                    TextField("Labor Rate", value: $laborRate, formatter: NumberFormatter())
                    TextField("Preliminary Cost", value: $preliminaryCost, formatter: NumberFormatter())
                }
            }
            .padding()

            Button(action: createTicket) {
                Text("New")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .padding()
        }
    }

    private func createTicket() {
        guard let year = Int(vehicleYear) else {
            print("Invalid year")
            return
        }

        let ticket = Ticket(
            id: nil, // or you can set it to 0 if required by your logic
            customer: Customer(
                
                firstName: firstName,
                lastName: lastName,
                phoneNumber: phoneNumber,
                email: email,
                vehicle: Vehicle(
                    make: vehicleMake,
                    model: vehicleModel,
                    vin: vehicleVin,
                    year: year
                )
            ),
            serviceType: serviceType,
            serviceDetails: serviceDetails,
            partsRequired: partsRequired,
            partQty: partQty,
            laborHours: laborHours,
            laborRate: laborRate,
            preliminaryCost: preliminaryCost,
            ticketStatus: "INIT" // Default status
        )

        ApiService.shared.createTicket(ticket) { success in
            if success {
                print("Ticket created successfully!")
                // Optionally dismiss the view or show a success message
            } else {
                print("Failed to create ticket.")
            }
        }
    }

}

