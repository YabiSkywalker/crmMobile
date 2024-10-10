//
//  CustomerCard.swift
//  crmMobile
//
//  Created by Yabsera Gebrekidan on 10/7/24.
//


import SwiftUI

struct CustomerCard: View {
    let ticket: Ticket
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                // Display customer name
                Text("\(ticket.customer.firstName) \(ticket.customer.lastName)")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                
                // Display vehicle information (make, model, year) without commas
                Text("\(ticket.customer.phoneNumber)")
                    .foregroundColor(.gray)

                
                // Add additional information like phone or email if needed
               // Text("Contact: \(ticket.customer.phoneNumber)")
                    //.foregroundColor(.gray)
            }
            Spacer()
            
            /*
            VStack {
             Text("\(ticket.customer.vehicle.make) \(ticket.customer.vehicle.model) \(String(format: "%d", ticket.customer.vehicle.year))")
                 .font(.title3)
                 .fontWeight(.bold)
                 .foregroundColor(.white)
            }
             */
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
    }
}



