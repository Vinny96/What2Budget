//
//  expenseTableViewController.swift
//  What2Budget
//
//  Created by Vinojen Gengatharan on 2021-02-23.
//

import Foundation
import UIKit
import CoreData

class expenseTableViewController : UIViewController
{
    // variables
    var arrayOfExpenses : [ExpenseModel] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let startDateAsString : String = String()
    let endDateAsString : String = String()
    
    // IB Outlets
    @IBOutlet weak var startDate: UILabel!
    @IBOutlet weak var endDate: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    
    
    
    //MARK: - Functions
    private func initialize()
    {
        tableView.delegate = self
        tableView.register(UINib(nibName: "expenseCell", bundle: .main), forCellReuseIdentifier: "expenseCellToUse")
        startDate.text = startDateAsString
        endDate.text = endDateAsString
    }
    
}
//MARK: - TableView Extensions
extension expenseTableViewController : UITableViewDelegate
{
    
}

extension expenseTableViewController : UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfExpenses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "expenseCellToUse", for: indexPath) as! expenseCell
        cell.amountSpent.text = String(arrayOfExpenses[indexPath.row].amountSpent)
        cell.providerTitle.text = arrayOfExpenses[indexPath.row].companyName
        cell.notes.text = arrayOfExpenses[indexPath.row].notes
        return cell
    }
    
}

