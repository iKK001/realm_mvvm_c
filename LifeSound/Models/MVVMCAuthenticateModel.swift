//
//  MVVMCAuthenticateModel.swift
//  LifeSound
//
//  Created by Stephan Korner on 19.02.17.
//  Copyright © 2017 Stephan Korner. All rights reserved.
//

import Foundation

class MVVMCAuthenticateModel: AuthenticateModel
{
    func login(email: String, password: String, completionHandler: @escaping (_ error: NSError?) ->())
    {
        
        // Simulate Aysnchronous data access
        DispatchQueue.global().async {
            var error: NSError? = nil
            if email != "h@h.com" || password != "hhhhhh" {
                error = NSError(domain: "MVVM-C",
                                code: 1,
                                userInfo: [NSLocalizedDescriptionKey: "Invalid Email or Password"])
            }
            completionHandler(error)
        }
    }
}
