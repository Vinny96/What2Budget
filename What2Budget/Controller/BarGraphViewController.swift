//
//  BarGraphViewController.swift
//  What2Budget
//
//  Created by Vinojen Gengatharan on 2021-02-04.
//

import UIKit
import Charts


class BarGraphViewController: UIViewController, ChartViewDelegate {

    // variables
    internal var dictOfExpenses : [String:Float] = [:]
    private var barChart = BarChartView()
    private var entries = [BarChartDataEntry]()
    private var arrayOfExpenseNames : [String] = []
    
    // IB Outlets
    @IBOutlet weak var chartView: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("This is BarGraphViewController's dictOfExpenses")
        print(dictOfExpenses)
        arrayOfExpenseNames = generateArrayOfExpenseNames()
        barChart.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        barChart.frame = CGRect(x: 0, y: 0, width: chartView.frame.width, height: chartView.frame.height)
        barChart.center = chartView.center
        view.addSubview(barChart)
        createBarGraph()
    }
    
    //MARK: -Functions
    private func createBarGraph()
    {
        setBarChartData()
        let set = BarChartDataSet(entries) // here we are creating the BarChartDataSet object from our array of BarChartDataEntry objects
        set.colors = ChartColorTemplates.joyful() // here we are setting the colour of our BarChartDataSet
        barChart.rightAxis.enabled = false
        barChart.leftAxis.labelFont = .boldSystemFont(ofSize: 12)
        barChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: arrayOfExpenseNames) // this creates labels for the xAxis using our arrayOfExpenses array.
        barChart.xAxis.labelPosition = .top
        barChart.xAxis.granularity = 1 // minimum interval between x values
        barChart.xAxis.wordWrapEnabled = true // wraps the label text so there is no overlapping with other labels.
        let data = BarChartData(dataSet: set) // here we are creating a BarChartData object from our BarChartData set.
        barChart.data = data
        barChart.fitBars = true
    }
    
    private func setBarChartData()
    {
        var xValue = 0
        for expense in dictOfExpenses
        {
            let yValue = expense.value
            entries.append(BarChartDataEntry(x: Double(xValue), y: Double(yValue)))
            xValue += 1
        }
    }
    
    private func generateArrayOfExpenseNames() -> [String] // O(N) run time
    {
        var arrayToReturn : [String] = []
        for expenseObject in dictOfExpenses
        {
            arrayToReturn.append(expenseObject.key)
        }
        return arrayToReturn
    }

}
