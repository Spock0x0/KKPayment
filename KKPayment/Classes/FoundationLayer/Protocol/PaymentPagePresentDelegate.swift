//
//  PaymentPagePresentDelegate.swift
//  KKPayment
//
//  Created by Spock on 2022/9/7.
//

import Foundation
import PromiseKit

public protocol PaymentPagePresentDelegate {
    func presentBySafari(url: URL,
                         paymentNotificationName: Notification.Name,
                         safariViewDidFinish: (() -> Void)?) -> Promise<URL>
    
    func presentByWKWebView(url: URL,
                            postData: [String: Any]?,
                            paymentNotificationName: Notification.Name,
                            webViewDidFinish: (() -> Void)?) -> Promise<URL>
    
    func applicationOpenURL(urlString: String,
                            paymentNotificationName: Notification.Name) -> Promise<URL>
}
