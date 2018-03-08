//
//  VC2.swift
//  PageVC_With_ViewController
//
//  Created by IosDeveloper on 01/02/18.
//  Copyright © 2018 iOSDeveloper. All rights reserved.
//

import UIKit

class VC2: UIViewController
{
    ///TableView Outlet
    @IBOutlet weak var myTableView: UITableView!
    
    ///Static Array
    let staticArray : [String] = ["Kansas","Kentucky","Louisiana","Massachusetts","Maryland", "Maine","Michigan", "Minnesota","Missouri","Mississippi","Montana","North Carolina"," North Dakota", "Nebraska","New Hampshire","New Jersey","New Mexico"]
    
    //MARK: View Did Load
    /**
     Called after the controller's view is loaded into memory
     */
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        myTableView.delegate =  self
        myTableView.dataSource = self
    }
}

//MARK:- TableView Delegates
extension VC2 : UITableViewDataSource,UITableViewDelegate
{
    //MARK: Number of Rows in Section
    /**
     Tells the data source to return the number of rows in a given section of a table view.
     - parameter tableView: The table-view object requesting this information
     - parameter section: An index number identifying a section in tableView.
     - returns: The number of rows in section.
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        ///Return Count
        return staticArray.count
    }
    
    //MARK: Setting cell components
    /**
     Tells the data source for a cell to insert in a particular location of the table view.
     - parameter tableView: The table-view object requesting this information
     - parameter indexPath: An index path locating a row in tableView
     - returns: Data in cell
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        ///Initiate cell
        let cell = self.myTableView.dequeueReusableCell(withIdentifier: "Cell")
        
        ///Set cell label
        cell?.textLabel?.text = staticArray[indexPath.row]
        
        ///return
        return cell!
    }
}

