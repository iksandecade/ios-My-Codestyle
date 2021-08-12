//
//  UIViewController+Helper.swift
//  My-CodeStyle
//
//  Created by MCOMM00008 on 12/08/21.
//

import UIKit
import SnapKit

@nonobjc extension UIViewController {
    func add(_ child: UIViewController, to containerView: UIView? = nil) {
        addChild(child)
        if let cv = containerView {
            cv.addSubview(child.view)
            child.view.snp.makeConstraints { (make) in
                make.leading.trailing.top.bottom.equalToSuperview()
            }
        }
        child.didMove(toParent: self)
    }
    
    func remove() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
