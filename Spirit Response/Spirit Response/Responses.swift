//
//  Response.swift
//  Spirit Response
//
//  Created by Student on 11/16/20.
//

import Foundation

// Reaction struct
struct Response {
    var startTime:String
    var endTime:String
    var user:String
}

/// Model for reaction database table
class Responses {
    private static var _shared:Responses!
    
    static var shared:Responses {
        if _shared == nil {
            _shared = Responses()
        }
        return _shared
    }
}
