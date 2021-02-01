//
//  expense.swift
//  What2Budget
//
//  Created by Vinojen Gengatharan on 2021-01-31.
//

import Foundation
class Expense
{
    // properties
    private let name : String
    private let amount : Float
    private let note : String
    
    // initializer
    init(nameVal : String, amountVal : Float, noteVal : String) {
        name = nameVal
        amount = amountVal
        note = noteVal
        print("The expense object has been initialized")
    }
    
    // deinitializer
    deinit {
        print("The expense obejct has been deinitialized. ")
    }
}
