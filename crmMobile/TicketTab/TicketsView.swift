import SwiftUI

struct TicketsView: View {
    
    @State private var tickets: [ticket] = []
    @State private var showCreateTicketView = false
    @State private var currentSelection: ticket?

    var body: some View {
        ZStack {
            VStack {
                NavigationStack {
                    ScrollView {
                        ForEach(tickets, id: \.id) { ticket in
                            NavigationLink(value: ticket) {
                                TicketCard(ticket: ticket)
                                    .padding(.horizontal)
                            }
                        }
                    }
                    .navigationTitle("Recent")
                    .navigationBarTitleDisplayMode(.automatic)
                    .toolbar {
                        // Add a button to the right side of the navigation bar
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
                                print("Settings tapped")
                            }) {
                                Image(systemName: "tray") // Example: Gear icon
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                    .navigationDestination(for: ticket.self) { ticket in
                        VehicleDetailView(id: ticket.id)
                    }
                }
                .refreshable{
                    fetchTickets()
                }
                .onAppear {
                    fetchTickets()
                    print("Tickets view onAppear")
                }
            }
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        showCreateTicketView = true
                        print("Ooening createTicketView")
                    }) {
                        Text("+")
                            .fontWeight(.bold)
                            .font(.title)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .clipShape(Circle())
                            .frame(width: 60, height: 60)
                            .shadow(radius: 10)
                    }
                    .padding()
                }
            }
        }
        .sheet(isPresented: $showCreateTicketView) {
            CreateTicketView(isPresented: $showCreateTicketView)
        }
        
    }
    private func currentDate() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long // e.g., "November 25, 2024"
        return formatter.string(from: Date())
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



