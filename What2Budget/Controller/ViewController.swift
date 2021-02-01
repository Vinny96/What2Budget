//
//  ViewController.swift
//  What2Budget
//
//  Created by Vinojen Gengatharan on 2021-01-31.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeVC()
    }
    
    // MARK: - Functions
    private func initializeVC()
    {
        navigationController?.navigationBar.barTintColor = UIColor(named: "mainVcColour")
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backBarButtonItem
        
    }
    
    // MARK: - IB Actions
    @IBAction func goToHomeVC(_ sender: Any) {
       
    }
    
    @IBAction func goToShoppingVC(_ sender: Any) {
        performSegue(withIdentifier: "toShopping", sender: self)
    }
    
}





