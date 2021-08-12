//
//  RouteManager.swift
//  My-CodeStyle
//
//  Created by MCOMM00008 on 12/08/21.
//

import UIKit

public final class RouteManager {
    private let viewController: UIViewController
    
    private var modally: Bool = true
    private var fullPresent: Bool = false
    
    private var useBaseNavigation: Bool = false
    
    required init(_ viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func usingBaseNav() -> RouteManager {
        self.useBaseNavigation = true
        return self
    }
    
    func push() -> RouteManager {
        self.modally = false
        return self
    }
    
    func full() -> RouteManager {
        self.fullPresent = true
        return self
    }
    
    func open(_ vc: UIViewController) {
        if modally {
            if useBaseNavigation {
                if vc is BaseController {
                    (vc as! BaseController).isModalDismissed = true
                    let nvc = BaseNavigationController(rootViewController: vc)
                    nvc.setNavigationBarHidden(true, animated: true)
                    viewController.presentFull(viewControllerToPresent: nvc, animated: true, completion: nil)
                }
            } else {
                if fullPresent {
                    viewController.presentFull(viewControllerToPresent: vc, animated: true, completion: nil)
                } else {
                    viewController.present(vc, animated: true, completion: nil)
                }
            }
        } else {
            viewController.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    enum Page {
        case Root
        case Push
        case Full
        case UseBaseNav
    }
    
    func goto(_ page: Page, object: Any? = nil) {
        switch page {
        case .Root:
            self.full().open(RootController())
        case .Push:
            ///usually used to bring up the page from the side and not modally. Using for continue module
            self.push().open(SecondViewController())
        case .Full:
            ///usually used to bring up the page from the bottom and full present. Using for new module
            self.full().open(SecondViewController())
        case .UseBaseNav:
            ///usually used to create new page with new navigation controller
            self.usingBaseNav().open(SecondViewController())
        }
    }
}
