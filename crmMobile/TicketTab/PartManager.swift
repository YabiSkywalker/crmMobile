//
//  PartManager.swift
//  crmMobile
//
//  Created by Yabsera Gebrekidan on 10/29/24.
//

import SwiftUI


struct PartManager: View {
    @Binding var isPartManagerPresented: Bool
    @Binding var parts: [Part]
    var servicePrice: Double
    var serviceSelected: String
    

    func incrementStep(index: Int) {
        guard parts.indices.contains(index) else { return }
        parts[index].partQty += 1
    }

    func decrementStep(index: Int) {
        guard parts.indices.contains(index) else { return }
        parts[index].partQty -= 1
    }
    
    private var totalCost: Double {
        parts.reduce(0) { $0 + ($1.partPrice * Double($1.partQty)) }
    }
    
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
        //TextField("Part Name", text: $parts[0].partName)
        VStack {
            NavigationStack {
                Form {
                    Section(header: Text("Parts Tray")) {
                        VStack {
                            HStack {
                                Text("Labor: \(serviceSelected)")
                                Spacer()
                                Text("$\(String(format: "%.2f", servicePrice))/hr")
                            }
                            HStack {
                                Text("Parts ")
                                Spacer()
                                Text("$\(String(format: "%.2f", totalCost))")
                            }
                            HStack {
                                Text("Subtotal ")
                                Spacer()
                                Text("$\(String(format: "%.2f", servicePrice + totalCost))")
                            }
                        }
                        //      ScrollView {
                        ForEach(parts.indices, id: \.self) { index in
                            if parts.indices.contains(index) {
                                GroupBox {
                                    HStack {
                                        TextField("Item", text: $parts[index].partName)
                                            .multilineTextAlignment(.leading)
                                        //Spacer()
                                        TextField("Price", text: Binding(
                                            get: { String(format: "%.2f", parts[index].partPrice) },
                                            set: { newValue in
                                                if let value = Double(newValue) {
                                                    parts[index].partPrice = value
                                                }
                                            }
                                        ))
                                        .multilineTextAlignment(.trailing)
                                    }
                                    .textFieldStyle(DefaultTextFieldStyle())
                                    
                                    HStack {
                                        Text("$\(String(format: "%.2f", parts[index].partPrice * Double(parts[index].partQty)))")
                                            .multilineTextAlignment(.leading)
                                        Stepper ("Qty: \(parts[index].partQty)", value: $parts[index].partQty, in: 0...100)
                                            .multilineTextAlignment(.trailing)
                                        //.labelsHidden()
                                    }
                                    .font(.body)
                                }
                            }
                            
                        } //for loop ends here
                        .onDelete(perform: deletePart)
                        .foregroundColor(.gray)
                        .font(.title3)
                        .foregroundColor(.white)
                        HStack {
                            Button("Add More") {
                                parts.append(Part(partName: "", partQty: 0, partPrice: 0.0))
                            }
                        }
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        Button("Save") {
                            
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
            }
        }
    }
    func deletePart(at offsets: IndexSet) {
        parts.remove(atOffsets: offsets)
    }
}

/*
 struct PartManager_Previews: PreviewProvider {
     static var previews: some View {
         PartManager(parts: .constant([Part(partName: "", partQty: 0, partPrice: 0.0)]), servicePrice: .init())
    }
 }

*/
