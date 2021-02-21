//
//  HomeViewController.swift
//  What2Budget
//
//  Created by Vinojen Gengatharan on 2021-02-21.
//

import Foundation
import UIKit
import CoreData

class HomeViewController : UIViewController
{
    // variables
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var arrayOfMainExpenses : [MainExpenseModel] = []
    var amountSpentDict : [String : Int] = [:]
    var arrayOfExpenseNames : [String] = [ExpenseNames.groceriesExpenseName,ExpenseNames.transportationExpenseName,ExpenseNames.carExpenseName,ExpenseNames.lifeStyleExpenseName,ExpenseNames.shoppingExpenseName,ExpenseNames.subscriptionsExpenseName]
    
    // IB Outlets
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeVC()
    }
    
    
    
    
    // MARK: - Functions
    private func initializeVC()
    {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 158
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        loadContext()
        tableView.register(UINib(nibName: "mainTableViewCell", bundle: .main), forCellReuseIdentifier: "mainCellToUse")
    }
    
    private func createAmountSpentDic()
    {
        
    }
    
    
    // MARK: - CRUD Functionality
    private func loadContext(request : NSFetchRequest<MainExpenseModel> = MainExpenseModel.fetchRequest())
    {
        do
        {
            try arrayOfMainExpenses = context.fetch(request)
        }catch
        {
            print("There was an error in reading from the context.")
            print(error.localizedDescription)
        }
    }
    
    
}

//MARK: - TableView delegate and TableView DataSource extension
extension HomeViewController : UITableViewDelegate
{
    
    
    
    
}


extension HomeViewController : UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfExpenseNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainCellToUse", for: indexPath) as! mainTableViewCell
        cell.expenseTitle.text = arrayOfExpenseNames[indexPath.row]
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
}
