//
//  ViewController.swift
//  PageVC_With_ViewController
//
//  Created by IosDeveloper on 01/02/18.
//  Copyright © 2018 iOSDeveloper. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    ///Container View Outlet
    @IBOutlet weak var baseView: UIView!
    
    ///Label Outlet
    @IBOutlet weak var mainHomeLabel: UILabel!
    
    //MARK: Weak Reference for VC2
    /**
     Reference to View Controller VC2
     - returns: UIViewController Object with Required UI
     */
    private lazy var PageViewControllerObject: PageViewController =
    {
        // Instantiate View Controller
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "PageViewController") as! PageViewController
        
        // Add View Controller as Child View Controller
        self.addChildViewController(viewController)
        return viewController
    }()
    
    //MARK: Add Created Class reference to View
    /**
     This will Add Created UIViewController Object that captured all the UI needed to be displayed in draggable View
     - returns: Returns Parent View Controller with added Subview
     */
    private func add(asChildViewController viewController: UIViewController, baseView: UIView)
    {
        // Configure Child View
        viewController.view.frame = CGRect(x: 0, y: 0, width: baseView.frame.size.width, height: baseView.frame.size.height)
        
        // Add Child View Controller
        addChildViewController(viewController)
        viewController.view.translatesAutoresizingMaskIntoConstraints = true
        
        // Add Child View as Subview
        baseView.addSubview(viewController.view)
        
        // Notify Child View Controller
        viewController.didMove(toParentViewController: self)
    }
}

//MARK:- View Life Cycles
extension ViewController
{
    //MARK: View Did Load
    /**
     Called after the controller's view is loaded into memory
     */
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Observer to update Button Text to record
        NotificationCenter.default.addObserver(self, selector: #selector(updateLabel), name: NSNotification.Name(rawValue: "updateLabelValue"), object: nil)
        
        ///Set Base View Controller
        self.add(asChildViewController: PageViewControllerObject, baseView: baseView)
        
        ///Update Values
        self.mainHomeLabel.text = "VC1"
        
        ///Update PageIndex
        Manager.pageindex = 0
    }
}

//MARK:- Custom Functions
extension ViewController
{
    //MARK: Notification Handler
    @objc func updateLabel()
    {
        switch Manager.pageindex
        {
        case 0:
            self.mainHomeLabel.text = "VC1"
        case 1:
            self.mainHomeLabel.text = "VC2"
        case 2:
            self.mainHomeLabel.text = "VC3"
        default:
            self.mainHomeLabel.text = "VC1"
        }
    }
}

