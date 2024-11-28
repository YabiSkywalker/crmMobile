//
//  cubeComponent.swift
//  crmMobile
//
//  Created by Yabsera Gebrekidan on 11/9/24.
// SECTION FOR HOLDING ADDED SERVICES  THIS IS A GENERAL PURPOSE COMPONENT

import SwiftUI


struct cubeComponent: View {
    
    var id: String?
    @State var activeTicket: ticket
//    @State private var selectedTicket: ticket?
    @State private var expandedServiceTypes: [String: Bool] = [:]
    @State private var isLoading = true
    @State private var isPartManagerPresent = false
    
    var body: some View {
        ZStack {
            VStack {
                GroupBox {
                    
                    VStack(alignment: .leading) {
                        
                        HStack {
                            Text("Active Services")
                                .font(.headline)
                            //.padding(.leading, 5)
                            Spacer()
                            
                            Button(action: {
                                withAnimation {
                                    isPartManagerPresent.toggle()
                                }
                                print("showing service manager now")
                            }) {
                                if isPartManagerPresent == false {
                                    Text("+")
                                        .padding(.trailing, 10)
                                        .foregroundColor(.blue)
                                        .font(.title)
                                        .transition(.opacity)
                                } else {
                                    
                                    Button(action: {
                                        updateTicket()
                                        print("hiding service manager now")
                                    }) {
                                        Label("", systemImage: "checkmark.circle.fill")
                                            .foregroundColor(.green)
                                            .font(.headline)
                                    }

                                    Text("-")
                                        .padding(.trailing, 10)
                                        .foregroundColor(.blue)
                                        .font(.title)
                                }
                            }
                        }
                        
                    }
                    if isPartManagerPresent {
                     // Service Manager Popup
                     serviceManager(addedServices: $activeTicket.serviceEntity)
                         //.background(Color.white)
                         .cornerRadius(12)
                         .shadow(radius: 10)
                         .frame(maxWidth: .infinity, maxHeight: .infinity)
                         .transition(.opacity) // Animation transition
                         .zIndex(1) // Ensure it's on top of other views
                         .edgesIgnoringSafeArea(.all)
                         .onTapGesture {
                             isPartManagerPresent = false // Dismiss when tapping outside
                         }
                    } else {
                        
                        /* ----------------- services section ------------------ */
                        ForEach(activeTicket.serviceEntity, id: \.serviceType) { service in
                            VStack(alignment: .leading) {
                                Button(action: {
                                    withAnimation {
                                        expandedServiceTypes[service.serviceType, default: false].toggle()
                                    }
                                }) { //Start of the groupbox where the servicetypes and the details about the parts is shown
                                    GroupBox {
                                        HStack {
                                            Text("\(service.serviceType)")
                                            Spacer()
                                            /*Text("$\(String(format: "%.2f", laborRate))/hr")
                                             Text("$\(String(format: "%.2f", activeTicket.preliminaryCost))")
                                             .foregroundColor(.green)
                                             */
                                            Button(action: {
                                                deleteService(service: service)
                                                
                                            }) {
                                                Image(systemName: "trash")
                                                    .foregroundColor(.red)
                                            }
                                        }
                                        if expandedServiceTypes[service.serviceType] == true {
                                            VStack(alignment: .leading) {
                                                VStack {
                                                    ForEach(service.partsRequired, id: \.partName) { part in
                                                        VStack(alignment: .leading) {
                                                            Divider()
                                                            HStack {
                                                                Text("\(part.partQty)")
                                                                Text("x")
                                                                Text("\(part.partName)")
                                                                Spacer()
                                                                Text("$\(part.partPrice, specifier: "%.2f")")
                                                            }
                                                            
                                                        }
                                                    }
                                                }
                                            }
                                            .padding(.top, 5)
                                            .transition(.opacity)
                                            
                                        }
                                    }
                                }
                                .foregroundColor(.primary)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                }
            }
        }
    }
    private func deleteService(service: Service) {
        // Remove the selected service from the serviceEntity array
        if let index = activeTicket.serviceEntity.firstIndex(where: { $0.serviceType == service.serviceType }) {
            activeTicket.serviceEntity.remove(at: index)
            updateTicket() // Call update after removing the service
        }
    }

    
    private func updateTicket() {
        // Fetch the ticket details first
        ApiService.shared.fetchTickets { fetchedTickets in
            if let fetchedTicket = fetchedTickets!.first(where: { $0.id == activeTicket.id }) {
                // Create an updated ticket with the fetched data
                let updatedTicket = ticket(
                    id: fetchedTicket.id, // Keep the original ID
                    dateTime: fetchedTicket.dateTime, // Keep the original date
                    serviceEntity: activeTicket.serviceEntity, // Use the updated serviceEntity
                    laborHours: fetchedTicket.laborHours, // Keep original laborHours
                    laborRate: fetchedTicket.laborRate, // Keep original laborRate
                    preliminaryCost: fetchedTicket.preliminaryCost, // Keep original preliminaryCost
                    ticketStatus: fetchedTicket.ticketStatus, // Keep original status
                    customer: fetchedTicket.customer // Keep original customer
                )
                
                // Now call the API to update the ticket
                ApiService.shared.updateTicket(updatedTicket) { success in
                    if success {
                        print("Ticket updated successfully!")
                    } else {
                        print("Failed to update ticket.")
                    }
                }
            } else {
                print("Ticket not found in fetched data.")
            }
        }
    }
}

/*
 struct cubeComponent_Previews: PreviewProvider {
 static var previews: some View {
 cubeComponent(id: "6730c31472ff530dfd048afb")
 }
 }
 
 
 
 
 
 if isPartManagerPresent {
      Color.black.opacity(0.4) // Dimming the background
          .edgesIgnoringSafeArea(.all)
          .onTapGesture {
              isPartManagerPresent = false // Dismiss when tapping outside
          }
      
      // Service Manager Popup
      serviceManager(addedServices: $activeTicket.serviceEntity)
          .padding()
          //.background(Color.white)
          .cornerRadius(12)
          .shadow(radius: 10)
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .transition(.scale) // Animation transition
          .zIndex(1) // Ensure it's on top of other views
  }
 
 
 */
