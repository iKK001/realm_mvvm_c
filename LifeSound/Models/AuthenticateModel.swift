//
//  AuthenticateViewModel.swift
//  LifeSound
//
//  Created by Stephan Korner on 19.02.17.
//  Copyright © 2017 Stephan Korner. All rights reserved.
//

import Foundation


protocol AuthenticateModel
{
    func login(email: String, password: String, completionHandler: @escaping (_ error: NSError?) ->())
}
