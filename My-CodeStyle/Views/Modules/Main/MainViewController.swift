//
//  MainViewController.swift
//  My-CodeStyle
//
//  Created by MCOMM00008 on 12/08/21.
//

import UIKit

class MainViewController: BaseController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func nextTapped(_ sender: Any) {
        RouteManager(self).goto(.Full)
    }
}
