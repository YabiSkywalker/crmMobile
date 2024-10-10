import SwiftUI

struct TicketsView: View {
    @State private var tickets: [Ticket] = [] // Use private for better encapsulation
    @State private var showCreateTicketView = false // State variable to show the create ticket view

    var body: some View {
        ZStack { // Use ZStack to overlay the button on top of the main content
            VStack {
                Text("Work Orders")
                    .font(.title)
                    .bold()
                    .padding(.leading)
                    .foregroundColor(.white)

                ScrollView {
                    // Display the customer cards, pulling data from the ticket
                    ForEach(tickets, id: \.uniqueID) { ticket in
                        TicketCard(ticket: ticket)
                            .padding(.horizontal)
                            .padding(.vertical, 0)
                    }
                }
            }
            .onAppear {
                fetchTickets() // Call a separate function to fetch tickets
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black) // Dark theme background
            .edgesIgnoringSafeArea(.bottom)
            
            // Circular Create Button
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        showCreateTicketView = true // Show the create ticket view
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
            CreateTicketView() // Present the CreateTicketView as a sheet
        }
    }

    private func fetchTickets() { // Separate function for clarity
        ApiService.shared.fetchTickets { fetchedTickets in
            if let fetchedTickets = fetchedTickets {
                tickets = fetchedTickets
            }
        }
    }
}

struct TicketsView_Previews: PreviewProvider {
    static var previews: some View {
        TicketsView()
    }
}

