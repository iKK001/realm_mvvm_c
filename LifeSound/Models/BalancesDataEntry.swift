//
//  MVVMCDataItem.swift
//  MVVM-C
//
//  Created by Scotty on 21/05/2016.
//  Copyright © 2016 Streambyte Limited. All rights reserved.
//

import Foundation
import RealmSwift

//enum TaskType: Int {
//	case first
//	case second
//}

class BalancesDataEntry: Object, DataEntry {
	
	dynamic var idx: Int = 0
	dynamic var category: String = ""
	
	//	private dynamic var privateType: Int = TaskType.first.rawValue
//	var type: TaskType {
//		get { return TaskType(rawValue: privateType)! }
//		set { privateType = newValue.rawValue }
//	}
	
}

extension BalancesDataEntry {
	
	static func test() -> BalancesDataEntry {
		let testEntry = BalancesDataEntry()
		testEntry.idx = 0
		testEntry.category = "Love"
		return testEntry
	}
}
