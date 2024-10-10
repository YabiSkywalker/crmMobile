import SwiftUI

struct CustomersView: View {
    @State private var tickets: [Ticket] = [] // Use private for better encapsulation
    
    
    var body: some View {
        VStack {
            Text("Recent")
                .font(.title)
                .bold()
                .padding(.leading)
                .foregroundColor(.white)
            
            ScrollView {
                // Display the customer cards, pulling data from the ticket
                ForEach(tickets, id: \.uniqueID) { ticket in
                    CustomerCard(ticket: ticket)
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
    }
    
    private func fetchTickets() { // Separate function for clarity
        ApiService.shared.fetchTickets { fetchedTickets in
            if let fetchedTickets = fetchedTickets {
                tickets = fetchedTickets
            }
        }
    }
}

struct CustomersView_Previews: PreviewProvider {
    static var previews: some View {
        CustomersView()
    }
}

