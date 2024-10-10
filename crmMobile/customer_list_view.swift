//
//  customer_list_view.swift
//  crmMobile
//
//  Created by Yabsera Gebrekidan on 10/7/24.
//

import Foundation

struct customer_list_view: View {
    @State private var customers: [Customer] = []
    
    var body: some View {
        NavigationView {
            List(customers) {
                customer in customer_card_view(customer: customer)
            }
            .navigationTitle("Customers")
            .onAppear {
                ApiService.shared.getCustomers { fetchedCustomers in
                    if let fetchedCustomers = fetchedCustomers {
                        self.customers = fetchedCustomers
                    }
                }
            }
        }
    }
}

#Preview {
    customer_list_view()
}
