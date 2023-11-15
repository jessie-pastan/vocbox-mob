//
//  ProUpgradeView.swift
//  VocBox
//
//  Created by Jessie Pastan on 10/5/23.
//

import SwiftUI
import StoreKit

struct ProUpgradeView: View {
    
    @EnvironmentObject var storeViewModel: StoreViewModel
    @Environment(\.colorScheme) var colorScheme
    @State var isPurchased = false
    @Environment(\.openURL) var openURL
    
    var body: some View {
        
        VStack {
            Spacer()
            if colorScheme == .light {
                Image("unlocked_light")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }else {
                Image("unlocked_dark")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
            
            VStack {
                VStack(alignment: .center) {
                    Text(" Unlock limited")
                    Text("vocabulary adding")
                }
                .padding(.top, -30)
                .font(.custom(.playfairBold, size: 30))
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 30){
                    HStack {
                        Image(systemName: "checkmark.square")
                        Text("Expand your own vocabulary")
                    }
                    
                    HStack {
                        Image(systemName: "checkmark.square")
                        Text("Unlimited vocabulary adding")
                    }
                    
                    HStack(alignment: .firstTextBaseline) {
                        Image(systemName: "checkmark.square")
                        Text("Reinforce vocabulary memory with fun challenge")
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    
                    HStack(alignment: .firstTextBaseline){
                        Image(systemName: "checkmark.square")
                        Text("Set reminder for your daily vocabulary study time")
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    
                    HStack(alignment: .firstTextBaseline) {
                            Image(systemName: "checkmark.square")
                            Text("Quick vocabulary glance on the widget screen")
                            .fixedSize(horizontal: false, vertical: true)
                        }
                      
                }
                .padding(.horizontal)
                .padding(.top, 5)
               
                
                Spacer()
                
                
                ForEach(storeViewModel.subscriptions) { product in
                    VStack(spacing: -5) {
                        Button {
                            Task {
                                await buy(product: product)
                            }
                            
                        } label: {
                            
                            GeometryReader { proxy in
                                SubScriptionButton(title: "Start 3 days free trial", subtitle: "then $9.99 / year")
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 70)
                        }
                        .padding()
                        
                        //MARK: privacy policy / terms of use / restore subscribtion
                        HStack {
                            //privacy policy
                            Spacer()
                            Button {
                                if let link = AppConstants.privacyPolicyLink {
                                    openURL(link)
                                }
                            } label: {
                                Text("Privacy policy")
                            }
                            Spacer()
                            
                            //restore
                            Spacer()
                            
                            Button{
                                //This call display a system prompt ask users to autheticate with their App stroe credentails.
                                //Call this function only in response to a explicit user action, such as tapping a button
                                Task {
                                    try? await AppStore.sync()
                                }
                            } label: {
                                Text("Restore")
                            }
                            Spacer()
                            
                            //terms of use
                            Spacer()
                            Button {
                                if let link = AppConstants.termsOfUseLink {
                                    openURL(link)
                                }
                            } label: {
                                Text("Terms of use")
                            }
                            
                            Spacer()
                        }
                        .foregroundStyle(Color(.card))
                        .font(.footnote)
                        .padding(.horizontal, 20)
                        .padding(.bottom)
                        
                    }
                    
                }
            }
           
        }
        .background(Color(.background))
      
        
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
    ProUpgradeView()
        .environmentObject(StoreViewModel())
}
