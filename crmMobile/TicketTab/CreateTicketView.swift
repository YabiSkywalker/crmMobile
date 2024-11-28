import SwiftUI


struct makesModels {
    //Need to make a data loader for this
    
    static let make = ["Acura", "Toyota", "Tesla", "Subaru", "BMW", "Audi", "Mercedes", "Lamborghini", "Ferrari"]
    static let modelsbyMake: [String: [String]] = [
        "Acura": ["MDX", "RDX", "TL", "NSX", "CL", "NSX-T", "MDX-T", "RDX-T", "TL-T", "CL-T"],
        "Toyota": ["Civic", "CRV", "RAV4", "4Runner", "Highlander", "Sequoia", "RAV4-SUV", "4Runner-SUV", "Highlander-SUV", "Sequoia-SUV"],
        "Tesla": ["Model S", "Model X", "Model Y", "Model 3", "Model 4", "Model S Plaid", "Model X Plaid", "Model Y Plaid", "Model 3 Plaid", "Model 4 Plaid"],
        "Subaru": ["Outback", "Impreza", "WRX", "Legacy", "Forester", "Impreza WRX", "Legacy WRX", "Forester WRX"],
        "BMW": ["3 Series", "5 Series", "X5", "X6", "X3", "X4", "Z4", "M5", "M6", "M3", "M4", "M5 M6", "X5 M6", "X3 M6", "X4 M6", "Z4 M6", "M5 M6 X5 M6 X3 M6 X4 M6"],
        "Audi": ["A4", "A5", "A6", "Q5", "Q7", "R8", "S4", "S5", "S6", "TT", "A4 A5 A6 Q5 Q7 R8 S4 S5 S6 TT"],
        "Mercedes": ["C-Class", "E-Class", "G-Class", "S-Class", "CLS", "SLS", "CLS CLS SLS SLS"],
        "Lamborghini": ["Aventador", "Gallardo", "Huracan", "Reventador", "Veneno"],
        "Ferrari": ["F430", "F458", "F460", "F488", "F500", "F510", "F520", "F530", "F540", "F550", "F560", "F570", "F580", "F590", "F600", "F61"]
   ]
}

struct services {
    static let serviceTypes: [String] = ["Engine", "Transmission", "Suspension", "Body", "Wheels and Tires", "Braking"]
    static let serviceDetails: [String: [String]] = [
        "Engine": ["Oil Change", "Filter Change", "Air Filter Change", "Battery Change", "General Maintainence"],
        "Transmission": ["Gearbox Change", "Clutch", "Replacement", "Sensor Change"],
        "Suspension": ["Struts", "Springs", "Coilovers", "End Links", "Bushings"],
        "Body": ["Vinyl Wrap", "Dent Repair", "Paint Job", "Detail"],
        "Wheels and Tires": ["Tire Rotation", "Mounting", "Balancing"],
        "Braking": ["Brake Pad Replacement", "Brake Rotation", "Brake Calibration", "Brake Fluid Change"]
    ]
}

struct CreateTicketView: View {
    
    
    
        //Customer info
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var phoneNumber: String = ""
    @State private var email: String = ""
    
    //customer car info
    @State private var selectedMake: String = makesModels.make.first ?? ""
    @State private var selectedModel: String = ""
    @State private var selectedYear: Int = Calendar.current.component(.year, from: Date())
    @State private var year: Int = Calendar.current.component(.year, from: Date())
    @State private var vehicleVin: String = ""
    
    /* ----------------------------------------------------*/
    //service details
    @State private var selectedServiceType: String = services.serviceTypes.first ?? ""
    @State private var selectedServiceDetails: String = ""
    //@State private var partsRequired: String = ""
    //@State private var partQty: Int = 0
    
    static let laborRateByServiceType: [String: Double] = [
        services.serviceTypes[0]: 75.42,
        services.serviceTypes[1]: 34.65,
        services.serviceTypes[2]: 35.30,
        services.serviceTypes[3]: 10.44,
        services.serviceTypes[4]: 12.73,
        services.serviceTypes[5]: 14.25,
        //services.serviceTypes[6]: 120
    ]
    @State var parts: [Part] = [Part(partName: "", partQty: 0, partPrice: 0)]
    
    @State var serviceAndEntity: [Service] = []
  
    
    @State private var laborRate: Double = 900
    @State private var laborHours: Double = 1.0
    @State private var preliminaryCost: Double = 0.0
    
    @Binding var isPresented: Bool
    @State var selectedDate: Date = Date()
    
    var totalCost: Double {
        parts.reduce(0) { $0 + ($1.partPrice * Double($1.partQty)) }
    }
    @Environment(\.presentationMode) var presentationMode
    
    @State private var addedServices: [Service] = []
    
