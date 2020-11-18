//
//  Response.swift
//  Spirit Response
//
//  Created by Student on 11/16/20.
//

import Foundation

// Response struct
struct Response {
    var startTime:String
    var endTime:String
    var user:String
}

/// Model for response database table
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
    
    /// getResponse to get the particular response
    /// - Parameter index: index
    func getResponse(at index:Int)->Response? {
        if index >= 0 && index < responses.count {
            return responses[index]
        } else {
            return nil
        }
    }
    
    /// numResponses to show the count of responses recorded
    func numResponses()->Int{
        return responses.count
    }
    
    /// Subscript that returns an integer
    subscript(index:Int) -> Response? {
        return index >= 0 && index < responses.count ? responses[index] : nil
    }
    
    /// Clears the log details of responses
    func clearResponse(){
        let responseQuery =  PFQuery(className: "ResponsesData")
        responseQuery.whereKey("user", equalTo:"new")
        responseQuery.findObjectsInBackground {
            (objects: [PFObject]?, error: Error?)-> Void in
            if let error = error {
                // Log details of the failure
                print(error.localizedDescription)
            } else if let objects = objects {
                // The find succeeded.
                print("Successfully retrieved \(objects.count) scores.")
                // Do something with the found objects
                for object in objects {
                    object.deleteEventually()
                }
            }
        }
        self.responses = []
    }
    
    /// Appends the responses to an array of responses
    /// - Parameters:
    /// - startTime : start time of a response
    /// - endTime : end time of a response
    func addResponse(startTime:String, endTime:String) {
        let response = PFObject(className : "ResponsesData")
        response["startTime"] = startTime
        response["endTime"] = endTime
        response["user"] = "new"
        response.saveInBackground {
            (success: Bool, error: Error?) -> Void in
            
            if (success) {
                print("success")
            }
            else{
                print("error")
            }
        }
        self.responses.append(Response(startTime: startTime, endTime: endTime, user: "new"))
    }
    
    /// getResponseTime method to calculate the response time of the user in milliseconds
    func getResponseTime(indes:Int) -> Double {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy HH:mm:ss +SSSS"
        formatter.timeZone = .autoupdatingCurrent
        let response  = responses[indes]
        let startTime = formatter.date(from: response.startTime)
        let endTime = formatter.date(from: response.endTime)
        
        var startIndex = response.startTime.index(response.startTime.startIndex, offsetBy: 21)
        var endIndex = response.startTime.index(response.startTime.endIndex, offsetBy: -1)
        let range = startIndex..<endIndex
        let startMilliseconds = Double(response.startTime[range])!
        
        startIndex = response.endTime.index(response.endTime.startIndex, offsetBy: 21)
        endIndex = response.endTime.index(response.endTime.endIndex, offsetBy: -1)
        
        let endMilliseconds = Double(response.endTime[range])!
        
        var differenceInMilliseconds = endMilliseconds - startMilliseconds
        differenceInMilliseconds = differenceInMilliseconds < 0 ? (1000+differenceInMilliseconds) : differenceInMilliseconds
        
        let seconds = Double(Calendar.current.dateComponents([.second], from: startTime!, to: endTime!).second!)
        
        let totalMilliSeconds = (seconds * 1000) + differenceInMilliseconds
        return totalMilliSeconds
    }
    
    /// getDay method to get the day from calender
    func getDay(index:Int) -> String {
        let formatter = DateFormatter()
        let todayDateTime = Date()
        formatter.dateFormat = "MM/dd/yyyy HH:mm:ss +SSSS"
        formatter.timeZone = .autoupdatingCurrent
        let response  = responses[index]
        let startTime = formatter.date(from: response.startTime)
        let todayTime = formatter.date(from: formatter.string(from: todayDateTime))
        
        let days = Calendar.current.dateComponents([.day], from: startTime!, to: todayTime!).day!
        
        if days < 7{
            let dayNumber = Calendar.current.component(.weekday, from: startTime!)
            return self.days[dayNumber-1]
        }else{
            let formatterTwo = DateFormatter()
            formatterTwo.dateFormat = "MM/dd/yyyy"
            return String(formatterTwo.string(from: startTime!))
        }
    }
}
