//
//  RootControleer.swift
//  My-CodeStyle
//
//  Created by MCOMM00008 on 12/08/21.
//

import Foundation
import UIKit

private let RootPageNotif = Notification.Name("RootPageNotif")

enum BasePage {
    case main
    
    var controller: UIViewController {
        switch self {
        case .main:
            let nvc = BaseNavigationController(rootViewController: MainViewController())
            nvc.setNavigationBarHidden(true, animated: false)
            return nvc
        }
    }
}

class RootController: UIViewController {
    private let notifCenter = NotifCenterManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notifCenter.observe(RootPageNotif) { [weak self] (note) in
            guard let self = self, let page = note.object as? BasePage else {
                return
            }
            
            self.children.forEach({ $0.remove() })
            page.controller.view.alpha = 0
            UIView.animate(withDuration: 0.5) {
                self.add(page.controller, to: self.view)
                page.controller.view.alpha = 1
            }
        }
        
        RootController.goto(page: .main)
    }
    
    static func goto(page: BasePage) {
        NotifCenterManager.post(RootPageNotif, from: page)
    }
}