    var body: some View {
        VStack {
            NavigationStack {
                Form {
                    Section(header: Text(" 👤 Personal Information")) {
                        DatePicker("Date/Time", selection: $selectedDate, displayedComponents: [.date, .hourAndMinute])
                            .datePickerStyle(.compact) // or .wheel, .compact
                        
                        /* ----------- CUSTOMER INFO ---------------- */
                        TextField("First Name", text: $firstName)
                        TextField("Last Name", text: $lastName)
                        TextField("Phone Number", text: $phoneNumber)
                        TextField("Email", text: $email)
                    }
                    Section(header: Text(" 🏎️ Vehicle Details")) {
                        /* ----------- CAR INFO ---------------- */
                        Picker("Year", selection: $selectedYear) {
                            ForEach(1995...Calendar.current.component(.year, from: Date()), id: \.self) { year in
                                Text("\(String(format: "%d", year))")
                                    .tag(year)
                            }
                        }
                        Picker("Make", selection: $selectedMake) {
                            ForEach(makesModels.make, id: \.self) { make in
                                Text(make)
                            }
                        }
                        Picker("Model", selection: $selectedModel) {
                            ForEach(makesModels.modelsbyMake[selectedMake] ?? [], id: \.self) { model in
                                Text(model)
                            }
                        }
                        .onChange(of: selectedMake) {
                            selectedModel = makesModels.modelsbyMake[selectedMake]?.first ?? ""
                        }
                        .pickerStyle(DefaultPickerStyle())
                        TextField("VIN", text: $vehicleVin)
                        
                    }
                    
                    
                    /* ---------------------------------------------------------------------------------------------l---------------------------------*/
                    serviceManager(addedServices: $addedServices).listRowInsets(EdgeInsets())
                    Section() { //start of the section for services
                        
                    }
                }
                .listRowInsets(EdgeInsets())
                .navigationTitle("New")
                .navigationBarTitleDisplayMode(.automatic)
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        Button("Create") {
                            createTicket()
                            presentationMode.wrappedValue.dismiss()
                           // print() 
                        }
                    }
                }
            }
        }
    }
    
    func formattedDateTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd hh:mm a"
        return formatter.string(from: selectedDate)
    }
    
    func createTicket() {
        
        let ticket = ticket(
            dateTime: formattedDateTime(),
            serviceEntity: addedServices,
            laborHours: laborHours,
            laborRate: laborRate,
            preliminaryCost: preliminaryCost,
            ticketStatus: "INIT",
            customer: Customer(
                firstName: firstName,
                lastName: lastName,
                phoneNumber: phoneNumber,
                email: email,
                vehicle: Vehicle(
                    make: selectedMake,
                    model: selectedModel,
                    vin: vehicleVin,
                    year: selectedYear
                )
            )
        )
        ApiService.shared.createTicket(ticket) { success in
            if success {
                print("Ticket created successfully!")
                //presentationMode.wrappedValue.dismiss()
            } else {
                // Show an alert or feedback
                print("Failed to create ticket.")
            }

        }
    }
}


 struct CreateTicketView_Previews: PreviewProvider {
 static var previews: some View {
     CreateTicketView(isPresented: .constant(true))
    }
 }
 
 
/*
 [Part(
     partName: "Test Part",
     partQty: 0,
     partPrice: 0.0
 )]
 */






/*
 
 
 
 
 ApiService.shared.createTicket(ticket) { success in
     if success {
         print("Ticket created successfully!")
         //presentationMode.wrappedValue.dismiss()
     } else {
         // Show an alert or feedback
         print("Failed to create ticket.")
     }

 }
 
}
 
 
 ----------- SERVICE DETAILS ----------------
 
 ForEach(serviceAndEntity.indices, id: \.self) { index in
 let serviceBinding = $serviceAndEntity[index]
 
 Picker("Service Type", selection: serviceBinding.serviceType) {
 ForEach(services.serviceTypes, id: \.self) { serviceType in
 Text(serviceType)
 }
 }
 
 Picker("Service Detail", selection: $selectedServiceDetails[index]) {
 ForEach(services.serviceDetails[selectedServiceType] ?? [], id: \.self) { serviceDetail in
 Text(serviceDetail)
 }
 }
 .onChange(of: selectedServiceType) {
 laborRate = CreateTicketView.laborRateByServiceType[selectedServiceType] ?? 0.0
 preliminaryCost = (laborRate * laborHours)
 }
 if !selectedServiceDetails.isEmpty {
 HStack {
 NavigationLink(destination: PartManager(parts: $parts, servicePrice: CreateTicketView.laborRateByServiceType[selectedServiceType] ?? 0.0, serviceSelected: selectedServiceType)) {
 Text("Add Parts")
 }
 
 }
 
 }
 }
 .textFieldStyle(RoundedBorderTextFieldStyle())
 
 if !selectedServiceDetails.isEmpty {
 Section(header: Text("Finalize")) {
 VStack {
 HStack {
 Text("Labor: \(selectedServiceDetails)")
 Spacer()
 Text("$\(String(format: "%.2f", laborRate))/hr")
 }
 HStack {
 Text("Parts ")
 Spacer()
 Text("$\(String(format: "%.2f", totalCost))") // Display total cost of parts
 }
 HStack {
 Text("Subtotal ")
 Spacer()
 Text("$\(String(format: "%.2f", (laborRate * laborHours) + totalCost))") // Total cost + labor
 }
 }
 
 }
 
 }
 }
 */
