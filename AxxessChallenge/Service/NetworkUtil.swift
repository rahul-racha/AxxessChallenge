//
//  NetworkUtil.swift
//  AxxessChallenge
//
//  Created by Rahul Rachamalla on 3/31/21.
//

import Foundation
import Alamofire

enum NetworkError: Error {
    case notReachable
}

class NetworkUtil {
    class var isConnectedToInternet: Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}
