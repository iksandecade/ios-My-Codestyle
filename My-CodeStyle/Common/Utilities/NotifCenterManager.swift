//
//  NotifCenterManager.swift
//  My-CodeStyle
//
//  Created by MCOMM00008 on 12/08/21.
//

import UIKit

public final class NotifCenterManager {
    private static let payloadKey = "NotifCenterManager"
       
       private final class ObserverContainer {
           let name: Notification.Name
           let observer: NSObjectProtocol
           
           init(name: Notification.Name, object: Any?, queue: OperationQueue?, block: @escaping (_ notification: Notification) -> Void) {
               self.name = name
               self.observer = NotificationCenter.default.addObserver(
                   forName: name,
                   object: object,
                   queue: queue,
                   using: block
               )
           }
           
           deinit {
               NotificationCenter.default.removeObserver(observer)
           }
       }
       
       private var pool = [ObserverContainer]()
       
       public init() {}
       
       public static func post(_ name: Notification.Name, from object: Any? = nil, payload: Any? = nil) {
           NotificationCenter.default.post(
               name: name,
               object: object,
               userInfo: payload.map { [NotifCenterManager.payloadKey: $0] }
           )
       }
       
       public func observe(_ name: Notification.Name, from object: Any? = nil, queue: OperationQueue? = OperationQueue.main, block: @escaping (_ notification: Notification) -> Void) {
           addToPool(name, object: object, queue: queue, block: block)
       }
       
       public func observe<T>(_ name: Notification.Name, from object: Any? = nil, queue: OperationQueue? = OperationQueue.main, block: @escaping (_ notification: Notification, _ payload: T) -> Void) {
           addToPool(name, object: object, queue: queue) { [weak self] in
               guard let payload: T = self?.payload(from: $0) else { return }
               block($0, payload)
           }
       }
       
       public func observe<T>(_ name: Notification.Name, from object: Any? = nil, queue: OperationQueue? = OperationQueue.main, block: @escaping (_ payload: T) -> Void) {
           addToPool(name, object: object, queue: queue) { [weak self] in
               guard let payload: T = self?.payload(from: $0) else { return }
               block(payload)
           }
       }
       
       public func dispose(_ name: Notification.Name) {
           removeFromPool(name)
       }
       
       // MARK: private methods
       private func addToPool(_ name: Notification.Name, object: Any?, queue: OperationQueue?, block: @escaping (Notification) -> Void) {
           pool.append(ObserverContainer(name: name, object: object, queue: queue, block: block))
       }
       
       private func removeFromPool(_ name: Notification.Name) {
           pool = pool.filter { $0.name != name }
       }
       
       private func payload<T>(from notification: Notification) -> T? {
           return notification.userInfo?[NotifCenterManager.payloadKey] as? T
       }
       
       deinit {
           pool.removeAll()
       }
}
