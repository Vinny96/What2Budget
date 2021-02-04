//
//  chartsViewController.swift
//  What2Budget
//
//  Created by Vinojen Gengatharan on 2021-02-04.
//

import Foundation
import UIKit
class ChartsViewController : UITabBarController
{
    // variables
    internal var parentDictOfExpenses : [String : Float] = [:]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        print("Printing from ChartsViewController")
        print(parentDictOfExpenses)
        passDataToRootVCs()
        
    }
    
    //MARK: - Functions
    private func passDataToRootVCs()
    {
        let firstVC = self.viewControllers![0] as! BarGraphViewController
        let secondVC = self.viewControllers![1] as! PieChartViewController
        firstVC.dictOfExpenses = parentDictOfExpenses
        secondVC.dictOfExpenses = parentDictOfExpenses
    }
    
}

//MARK: - adopting tabBarDelegate
extension ChartsViewController : UITabBarControllerDelegate
{
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController)
    {
        if(viewController is BarGraphViewController)
        {
            print("Going to BarGraphViewController")
        }
        else
        {
           print("Going to PieChartViewController")
        }
    }
    
    
}
