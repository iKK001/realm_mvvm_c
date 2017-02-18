//
//  ListModel.swift
//  MVVM-C
//
//  Created by Scotty on 21/05/2016.
//  Copyright © 2016 Streambyte Limited. All rights reserved.
//

import Foundation
import RealmSwift

protocol BalancesModel {
	
	func getEntries(_ completionHandler: @escaping (_ entries: [DataEntry]) -> Void)
}
