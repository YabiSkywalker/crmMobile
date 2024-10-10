//
//  TicketCard.swift
//  crmMobile
//
//  Created by Yabsera Gebrekidan on 10/9/24.
//




import SwiftUI

struct TicketCard: View {
    let ticket: Ticket
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                // Display customer name
                Text("\(ticket.customer.vehicle.make) \(ticket.customer.vehicle.model) \(String(format: "%d", ticket.customer.vehicle.year))")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                
                // Display vehicle information (make, model, year) without commas
                Text("\(ticket.serviceType)")
                    .foregroundColor(.gray)

                
                // Add additional information like phone or email if needed
               // Text("Contact: \(ticket.customer.phoneNumber)")
                    //.foregroundColor(.gray)
            }
            Spacer()
            
            VStack {
                // Progress ring based on ticketStatus
                ProgressRing(status: ticket.ticketStatus)
                    .frame(width: 40, height: 40)
                
                // Display ticket status
                Text(ticket.ticketStatus)
                    .foregroundColor(.gray)
            }
            
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
    }
}
