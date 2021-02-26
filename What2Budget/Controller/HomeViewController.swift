//
//  HomeViewController.swift
//  What2Budget
//
//  Created by Vinojen Gengatharan on 2021-02-21.
//

import UIKit
import CoreData

class HomeViewController : UIViewController
{
    // variables
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let defaults = UserDefaults.standard
    var arrayOExpenseModelObjects : [ExpenseModel] = []
    
    var amountSpentDict : [String : Float] = [ExpenseNames.groceriesExpenseName : 0,ExpenseNames.transportationExpenseName : 0,ExpenseNames.carExpenseName: 0,ExpenseNames.lifeStyleExpenseName : 0,ExpenseNames.shoppingExpenseName : 0,ExpenseNames.subscriptionsExpenseName : 0,]
    
    var numberOfEntriesDict : [String : Int] = [ExpenseNames.groceriesExpenseName : 0,ExpenseNames.transportationExpenseName : 0,ExpenseNames.carExpenseName: 0,ExpenseNames.lifeStyleExpenseName : 0,ExpenseNames.shoppingExpenseName : 0,ExpenseNames.subscriptionsExpenseName : 0,]
    
    var arrayOfExpenseNames : [String] = [ExpenseNames.groceriesExpenseName,ExpenseNames.transportationExpenseName,ExpenseNames.carExpenseName,ExpenseNames.lifeStyleExpenseName,ExpenseNames.shoppingExpenseName,ExpenseNames.subscriptionsExpenseName]
    
