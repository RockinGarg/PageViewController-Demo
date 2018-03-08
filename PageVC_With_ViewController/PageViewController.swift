//
//  PageViewController.swift
//  PageVC_With_ViewController
//
//  Created by IosDeveloper on 01/02/18.
//  Copyright © 2018 iOSDeveloper. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate
{

    ///Pages Array That Save all the References to be displayed in PageView Controller
    var pages = [UIViewController]()
    
    //MARK: Weak Reference for VC1
    /**
     Reference to View Controller VC1
     - returns: UIViewController Object with Required UI
     */
    private lazy var VC1Object: VC1 =
    {
        // Instantiate View Controller
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "VC1") as! VC1
        
        // Add View Controller as Child View Controller
        self.addChildViewController(viewController)
        return viewController
    }()
    
    //MARK: Weak Reference for VC2
    /**
     Reference to View Controller VC2
     - returns: UIViewController Object with Required UI
     */
    private lazy var VC2Object: VC2 =
    {
        // Instantiate View Controller
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "VC2") as! VC2
        
        // Add View Controller as Child View Controller
        self.addChildViewController(viewController)
        return viewController
    }()
    
    //MARK: Weak Reference for VC3
    /**
     Reference to View Controller VC3
     - returns: UIViewController Object with Required UI
     */
    private lazy var VC3Object: VC3 =
    {
        // Instantiate View Controller
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "VC3") as! VC3
        
        // Add View Controller as Child View Controller
        self.addChildViewController(viewController)
        return viewController
    }()
}

//MARK:- View Life Cycles
extension PageViewController
{
    //MARK: View Did Load
    /**
     Called after the controller's view is loaded into memory
     */
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        pages = [VC1Object,VC2Object,VC3Object]
        
        ///Set Delegate and DataSource
        self.delegate = self
        self.dataSource = self
        
        ///Set basic VC as Default
        setViewControllers([VC1Object], direction: UIPageViewControllerNavigationDirection.forward, animated: false, completion: nil)
    } 
}

//MARK:- Required Delegates
extension PageViewController
{
    //MARK: Set Previous transition
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?
    {
        let currentIndex = pages.index(of: viewController)!
        let previousIndex = abs((currentIndex - 1) % pages.count)
        if currentIndex == 0
        {
            ///Return VC
            return pages[pages.count-1]
        }
        else
        {
            ///Return VC
            return pages[previousIndex]
        }
    }
    
    //MARK: Set Forward transition
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?
    {
        let currentIndex = pages.index(of: viewController)!
        let nextIndex = abs((currentIndex + 1) % pages.count)
        
        if nextIndex == 0
        {
            ///Return VC
            return pages[0]
        }
        else
        {
            ///Return VC
            return pages[nextIndex]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool)
    {
        if (completed)
        {
            //No need as we had Already managed This action in other Delegate
        }
        else
        {
            ///Update Current Index
            Manager.pageindex = Manager.lastIndex
            
            ///Post notification to hide the draggable Menu
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateLabelValue"), object: nil)
        }
    }
    
    //MARK: Check Transition State
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController])
    {
        ///Update Last Index
        Manager.lastIndex = Manager.pageindex
        
        ///Update Index
        Manager.pageindex = pages.index(of: pendingViewControllers[0])!
        
        ///Post notification to hide the draggable Menu
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateLabelValue"), object: nil)
    }
}
