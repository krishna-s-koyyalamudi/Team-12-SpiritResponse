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
    
    private var responses:[Response] = []
    private var days = ["Sundnay", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    
    /// Private initializer for the class
    private init(){
        let query = PFQuery(className:"ResponsesData")
        query.whereKey("user", equalTo:"new")
        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
            if let error = error {
                // Log details of the failure
                print(error.localizedDescription)
            } else if let objects = objects {
                // The find succeeded.
                print("Successfully retrieved \(objects.count) scores.")
                // Do something with the found objects
                for object in objects {
                    let formatter = DateFormatter()
                    formatter.dateFormat = "MM/dd/yyyy HH:mm:ss +SSSS"
                    formatter.timeZone = .autoupdatingCurrent
                    let startTimeRaw = String(describing: object.object(forKey: "startTime")!)
                    let endTimeRaw = String(describing: object.object(forKey: "endTime")!)
                    let user = "new"
                    let response = Response(startTime: startTimeRaw, endTime: endTimeRaw, user: user)
                    self.responses.append(response)
                }
            }
        }
    }
    
    /// getReaction to get the particular reaction
    /// - Parameter index: index
    func getResponse(at index:Int)->Response? {
        if index >= 0 && index < responses.count {
            return responses[index]
        } else {
            return nil
        }
    }
    
    /// numReactions to show the count of reactions recorded
    func numResponses()->Int{
        return responses.count
    }
    
    /// Subscript that returns an integer
    subscript(index:Int) -> Response? {
        return index >= 0 && index < responses.count ? responses[index] : nil
    }
    
}
