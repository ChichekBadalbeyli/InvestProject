//
//  NetworkBase.swift
//  InvestProject
//
//  Created by Chichek on 25.02.25.
//

import Foundation
import Alamofire

class BaseManager  {
    
    static let baseURL = "https://valyuta.com"


    static func getUrl(with endpoint: String) -> String {
        return "\(baseURL)\(endpoint)"
    }

}
