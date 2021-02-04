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
    // functions
    static func createExpenseDictionaryForGraph (expenseArray : [Expense]) -> [String:Float]
    {
        var dictionaryOfExpenses : [String : Float] = [:]
        for expense in expenseArray
        {
            if(dictionaryOfExpenses[expense.name] == nil)
            {
                // so this means that the name is not yet in the dictionary
                dictionaryOfExpenses.updateValue(expense.amount, forKey: expense.name)
            }
            else
            {
                // so this means that the name is in the dictionary so we just want to update its value
                if let safeValue = dictionaryOfExpenses[expense.name]
                {
                    let newValueToAdd = expense.amount + safeValue
                    dictionaryOfExpenses.updateValue(newValueToAdd, forKey: expense.name)
                }
            }
        
        }
        
        
        
        return dictionaryOfExpenses
        // the prupose of the above method is to go through the data of expenses and return a dictionary of each store with the total amount spent. So duplicate entries of the same name will be combined into one entry for the dictionary. This will make it easier to generate the charts from. The run time of this function is O(N) as we are only iterating through the array once.
    }
    
}
