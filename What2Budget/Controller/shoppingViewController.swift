//
//  shoppingViewController.swift
//  What2Budget
//
//  Created by Vinojen Gengatharan on 2021-01-31.
//


import UIKit
import CoreData
class ShoppingViewController : UIViewController
{
    // variables
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private let typeOfObject : String = "Shopping"
    private var arrayOfExpenses : [ExpenseModel] = [] // will be loaded in via core data
    private var arrayOfShoppingExpenses : [ShoppingExpense] = [] // this is the array that we will be directly working with and this array will have the exact same contents as arrayOfShoppingExpenses
    
    // IB Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var toolBar: UIToolbar!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        initializeVC()
    }
    
    //MARK: - IB Actions
    @IBAction func addShoppingExpense(_ sender: UIBarButtonItem)
    {
        let expenseToAdd = ExpenseModel(context: context)
        var textFieldOne = UITextField()
        var textFieldTwo = UITextField()
        var textFieldThree = UITextField()

        var shoppingExpenseAmount : Float = 0
        var shoppingNote : String = ""
        var retailer : String = ""
        
        // creating the three alert controllers
        let firstAlertController = UIAlertController(title: "Step 1 of 3", message: "Please enter the name of the retailer", preferredStyle: .alert)
        let secondAlertController = UIAlertController(title: "Step 2 of 3", message: "Please enter how much you spent", preferredStyle: .alert)
        let thirdAlertController = UIAlertController(title: "Step 3 of 3", message: "Please enter any notes if you like", preferredStyle: .alert)
        
        // adding the text fields for the alert controllers
        firstAlertController.addTextField { (firstAlertTextfield) in
            textFieldOne = firstAlertTextfield
            textFieldOne.placeholder = "Please enter name of retailer here."
        }
        
        secondAlertController.addTextField { (secondAlertTextField) in
            textFieldTwo = secondAlertTextField
            textFieldTwo.keyboardType = .decimalPad
            textFieldTwo.placeholder = "Please enter how much you spent here exclude the dollar sign."
        }
        
        thirdAlertController.addTextField { (thirdAlertTextField) in
            textFieldThree = thirdAlertTextField
            textFieldThree.placeholder = "Please enter any notes regarding the purchase."
        }
        
        

        // creating the alert actions for the alert controllers
        let firstAlertAction = UIAlertAction(title: "Add name", style: .default) { (firstAlertAction) in
            if(textFieldOne.text != "" && textFieldOne.text != nil)
            {
                retailer = textFieldOne.text!
                expenseToAdd.name = retailer
                expenseToAdd.type = self.typeOfObject
                self.present(secondAlertController, animated: true, completion: nil)
            }
            else
            {
                self.context.delete(expenseToAdd)
                let alertController = UIAlertController(title: "Cannot add without name of retailer.", message: "", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alertController.addAction(alertAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
        let firstAlertActionTwo = UIAlertAction(title: "Cancel", style: .cancel) { (firstAlertActionTwo) in
            self.context.delete(expenseToAdd)
        }
        firstAlertController.addAction(firstAlertAction)
        firstAlertController.addAction(firstAlertActionTwo)
        
        
        let secondAlertAction = UIAlertAction(title: "Add amount", style: .default) { (secondAlertAction) in
            if(textFieldTwo.text != "" && textFieldTwo.text != nil)
            {
                shoppingExpenseAmount = (textFieldTwo.text! as NSString).floatValue
                expenseToAdd.amount = shoppingExpenseAmount
                self.present(thirdAlertController, animated: true, completion: nil)
            }
            else
            {
                self.context.delete(expenseToAdd)
                let alertController = UIAlertController(title: "Cannot add without amount spent", message: "", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "Ok", style: .cancel) { (alertAction) in
                    retailer = ""
                }
                alertController.addAction(alertAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
        let secondAlertActionTwo = UIAlertAction(title: "Cancel", style: .cancel) { (secondAlertActionTwo) in
            retailer = ""
            self.context.delete(expenseToAdd)
        }
        secondAlertController.addAction(secondAlertAction)
        secondAlertController.addAction(secondAlertActionTwo)
        
        
        let thirdAlertAction = UIAlertAction(title: "Add note", style: .default) { (thirdAlertAction) in
            if(textFieldThree.text != "" && textFieldThree.text != nil)
            {
                shoppingNote = textFieldThree.text!
                expenseToAdd.note = shoppingNote
                let shoppingExpenseToAdd = self.createShoppingExpense(expenseModel: expenseToAdd)
                self.arrayOfShoppingExpenses.append(shoppingExpenseToAdd)
                self.saveContext()
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            else
            {
                self.context.delete(expenseToAdd)
                shoppingExpenseAmount = 0
                retailer = ""
            }
        }
        let thirdAlertActionTwo = UIAlertAction(title: "Cancel", style: .cancel) { (thirdAlertActionTwo) in
            retailer = ""
            shoppingExpenseAmount = 0
            self.context.delete(expenseToAdd)
        }
        thirdAlertController.addAction(thirdAlertAction)
        thirdAlertController.addAction(thirdAlertActionTwo)
        
        // presenting the alert controller
        present(firstAlertController, animated: true, completion: nil)
        

        
        /* So here what we are doing is we are creating an expense model, and once the expense model has been fully initialized this is going to be the case by the time we get to the third alert controller and add note has been pressed. At this point we create a shopping expense model that is the exact same as that expense model object, we save it to the context and we add our shopping expense model object to our arrayOfShoppingExpenses and we reload the table view. The reason we are doing this instead of just creating an expense model object and calling loadArray of shopping expenses has to do with performance. If we were to do it this way the complexity would be O(N*M)  N being the number of shopping expense objects already in the array and M being the number of expense model objects we made and remember loadArray will create a shoppingModel object for every expenseModel object. On top of that we also have to reload the table view which will be O(M*N) M for the number shopping model objects we have to add to the tableview and N for every shopping Model object in the array already. So the total runtime will be O(M*N) + O(M*N). Now with the way I am doing it is just going to be O(M*N) as if we want to add M number of expense objects we need to load N number of shoppingExpense objects in the array M times for reloadTableView. There is nothing else we are doing here as adding to the array is done in constant time as we are just appending to the back of the array. For scalablity the way I am doing it above will be faster as we are only calling loadArray once when the VC loads and thats it. */
    
    }
    //MARK: - CRUD Functionality
    private func saveContext()
    {
        do
        {
            try context.save()
            print("If no line runs beneath this then we have saved to the context successfully.")
        }catch
        {
            print("There was an error in saving the shopping expenses to the context.")
            print(error.localizedDescription)
        }
    }
    
    private func loadContext(request : NSFetchRequest<ExpenseModel> = ExpenseModel.fetchRequest())
    {
        //request.predicate = NSPredicate(format: "type MATCHES %@", typeOfObject)
        do
        {
            arrayOfExpenses = try context.fetch(request)
        }catch
        {
            print("There was an error in retreiving the expense items with the type ShoppingExpense from the persistent store.")
            print(error.localizedDescription)
        }
        
    }
    
    //MARK: - Functions
    private func initializeVC()
    {
        navigationController?.navigationBar.barTintColor = UIColor(named: "shoppingToolBarColour")
        loadContext()
        loadArrayOfShoppingExpenses()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 190
        tableView.register(UINib(nibName: "shoppingCell", bundle: .main), forCellReuseIdentifier: "shoppingCellToUse")
        title = "Shopping"
    }
    
    
    
    private func loadArrayOfShoppingExpenses()
    {
        for expenseModel in arrayOfExpenses
        {
            // so here all of the expense model objects will not be empty
            let shoppingModelToAdd = ShoppingExpense(retailerNameVal: expenseModel.name ?? "", amountSpentVal: expenseModel.amount, noteVal: expenseModel.note ?? "")
            arrayOfShoppingExpenses.append(shoppingModelToAdd)
        }
    }
    
    private func createShoppingExpense(expenseModel : ExpenseModel) -> ShoppingExpense
    {
        let shoppingExpenseToReturn = ShoppingExpense(retailerNameVal: expenseModel.name!, amountSpentVal: expenseModel.amount, noteVal: expenseModel.note!)
        return shoppingExpenseToReturn
    }
    
}
//MARK: -TableViewDelegate and dataSource extension
extension ShoppingViewController : UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }
    
}

extension ShoppingViewController : UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfShoppingExpenses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "shoppingCellToUse", for: indexPath) as! shoppingCell
        let shoppingExpenseObject = arrayOfShoppingExpenses[indexPath.row]
        cell.retailer.text = shoppingExpenseObject.getRetailerName()
        cell.amount.text = "$"+String(shoppingExpenseObject.getAmountSpent())
        cell.note.text = shoppingExpenseObject.getNote()
        return cell
    }
}


