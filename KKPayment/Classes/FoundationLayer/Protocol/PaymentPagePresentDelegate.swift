//
//  PaymentPagePresentDelegate.swift
//  KKPayment
//
//  Created by Spock on 2022/9/7.
//

import Foundation
import PromiseKit

public protocol PaymentPagePresentDelegate: AnyObject {
    
    func applicationOpenURL(urlString: String,
                            paymentNotificationName: Notification.Name) -> Promise<URL>
}