    // IB Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var incomeForPeriod: UILabel!
    @IBOutlet weak var startDate: UILabel!
    @IBOutlet weak var endDate: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeVC()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear")
        loadContext()
        resetAllDictionaries()
        initializeAmountSpentDic()
        initializeNumberOfEntriesSpentDict()
        tableView.reloadData()
        incomeForPeriod.text = String(defaults.float(forKey: "Set Income"))
        startDate.text = defaults.string(forKey: "Set Start Date")
        endDate.text = defaults.string(forKey: "Set End Date")
    }
    
    
    // MARK: - Functions
    private func initializeVC()
    {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 158
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String)
        tableView.register(UINib(nibName: "mainTableViewCell", bundle: .main), forCellReuseIdentifier: "mainCellToUse")
        print("View Controller is being initialized.")
    }
    
    private func initializeAmountSpentDic() // O(N) Time and O(1) Space
    {
        for expenseModelObject in arrayOExpenseModelObjects
        {
            let amountSpentToAdd = expenseModelObject.amountSpent
            let typeOfExpense = expenseModelObject.typeOfExpense
            var originalAmountSpent = amountSpentDict[typeOfExpense!]
            originalAmountSpent?.round(.up)
            amountSpentDict.updateValue(originalAmountSpent! + amountSpentToAdd, forKey: typeOfExpense!)
        }
        print(amountSpentDict)
    }
    
    private func initializeNumberOfEntriesSpentDict() // O(N) time and O(1) Space
    {
        for expenseModelObj in arrayOExpenseModelObjects
        {
            let typeOfExpense = expenseModelObj.typeOfExpense
            let originalValue = numberOfEntriesDict[typeOfExpense!]
            let newValue = originalValue! + 1
            numberOfEntriesDict.updateValue(newValue, forKey: typeOfExpense!)
        }
        print(numberOfEntriesDict)
    }
    
    private func resetAllDictionaries()
    {
        // reseting all dictionaries
        for expenseName in arrayOfExpenseNames
        {
            numberOfEntriesDict.updateValue(0, forKey: expenseName)
            amountSpentDict.updateValue(0, forKey: expenseName)
        }
        
    }
    
    private func createProgressCircle(viewToUse : UIView, strokeEnd : CGFloat)
    {
        let circleLayerPath = UIBezierPath(arcCenter: CGPoint(x: viewToUse.frame.size.width / 2, y: viewToUse.frame.size.height / 2), radius: viewToUse.frame.size.height / 2, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
        let trackLayer = CAShapeLayer()
        trackLayer.path = circleLayerPath.cgPath
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineWidth = 3
        trackLayer.lineCap = .round
        trackLayer.position = viewToUse.center
        viewToUse.layer.addSublayer(trackLayer)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circleLayerPath.cgPath
        shapeLayer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
        shapeLayer.strokeEnd = CGFloat(strokeEnd)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.lineCap = .round
        shapeLayer.position = viewToUse.center
        viewToUse.layer.addSublayer(shapeLayer)
        
        // animating the shapeLayer
        removeAllAnimations(shapeLayerToRemoveAnimationsFrom: shapeLayer)
        animateShapeLayer(shapeLayerToAnimate: shapeLayer)
        
    }
    
    private func animateShapeLayer(shapeLayerToAnimate : CAShapeLayer)
    {
        print("animating")
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = 1
        animation.duration = 2.0
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        shapeLayerToAnimate.add(animation, forKey: "animate")
    }
    
    private func removeAllAnimations(shapeLayerToRemoveAnimationsFrom shapeLayer : CAShapeLayer)
    {
        shapeLayer.removeAllAnimations()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "toSettings")
        {
            print("Going to settings")
        }
        if(segue.identifier == "toExpenseTableView")
        {
            let destinationVC = segue.destination as! expenseTableViewController
            let selectedIndexPath = tableView.indexPathForSelectedRow
           if let safeIndexPath = selectedIndexPath
           {
            destinationVC.typeOfExpense = arrayOfExpenseNames[safeIndexPath.row]
            if let safeStartDate = startDate.text
            {
                destinationVC.startDateAsString = safeStartDate
            }
            if let safeEndDate = endDate.text
            {
                destinationVC.endDateAsString = safeEndDate
            }
           }
        }
    }
    
    // MARK: - IBActions
    @IBAction func settingsPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "toSettings", sender: self)
    }
    
    
    // MARK: - CRUD Functionality
    private func loadContext(request : NSFetchRequest<ExpenseModel> = ExpenseModel.fetchRequest())
    {
        do
        {
            try arrayOExpenseModelObjects = context.fetch(request)
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toExpenseTableView", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
}


extension HomeViewController : UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfExpenseNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainCellToUse", for: indexPath) as! mainTableViewCell
        cell.expenseTitle.text = arrayOfExpenseNames[indexPath.row]
        cell.amountAllocated.text = String(defaults.float(forKey: arrayOfExpenseNames[indexPath.row]))
        cell.numberOfEntries.text = String(numberOfEntriesDict[arrayOfExpenseNames[indexPath.row]] ?? 0)
        cell.amountSpent.text = String(amountSpentDict[arrayOfExpenseNames[indexPath.row]] ?? 0)
        // beta code
        let keyToUse = cell.expenseTitle.text!
        let amountSpent = amountSpentDict[keyToUse]
        let allocatedAmount = defaults.float(forKey: keyToUse)
        let strokeEnd : CGFloat = CGFloat(amountSpent! / allocatedAmount)
        print(strokeEnd)
        createProgressCircle(viewToUse: cell.circleAnimationView!, strokeEnd: strokeEnd)
        // end of beta code
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
}
//MARK: - Explanation
/*
 So with the three dictionary methods in the viewWillAppear method this is the explanation behind them. Anytime we add a new expense object in the expenseTableView we want these changes to be reflected in our HomeViewController. HomeViewController is only loaded in once so we cannot pass these methods into viewDidLoad as it will only get called the first time and will not get called again. So in order for the changes to be relfected in this view controller the methods have to be called in the viewWillAppear method. Now one issue that arose is when we switched back and forth from the two viewControllers the values for both dictionaries kept doubling and did not reflect the true value of the total expenseModelObjects nor the number of expenseModelObjects for the entries. So what we did to fix this is we did a reset method. So anytime we come back from expenseTableViewController we would reset both dictionaries to have a value of zero for all keys. Then we call the initialize dictionaries methods to get the appropriate values for the keys and this way we can avoid the doubling. It would be ideal if there was a way to check if the data was changed in the expenseTableViewController and we can maybe some kind of variable down from that view controller to the homeViewController. If this variable indicates that changes have happened then we can do the reset and initialize method.We also have to call load context in the viewWillAppear everytime as we have to take into account the new expenseModel object we have added in the expenseTableView controller. Run time is linear and it would help if this is opitimized. Run time is O(3N) which is O(N).
 
 
 
 
 
 
 
 
 
 
 
 */
