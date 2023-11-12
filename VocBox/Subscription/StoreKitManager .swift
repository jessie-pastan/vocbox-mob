//
//  StoreKitManager .swift
//  VocBox
//
//  Created by Jessie Pastan on 11/11/23.
//

import Foundation
import StoreKit

typealias RenewalState = StoreKit.Product.SubscriptionInfo.RenewalState

class StoreViewModel: ObservableObject {
    @Published private(set) var subscriptions: [Product] = []
    @Published private(set) var purchasedSubsriptions: [Product] = []
    @Published private(set) var subscriptionGroupStatus: RenewalState?
    
    
    private let productId: [String] = ["VocBox_999_1y"]
    var updateListenerTask: Task<Void, Error>? = nil
    
    init() {
        //soon as app open
        updateListenerTask = listenForTransactions()
        Task {
            await requestProducts()
            await updateCutomerProductStatus()
        }
    }
    
    deinit {
        updateListenerTask?.cancel()
    }
    
    
    
    func listenForTransactions() -> Task<Void, Error> {
        return Task.detached {
            //Iterate through any transactions that don't come from direct call to 'purchase()'
            for await result in Transaction.updates {
                do {
                    let transaction = try self.checkVerified(result: result)
                    //deliver ptoduct to user
                    await self.updateCutomerProductStatus()
                    await transaction.finish()
                } catch {
                    print("Transaction failed verification")
                }
            }
        }
    }
    
    @MainActor
    func requestProducts() async {
        do {
            // request from the app store using the product ids(hardcoded)
            subscriptions = try await Product.products(for: productId)
            print(subscriptions)
        }catch {
            print("Failed product request from app store server: \(error)")
            
        }
        
    }
    
    //purchase the product
    func purchase(product: Product) async throws -> Transaction? {
        let result = try await product.purchase()
        switch result {
        case .success(let verification):
            // Check whether the transaction is verified. if it isn't
            //this fuction will rethrows the verification error.
            let transaction = try checkVerified(result: verification)
            
            //The transaction is verified, Deliver content to the user.
            await updateCutomerProductStatus()
            
            //always finish a transaction
            await transaction.finish()
            
            return transaction
            
        case .userCancelled, .pending:
            return nil
            
        default:
            return nil
        }
    }
    
    
    //Verify result of transaction
    func checkVerified<T>(result: VerificationResult<T>) throws -> T {
        //Check whether the JWS passes Storekit verification
        
        switch result {
        case.unverified:
            //StoreKit parses the JWS, but it fails verification
            throw StoreError.failedVerification
            
        case.verified(let safe):
            //The result is verified, Return the unwrapped value
            return safe
        }
    }
    
    @MainActor
    func updateCutomerProductStatus() async {
        for await result in Transaction.currentEntitlements {
            do {
                //check whether the transacrtio  is verified. If it isn't, catch the failedVerification error
                let transaction = try checkVerified(result: result)
                switch transaction.productType {
                case .autoRenewable:
                    if let subscription  = subscriptions.first(where: {$0.id == transaction.productID}) {
                        purchasedSubsriptions.append(subscription)
                    }
                default:
                    break
                }
                //Always finish a transaction
                await transaction.finish()
                
            }catch {
                print("Failed updating products")
                
            }
            
        }
        
        
    }
    
    public enum StoreError: Error {
        case failedVerification
    }
    
    
}
