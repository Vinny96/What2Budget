//
//  shoppingExpense.swift
//  What2Budget
//
//  Created by Vinojen Gengatharan on 2021-01-31.
//

import Foundation
class ShoppingExpense : Expense
{
    // properties
    private var retailerName : String
    private var amountSpent : Float
    private var note : String
    
    // initializers
    init(retailerNameVal : String, amountSpentVal : Float, noteVal : String)
    {
        retailerName = retailerNameVal
        if(amountSpentVal < 0)
        {
            amountSpent = 0
        }
        else
        {
            amountSpent = amountSpentVal
        }
        note = noteVal
        print("The shoppingExpense instance is now being initialized.")
        super.init(nameVal: retailerName, amountVal: amountSpent, noteVal: note)
    }
    
    // deinitializer
    deinit {
        print("The shoppingExpense instance is now being deinitialized.")
    }
    
    
    // getter methods
    internal func getRetailerName() -> String
    {
        return self.retailerName
    }
    
    internal func getAmountSpent() -> Float
    {
        return self.amountSpent
    }
    
    internal func getNote() -> String
    {
        return self.note
    }
    
}
