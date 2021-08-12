//
//  BaseViewModel.swift
//  My-CodeStyle
//
//  Created by MCOMM00008 on 12/08/21.
//

import Foundation
import RealmSwift
import RxSwift

class BaseViewModel {
    typealias Base = BaseViewModel
    
    lazy var realm = try! Realm()
    
    lazy var disposeBag = DisposeBag()
    //
    
    init() {}
    
    static func activeNetworkIndicator(_ bool: Bool) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = bool
    }
    
    func realmAdd(_ objects: [Object]) {
        try! realm.write({
            realm.add(objects, update: .modified)
        })
    }
    
    func realmGet<T: Object>(_ type: T.Type) -> Results<T> {
        return realm.objects(T.self)
    }
    
    
}
