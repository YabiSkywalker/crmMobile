//
//  servicesAndParts.swift
//  crmMobile
//
//  Created by Yabsera Gebrekidan on 11/10/24.

/*
import SwiftUI

struct servicesAndParts: View {
    
    @State private var selectedServiceType: String = services.serviceTypes.first ?? ""
    @State private var selectedServiceDetails: String = ""
    @State var parts: [Part] = [Part(partName: "", partQty: 0, partPrice: 0)]
    @State private var expandedServiceTypes: [String: Bool] = [:]
    @State private var isPartManagerPresented = false
    
    @State private var addedServices: [Service] = []
    
    var body: some View {
        VStack {
            NavigationStack {
                Form {
                    Section(header: Text("test")) {
                        VStack {
                            HStack {
                                Text("Service Controller")
                                    .font(.headline)
                                Spacer()
                                Button(action: {
                                    print("Add new service")
                                    
                                    if !selectedServiceType.isEmpty && !selectedServiceDetails.isEmpty {
                                        addedServices.append(Service(serviceType: selectedServiceType, serviceDetails: selectedServiceDetails, partsRequired: parts))
                                    }
                                    
                                }) {
                                    Image(systemName: "plus.circle")
                                        .foregroundColor(.blue)
                                }
                            }    //HStack end
                            .padding()
                            
                            GroupBox {
                                GroupBox {
                                    HStack {
                                        Text("Service Type")
                                        Spacer()
                                        Picker("Service Type", selection: $selectedServiceType ) {
                                            ForEach(services.serviceTypes, id: \.self) { serviceType in
                                                Text(serviceType)
                                            }
                                        }
                                    }
                                }
                                GroupBox {
                                    HStack {
                                        Text("Service Item")
                                        Spacer()
                                        Picker("Service Type", selection: $selectedServiceDetails) {
                                            ForEach(services.serviceDetails[selectedServiceType] ?? [], id: \.self) { serviceDetail in
                                                Text(serviceDetail)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        if !addedServices.isEmpty {
                            Text("Services")
                                .font(.headline)
                                .padding()
                            
                            ForEach(addedServices, id: \.self) { service in
                                GroupBox {
                                    VStack(alignment: .leading) {
                                        HStack {
                                            Text("\(service.serviceDetails)")
                                            Spacer()
                                            Text("$\(String(format: "%.2f", CreateTicketView.laborRateByServiceType[service.serviceType] ?? 0.0))/hr")
                                                .foregroundColor(.green)
                                        }
                                        if expandedServiceTypes[service.serviceType] == true {
                                            GroupBox {
                                                HStack {
                                                    Text("Add Parts")
                                                        .font(.body)
                                                    Spacer()
                                                    Button(action: {
                                                        isPartManagerPresented.toggle()
                                                    }) {
                                                        Image(systemName: "plus.circle")
                                                            .foregroundColor(.blue)
                                                    }
                                                }
                                            }
                                            .padding(.top, 12)
                                            .transition(.opacity)
                                        }
                                    }
                                }
                                .listRowInsets(EdgeInsets())
                                .onTapGesture {
                                    withAnimation {
                                        expandedServiceTypes[service.serviceType, default: false].toggle()
                                    }
                                }
                                
                            }
                            .onDelete(perform: deleteService)
                        }
                    }
                    .listRowInsets(EdgeInsets())
                }
            }
            
        }
    }
    func deleteService(at offsets: IndexSet) {
        addedServices.remove(atOffsets: offsets)
    }
}

struct servicesAndParts_Previews: PreviewProvider {
    static var previews: some View {
        servicesAndParts()
        
    }
}
*/
