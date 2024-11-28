import SwiftUI

struct serviceManager: View {
    
    @State private var selectedServiceType: String = services.serviceTypes.first ?? ""
    @State private var selectedServiceDetails: String = ""
    @State var parts: [Part] = []
    @State private var expandedServiceTypes: [String: Bool] = [:]
    @State private var isPartManagerPresented = false
    @Binding var addedServices: [Service]
    @State private var selectedServiceIndex: Int? = 0
    
    //@Binding var isServiceManagerVisible: Bool
    
 //   @State var selectedServicePrice: Int
    
    var body: some View {
        VStack {
            GroupBox {
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
                }
                .padding()
                
                VStack {
                    GroupBox {
                        HStack {
                            Text("Service Type")
                            Spacer()
                            Picker("Service Type", selection: $selectedServiceType) {
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
                            Picker("Service Item", selection: $selectedServiceDetails) {
                                ForEach(services.serviceDetails[selectedServiceType] ?? [], id: \.self) { serviceDetail in
                                    Text(serviceDetail)
                                }
                            }
                        }
                    }
                } // VStack ends
                
                if !addedServices.isEmpty {
                    VStack {
                        Text("Services")
                            .font(.headline)
                            .padding()
                        Divider()
                        ForEach(addedServices.indices, id: \.self) { index in
                            GroupBox {
                                VStack(alignment: .leading) {
                                    HStack {
                                        Text("\(addedServices[index].serviceDetails)")
                                        Spacer()
                                        Button(action: {
                                            deleteService(at: IndexSet(integer: index))
                                        }){
                                            Image(systemName: "trash")
                                                .foregroundColor(.red)
                                        }
                                        /*
                                         Text("$\(String(format: "%.2f", CreateTicketView.laborRateByServiceType[addedServices[index].serviceType] ?? 0.0))/hr")
                                             .foregroundColor(.green)
                                        */
                                    }
                                    
                                    
                                    if expandedServiceTypes[addedServices[index].serviceType] == true {
                                        if !addedServices[index].partsRequired.isEmpty {
                                            ForEach(addedServices[index].partsRequired, id: \.self) { part in
                                                GroupBox {
                                                    HStack {
                                                        Text("\(part.partQty)")
                                                        Text("x")
                                                        Text("\(part.partName)")
                                                        Spacer()
                                                        Text("$\(part.partPrice, specifier: "%.2f")")
                                                            .foregroundColor(.green)
                                                    }
                                                }
                                            }
                                            .padding(.top, 5)
                                            
                                            GroupBox {
                                                HStack {
                                                    Text("Add More")
                                                        .font(.body)
                                                    Spacer()
                                                    Button(action: {
                                                        selectedServiceIndex = index
                                                        isPartManagerPresented.toggle()
                                                    }) {
                                                        Image(systemName: "plus.circle")
                                                            .foregroundColor(.blue)
                                                    }
                                                }
                                            }
                                            .padding(.top, 12)
                                            .transition(.opacity)
                                        } else {
                                            GroupBox {
                                                HStack {
                                                    Text("Add Parts")
                                                        .font(.body)
                                                    Spacer()
                                                    Button(action: {
                                                        selectedServiceIndex = index
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
                            }
                            .onTapGesture {
                                expandedServiceTypes[addedServices[index].serviceType, default: false].toggle()
                            }
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $isPartManagerPresented) {
            
            if let index = selectedServiceIndex {
                PartManager(
                    isPartManagerPresented: $isPartManagerPresented,
                    parts: $addedServices[index].partsRequired,
                    servicePrice: CreateTicketView.laborRateByServiceType[addedServices[index].serviceType] ?? 0.0,
                    serviceSelected: addedServices[index].serviceType
                )
            } else {
                Text("No service selected")
            }
        }
    }
    
    //PartManager(parts: $addedServices[index].partsRequired, serviceSelected: addedServices[index].serviceType, isPartManagerPresented: $isPartManagerPresented)
    
    //(parts: $parts, servicePrice: 100.0, serviceSelected: addedServices.first?.serviceType ?? "", isPartManagerPresented: $isPartManagerPresented)
    
    func deleteService(at offsets: IndexSet) {
        addedServices.remove(atOffsets: offsets)
    }
}
/*
struct serviceManager_Previews: PreviewProvider {
    static var previews: some View {
        serviceManager()
    }
}
*/
/*
 
 HStack {
     Text("Parts")
     Spacer()
     Button(action: {
         print("Add parts")
     }) {
         Image(systemName: "plus.circle")
             .foregroundColor(.blue)
     }
 }
 .padding()
 
 ------------ ----------------- ------------ -------------
 
 NavigationLink(destination: {
     PartManager(parts: $parts, servicePrice: CreateTicketView.laborRateByServiceType[selectedServiceType] ?? 0.0, serviceSelected: selectedServiceType)
 }) {
     Image(systemName: "plus.circle")
         .foregroundColor(.blue)
 }
 
 
 NavigationLink(destination: PartManager(parts: $parts, servicePrice: CreateTicketView.laborRateByServiceType[selectedServiceType] ?? 0.0, serviceSelected: selectedServiceType)) {
     Image(systemName: "plus.circle")
         .foregroundColor(.blue)
 }
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 if !addedServices.isEmpty {
     
     HStack {
         Text("Services")
             .font(.headline)
             .padding()
         Spacer()
     }
     
     ForEach(addedServices.indices, id: \.self) { index in
         Button(action: {
             withAnimation {
                 expandedServiceTypes[addedServices[index].serviceType, default: false].toggle()
             }
         }) {
             GroupBox {
                 HStack {
                     Text("\(addedServices[index].serviceDetails)")
                     Spacer()
                     Text("$\(String(format: "%.2f", CreateTicketView.laborRateByServiceType[addedServices[index].serviceType] ?? 0.0))/hr")
                         .foregroundColor(.green)
                 }
                 if expandedServiceTypes[addedServices[index].serviceType] == true {
                     VStack {
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
                     .fullScreenCover(isPresented: $isPartManagerPresented) {
                         PartManager(parts: $parts, servicePrice: CreateTicketView.laborRateByServiceType[selectedServiceType] ?? 0.0, serviceSelected: selectedServiceType)
                     }
                 }
             } //GroupBox Ends
         }
         .foregroundColor(.primary) //Button ends
     }
 }
 */
