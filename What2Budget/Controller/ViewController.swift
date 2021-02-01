//
//  ViewController.swift
//  What2Budget
//
//  Created by Vinojen Gengatharan on 2021-01-31.
//

import UIKit

class ViewController: UIViewController {
    
    // variables
    internal var monthlyIncome : Float = Float()
    
    // IB Outlets
    @IBOutlet weak var monthlyIncomeLabel: UILabel!
    @IBOutlet weak var groceriesAmount: UILabel!
    @IBOutlet weak var shoppingAmount: UILabel!
    @IBOutlet weak var billsAmount: UILabel!
    @IBOutlet weak var homeAmount: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeVC()
    }
    
    // MARK: - Functions
    private func initializeVC()
    {
        navigationController?.navigationBar.barTintColor = UIColor(named: "mainVcColour")
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        monthlyIncome = getMonthlyIncome()
    }
    
    private func getMonthlyIncome() -> Float
    {
        if(monthlyIncomeLabel.text == "")
        {
            let monthlyIncomeToReturn : Float = 0.0
            return monthlyIncomeToReturn
        }
        else
        {
            let monthlyIncomeAsString = monthlyIncomeLabel.text!
            let monthlyIncomeToReturn = (monthlyIncomeAsString as NSString).floatValue
            return monthlyIncomeToReturn
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backBarButtonItem
        if(segue.identifier == "toShopping")
        {
            let destinationSegue : ShoppingViewController = segue.destination as! ShoppingViewController
            destinationSegue.shoppingExpenseAmount = (shoppingAmount.text! as NSString).floatValue
            print((shoppingAmount.text! as NSString).floatValue)
        }
        
    }
    
    // MARK: - IB Actions
    @IBAction func goToHomeVC(_ sender: Any) {
       
    }
    
    @IBAction func goToShoppingVC(_ sender: Any) {
        performSegue(withIdentifier: "toShopping", sender: self)
    }
    
}





