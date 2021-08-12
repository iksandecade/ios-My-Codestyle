//
//  TopBarView.swift
//  My-CodeStyle
//
//  Created by MCOMM00008 on 12/08/21.
//

import UIKit

class TopBarView: UIView {
    @IBOutlet private var backButton: UIButton?
    @IBOutlet private var titleLabel: UILabel?
    
    
    func configure(title: String, hideBackButton: Bool = false,  backPressed: @escaping (() -> Void)) {
        
        titleLabel?.text = title
        
        backButton?.isHidden = hideBackButton
        backButton?.addTapHandler({
            backPressed()
        })
    }

}
