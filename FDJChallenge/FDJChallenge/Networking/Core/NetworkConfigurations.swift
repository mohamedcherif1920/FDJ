//
//  NetworkConfigurations.swift
//  FDJProject
//
//  Created by Devinsley on 16/11/2022.
//

import Foundation

public protocol NetworkConfigurable {
    var baseURL: String { get }

}

public struct ApiDataNetworkConfig: NetworkConfigurable {
    public var baseURL: String
    
     public init(baseURL: String) {
        self.baseURL = baseURL
    }
}
