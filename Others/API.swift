//
//  API.swift
//  Review
//
//  Created by MAC OS on 8/26/18.
//  Copyright © 2018 MAC OS. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

let IP = "192.168.43.91"

func getCommentsWithId(_ id: String) -> [Comment]{
    
    return [Comment]()
}

func getPointForComment(_ text: String, completion: @escaping (_ rate: Float) -> Void){
    completion(1.0)
//    return 1.0
}

func getPlacesNearBy(lat: Float, lng: Float, type: String, radius: Float, completion: @escaping (_ places: [Place]?) -> Void) {
//    DispatchQueue.main.async {
    
    let url = "http://\(IP)/search_place?lat=\(lat)&lng=\(lng)&type=\(type)&radius=\(radius)"
    print(url)
    Alamofire.request(url).responseJSON { response in
        switch response.result {
        case .success(let value):
            var results = [Place]()
            let json = JSON(value).arrayValue
            
            for json_place in json {
                let place = getPlaceFromJson(json_place)
                
                results.append(place)
            }
            
            completion(results)
        case .failure(let error):
            print(error)
            completion(nil)
        }
    }
//    }
}

func getPlaceWithId(_ id: String, completion: @escaping (_ place: Place?) -> Void) {
    let url = "http://\(IP)/places/\(id)"
    
    Alamofire.request(url).responseJSON { (response) in
        switch response.result {
            case .success(let value):
                let json = JSON(value)
                let place = getPlaceFromJson(json)
                completion(place)
            case .failure(let error):
                print(error)
                completion(nil)
        }
    }
}

func getPlaceFromJson(_ json_place: JSON) -> Place{
    let place = Place()
    
    place.id = json_place["id"].stringValue
    place.name = json_place["name"].stringValue
    let location = json_place["location"]
    place.lat = location["lat"].doubleValue
    place.lng = location["lng"].doubleValue
    place.type = json_place["type"].stringValue
    place.address = json_place["address"].stringValue
    place.photoUrl = json_place["photoUrl"].stringValue
    place.phoneNumber = json_place["phone"].stringValue
    place.website = json_place["website"].stringValue
    place.rate = json_place["rate"].floatValue
    
    var comments = [Comment]()
    let commentArray = json_place["comments"].arrayValue
    for json_comment in commentArray {
        let comment = Comment()
        comment.id = json_comment["id"].stringValue
        comment.text = json_comment["text"].stringValue
        comment.date = json_comment["date"].stringValue
        comment.username = json_comment["user_name"].stringValue
        
        comments.append(comment)
    }
    
    place.comments = comments
    
    return place
}
















