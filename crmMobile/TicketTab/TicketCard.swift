//
//  TicketCard.swift
//  crmMobile
//
//  Created by Yabsera Gebrekidan on 10/9/24.
//




import SwiftUI

struct TicketCard: View {
    let ticket: ticket
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "tag")
                //Text(ticket.customer.firstName)
                //Text(ticket.customer.lastName)
                if let id = ticket.id {
                    let formattedID = String(id.prefix(8))
                    Text(formattedID)
                }
                Spacer()
                // Progress ring based on ticketStatus
                Image(systemName: "person")
                Text(ticket.customer.firstName + " " + ticket.customer.lastName)
                    .padding(.trailing, 10)
            }
            .padding(.leading, 10)
            Divider()
            
            HStack {
                VStack(alignment: .leading) {
                    Text(ticket.dateTime)
                        .foregroundColor(.gray)
                    Text("\(String(format: "%d", ticket.customer.vehicle.year)) \(ticket.customer.vehicle.model)")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text(ticket.serviceEntity.first?.serviceType ?? "")
                        .foregroundColor(.gray)
                }
                .padding(.leading, 10)
                
                Spacer()
                VStack {
                    ProgressRing(status: ticket.ticketStatus)
                        .frame(width: 40, height: 40)
                    Text(ticket.ticketStatus)
                }
                .padding(.trailing, 10)
                .foregroundColor(.white)
            }
            .padding(.top, 5)
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
    }
}



