//
//  CheckoutView.swift
//  iDine
//
//  Created by Afnan Ahmad on 25/10/2023.
//

import SwiftUI

struct CheckoutView: View {
    
    @EnvironmentObject var order: Order
    
    @State private var paymentType = "Cash"
    
    @State private var addLoayltyDetails = false
    @State private var loyaltyNumber = ""
    
    let tipAmounts = [10, 15, 20, 25, 0]
    @State private var tipAmount = 15
    
    let paymentTypes = ["Cash", "Credit Card", "iDine Points"]
    
    var totalPrice: String {
        let total = Double(order.total)
        let tipValue = total / 100 * Double(tipAmount)
        return (total + tipValue).formatted(.currency(code: "USD"))
    }
    
    @State private var showingPaymentAlert = false
    
    let pickupOptions = ["Now", "Tonight", "Tommorrow Morning"]
    @State private var pickup = "Now"
    
    var body: some View {
        Form {
            Section {
                Picker("How do you want to pay?", selection: $paymentType) {
                    ForEach(paymentTypes, id: \.self) {
                        Text($0)
                    }
                }
                
                Toggle("Add iDine loyalty card", isOn: $addLoayltyDetails.animation())
                
                if addLoayltyDetails {
                    TextField("Enter your iDine ID", text: $loyaltyNumber)
                }
            }
            
            Section("Add a tip?") {
                Picker("Percentage:", selection: $tipAmount) {
                    ForEach(tipAmounts, id: \.self) {
                        Text("\($0)$")
                    }
                }
                .pickerStyle(.segmented)
            }
            
            Section("Pickup Time?") {
                Picker("Time:", selection: $pickup) {
                    ForEach(pickupOptions, id: \.self) {
                        Text($0)
                    }
                }
            }
            
            Section("Total: \(totalPrice)") {
                Button("Confirm order") {
                    //place the order
                    showingPaymentAlert.toggle()
                }
            }
        }
        .navigationTitle("Payment")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Order confirmed", isPresented: $showingPaymentAlert) {
            //show buttons
        } message: {
            Text("Your total was \(totalPrice) - thank you!")
        }
    }
}

#Preview {
    CheckoutView().environmentObject(Order())
}
