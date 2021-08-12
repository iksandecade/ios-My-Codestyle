//
//  BaseController.swift
//  My-CodeStyle
//
//  Created by MCOMM00008 on 12/08/21.
//

import UIKit
import RxSwift

class BaseController: UIViewController {
    @IBOutlet var container: UIStackView?
    
    @IBInspectable var containerBackground: UIColor? {
        didSet {
            containerView.backgroundColor = containerBackground
        }
    }
    
    let baseViewModel = BaseViewModel()
    
    lazy internal var containerView = UIView()
    lazy var topBarView: TopBarView = UIView.nib(withType: TopBarView.self)
    
    lazy var disposeBag = DisposeBag()
    lazy var notifCenter = NotifCenterManager()
    
    var isModalDismissed: Bool = false
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @discardableResult
    func dismissModally() -> BaseController {
        self.isModalDismissed = true
        return self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let container = container {
            view.backgroundColor = containerBackground ?? .white
            
            view.addSubview(containerView)
            containerView.snp.makeConstraints { make in
                make.leading.trailing.equalTo(view)
                make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            }
            
            container.removeFromSuperview()
            containerView.addSubview(container)
            container.snp.makeConstraints { make in
                make.leading.trailing.top.bottom.equalToSuperview()
            }
        }
    }
    
    func setupTopBar(hideBackButton: Bool = false, title: String) {
        topBarView.configure(title: title, hideBackButton: hideBackButton) {
            self.backPressed()
        }
    
        
        containerView.addSubview(topBarView)
        topBarView.snp.makeConstraints { make in
            make.height.equalTo(66)
            make.top.leading.trailing.equalToSuperview()
        }
        
        let spacer = UIView()
        spacer.backgroundColor = .clear
        container?.insertArrangedSubview(spacer, at: 0)
        spacer.snp.makeConstraints({ $0.height.equalTo(66) })
    }
    
    func backPressed() {
        if isModalDismissed {
            dismiss(animated: true, completion: nil)
        } else {
            if let nc = navigationController {
                nc.popViewController(animated: true)
            } else {
                dismiss(animated: true, completion: nil)
            }
        }
    }
}
