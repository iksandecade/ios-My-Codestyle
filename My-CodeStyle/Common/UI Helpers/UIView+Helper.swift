//
//  UIView+Helper.swift
//  My-CodeStyle
//
//  Created by MCOMM00008 on 12/08/21.
//

import UIKit
import RxGesture
import RxSwift

extension UIView {
    struct properties {
        static var disposeBag = DisposeBag()
    }
    
    var disposeBag: DisposeBag {
        return properties.disposeBag
    }

    /// Tap Handler for UIView
    @objc func addTapHandler(_ handler: @escaping (() -> Void)) {
        self.rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { (_) in
                handler()
            }).disposed(by: disposeBag)
    }
}

extension UIView {
    convenience init(withHeight height: CGFloat) {
        self.init()
        
        self.snp.makeConstraints { (make) in
            make.height.equalTo(height)
        }
    }
    
    func getHeightMinus(views: [UIView]) -> CGFloat {
        let minus = views.map({ $0.frame.height }).reduce(0, {(x, y) in
            x + y
        })
        return self.frame.height - minus
    }
    
    func getHeightMinus(_ min: CGFloat) -> CGFloat {
        return self.frame.height - min
    }
}

extension UIView {
    /* BORDER */
    @IBInspectable var borderColor: UIColor? {
        set {
            layer.borderColor = newValue?.cgColor
        }
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            else {
                return nil
            }
        }
    }
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    /* BORDER RADIUS */
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
            
            if layer.masksToBounds {
                layer.shouldRasterize = true
                layer.rasterizationScale = UIScreen.main.scale
            } else {
                layer.shouldRasterize = false
            }
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable var makeRounded: Bool {
        set {
            layer.cornerRadius = newValue ? self.frame.height / 2 : 0
            layer.masksToBounds = newValue
            
            if layer.masksToBounds {
                layer.shouldRasterize = true
                layer.rasterizationScale = UIScreen.main.scale
            } else {
                layer.shouldRasterize = false
            }
        }
        get {
            return false
        }
    }
}

extension UIView {
    static func nib<T: UIView>(withType type: T.Type, name: String? = nil) -> T {
        let _name = name ?? String(describing: type)
        return Bundle.main.loadNibNamed(_name, owner: self, options: nil)?.first as! T
    }
}
