//
//  iDineApp.swift
//  iDine
//
//  Created by Afnan Ahmad on 24/10/2023.
//

import SwiftUI

@main
struct iDineApp: App {
    
    @StateObject var order = Order()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(order)
        }
    }
}
