import SwiftUI

struct CustomersView: View {
    @State private var customer: [Customer] = [] // Use private for better encapsulation
    
    
    var body: some View {
        VStack {
            Text("Recent")
                .font(.title)
                .bold()
                .padding(.leading)
                .foregroundColor(.white)
            
            ScrollView {
                // Display the customer cards, pulling data from the ticket
                ForEach(customer, id: \.id) { customer in
                    CustomerCard(customer: customer)
                        .padding(.horizontal)
                        .padding(.vertical, 0)
                }
            }
        }
        .refreshable{
            fetchCustomers()
        }
        .onAppear {
            fetchCustomers() // Call a separate function to fetch tickets
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private func fetchCustomers() { // Separate function for clarity
        ApiService.shared.fetchCustomers { fetchedCustomers in
            if let fetchedCustomers = fetchedCustomers {
                customer = fetchedCustomers
            }
        }
    }
}

struct CustomersView_Previews: PreviewProvider {
    static var previews: some View {
        CustomersView()
    }
}

