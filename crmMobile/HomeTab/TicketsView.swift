import SwiftUI

struct TicketsView: View {
    
    @State private var tickets: [Ticket] = []
    @State private var showCreateTicketView = false
    @State private var selectedVehicle: VehicleIdentifier?

    var body: some View {
        ZStack {
            VStack {
                NavigationView {
                    ScrollView {
                        ForEach(tickets, id: \.uniqueID) { ticket in
                           
                            NavigationLink(destination: VehicleDetailView(vin: ticket.customer.vehicle.vin)) {
                                TicketCard(ticket: ticket)
                                    .padding(.horizontal)
                            }
                        }
                    }
                    .navigationTitle("Recent")
                    .navigationBarTitleDisplayMode(.automatic)
                }
                .onAppear {
                    fetchTickets()
                }
            }
        }
        .sheet(item: $selectedVehicle) { vehicle in
            VehicleDetailView(vin: vehicle.vin)
        }
    }

    private func fetchTickets() {
        ApiService.shared.fetchTickets { fetchedTickets in
            if let fetchedTickets = fetchedTickets {
                tickets = fetchedTickets
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        TicketsView()
    }
}

