//
//  DetailViewController.swift
//  CollectionView
//
//  Created by David Cate on 9/15/18.
//  Copyright © 2018 David Cate. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var selection: String! // Property to assign to info coming in from ControlView
    @IBOutlet private weak var detailsLabel: UILabel! // Outlet to handle the label
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Set Details label now with selection coming back from View Controller
        
        detailsLabel.text = selection
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
