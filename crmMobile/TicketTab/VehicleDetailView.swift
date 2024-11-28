
import SwiftUI

struct VehicleDetailView: View {
    var id: String? // VIN passed from TicketsView
    @State private var selectedTicket: ticket?
    @State private var isLoading = true // Track loading state
    @State private var isServiceManagerVisible: Bool = false
    @State private var addedServices: [Service] = []
    
    var body: some View {
        ZStack {
            VStack {
                ScrollView {
                    //the ticket status and progress ring along with the vehicle make model, year and VIN number
                    HStack {
                        if let ticket = selectedTicket {
                            VStack {
                                ProgressRing(status: ticket.ticketStatus)
                                    .frame(width: 50, height: 50)
                                Text(ticket.ticketStatus)
                            }
                            .padding(.leading, 20)
                            
                            Spacer()
                            
                            VStack(alignment: .leading) {
                                // Display customer name
                                Text("\(String(format: "%d", ticket.customer.vehicle.year)) \(ticket.customer.vehicle.make) \(ticket.customer.vehicle.model)")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                Text("\(ticket.customer.vehicle.vin)")
                                    .foregroundColor(.gray)
                                    .font(.title3)
                                //.fontWeight(.bold)
                                    .foregroundColor(.white)
                            }
                            .padding(.trailing, 35)
                            
                        }
                    }
                    .padding()
                    //.background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .onAppear {
                        fetchTicketDetails()
                    }
                    
                    //the active services go here. however the ticket itself is passed into the cubeComponent() file and that is what is rendered as a view
                    HStack {
                        if let ticket = selectedTicket {
                            cubeComponent(activeTicket: ticket)
                        }
                    }
                    .padding()
                    // .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                }
                .refreshable{
                    fetchTicketDetails()
                }
                .onAppear {
                    fetchTicketDetails()
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        if let ticket = selectedTicket {
                            if ticket.ticketStatus == "INIT" {
                                Button(action: {updateTicket(newStatus: "OPEN")}) {
                                    Text("OPEN")
                                }
                                Button(action: {updateTicket(newStatus: "PEND")} ) {
                                    Text("HOLD")
                                }
                                Button(action: {updateTicket(newStatus: "ACTIV")} ) {
                                    Text("START")
                                }
                                Button(action: {updateTicket(newStatus: "LATE")} ) {
                                    Text("DELAY")
                                }
                                Button("DONE") {
                                    updateTicket(newStatus: "DONE")
                                }
                            } else if ticket.ticketStatus == "OPEN" {
                                Button(action: {updateTicket(newStatus: "PEND")} ) {
                                    Text("HOLD")
                                }
                                Button(action: {updateTicket(newStatus: "ACTIV")} ) {
                                    Text("START")
                                }
                                Button(action: {updateTicket(newStatus: "LATE")} ) {
                                    Text("DELAY")
                                }
                                Button("DONE") {
                                    updateTicket(newStatus: "DONE")
                                }
                            } else if ticket.ticketStatus == "PEND" {
                                Button(action: {updateTicket(newStatus: "OPEN")} ) {
                                    Text("OPEN")
                                }
                                Button(action: {updateTicket(newStatus: "ACTIV")} ) {
                                    Text("START")
                                }
                                Button(action: {updateTicket(newStatus: "LATE")} ) {
                                    Text("DELAY")
                                }
                                Button("DONE") {
                                    updateTicket(newStatus: "DONE")
                                }
                            } else if ticket.ticketStatus == "ACTIV" {
                                Button(action: {updateTicket(newStatus: "OPEN")} ) {
                                    Text("OPEN")
                                }
                                Button(action: {updateTicket(newStatus: "PEND")} ) {
                                    Text("HOLD")
                                }
                                Button(action: {updateTicket(newStatus: "LATE")} ) {
                                    Text("DELAY")
                                }
                                Button("DONE") {
                                    updateTicket(newStatus: "DONE")
                                }
                            } else if ticket.ticketStatus == "LATE" {
                                Button(action: {updateTicket(newStatus: "OPEN")} ) {
                                    Text("OPEN")
                                }
                                Button(action: {updateTicket(newStatus: "PEND")} ) {
                                    Text("HOLD")
                                }
                                Button(action: {updateTicket(newStatus: "ACTIV")} ) {
                                    Text("START")
                                }
                                Button("DONE") {
                                    updateTicket(newStatus: "DONE")
                                }
                            } else if ticket.ticketStatus == "DONE" {
                                Button(action: {updateTicket(newStatus: "OPEN")} ) {
                                    Text("OPEN")
                                }
                                Button(action: {updateTicket(newStatus: "PEND")} ) {
                                    Text("HOLD")
                                }
                                Button(action: {updateTicket(newStatus: "ACTIV")} ) {
                                    Text("START")
                                }
                                Button(action: {updateTicket(newStatus: "LATE")} ) {
                                    Text("DELAY")
                                } 
                            }
                        }
  
                    } label: {
                        Text("Status")
                            .font(.body) // Optional: Adjust font size
                            .foregroundColor(.white) // Text color
                            .padding(.horizontal, 13) // Add horizontal padding for pill shape
                            .padding(.vertical, 5)    // Add vertical padding for pill shape
                            .background(Color.blue)  // Background color of the pill
                            .clipShape(Capsule())    // Make it a pill shape
                    }
                }
                
            }
        }
    }
    //updating the ticket status
    private func updateTicket(newStatus: String) {
        guard let updatableTicket = selectedTicket else {
            print("No ticket selected.")
            return
        }
        
        let updatedTicket = ticket(
            id: updatableTicket.id,
            dateTime: updatableTicket.dateTime,
            serviceEntity: updatableTicket.serviceEntity,
            laborHours: updatableTicket.laborHours,
            laborRate: updatableTicket.laborRate,
            preliminaryCost: updatableTicket.preliminaryCost,
            ticketStatus: newStatus,
            customer: updatableTicket.customer
        )
        
        
        
        ApiService.shared.updateTicket(updatedTicket) { success in
            if success {
                print("Ticket created successfully!")
                //presentationMode.wrappedValue.dismiss()
            } else {
                // Show an alert or feedback
                print("Failed to create ticket.")
            }

        }
    }

    private func fetchTicketDetails() {
        isLoading = true
        
        ApiService.shared.fetchTickets { tickets in
            if let tickets = tickets {
                self.selectedTicket = tickets.first(where: { $0.id == id })
                print("Selected ticket: \(String(describing: self.selectedTicket))") // Debug log
            }
            
            isLoading = false
        }
    }
}

struct VehicleDetailView_Previews: PreviewProvider {
    static var previews: some View {
        VehicleDetailView(id: "6730c31472ff530dfd048afb")
    }
}
//ticketId: "671ea3779c2493179033a9fd")
