//
//  ACRequest.swift
//  AYO CLEAN
//
//  Created by Zein Rezky Chandra on 23/05/18.
//  Copyright © 2019 PT. Absolute Connection. All rights reserved.


import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD

class ACRequest: NSObject {

    
    static func POST_SIGNIN(
        email:String,
        password:String,
        successCompletion:@escaping (LoginModel) -> Void,
        failCompletion:@escaping (String) -> Void){
        let parameters:Parameters = [
            "email":email,
            "password":password,
        ]
        print(parameters)
        let headers:HTTPHeaders = ["Content-Type":"application/json"]
        ACAPI.POST(url: "https://acl-hoonian.herokuapp.com/login", parameter: parameters, header: headers, showHUD: true) { (jsonData) in
            let json = JSON(jsonData)
            print("loginjson: \(json)")
            if(json["status"]["status"] == 200) {
                let user = LoginModel()
                user.objectMapping(json: json)
                successCompletion(user)
            } else {
                failCompletion(json["message"].stringValue)
            }
        }
    }
}
    
