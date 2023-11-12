//
//  TestSubscription.swift
//  VocBox
//
//  Created by Jessie Pastan on 11/11/23.
//

import SwiftUI
import StoreKit
/*
struct TestSubscription: View {
    
    
    @StateObject var storeViewModel = StoreViewModel()
    @State var isPurchased = false
    
    var body: some View {
        VStack {
            if storeViewModel.purchasedSubsriptions.isEmpty {
                ForEach(storeViewModel.subscriptions) { product in
                Button {
                    Task {
                        await buy(product: product)
                    }
                    
                } label: {
                    Text("Go premium")
                    Text("for only $9.99 a year")
                }
            }
                
            }else {
                Text("Premium Subscription")
            }
        }
        .environmentObject(storeViewModel)
        
        
        
    }
    
    func buy(product: Product) async {
        do {
            if try await storeViewModel.purchase(product: product) != nil {
                isPurchased = true
            }
        } catch {
            print("Purchase failed")
        }
        
    }
}

#Preview {
    TestSubscription()
}
*/
