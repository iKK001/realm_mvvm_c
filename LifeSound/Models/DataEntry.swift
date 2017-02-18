//
//  DataItem.swift
//  MVVM-C
//
//  Created by Scotty on 21/05/2016.
//  Copyright © 2016 Streambyte Limited. All rights reserved.
//

import Foundation

protocol DataEntry: class {
	
	var idx: Int { get set }
	var category: String { get set }
}
