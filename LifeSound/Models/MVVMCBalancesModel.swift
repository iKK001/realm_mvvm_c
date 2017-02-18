//
//  MVVMCListModel.swift
//  MVVM-C
//
//  Created by Scotty on 21/05/2016.
//  Copyright © 2016 Streambyte Limited. All rights reserved.
//

import Foundation
import RealmSwift

class MVVMCBalancesModel: BalancesModel
{
	
	fileprivate var entries = [DataEntry]()
	let realm = try! Realm()
	
	init() {
		self.createDataEntries()
	}
	
	fileprivate func createDataEntries() {
		
		let myBalance = BalancesDataEntry.test()
		
		try! self.realm.write {
			
			self.realm.deleteAll()
			self.realm.add(myBalance)
		}
	}
	
	func getEntries(_ completionHandler: @escaping (_ entries: [DataEntry]) -> Void)
	{
		// Simulate Aysnchronous data access
		DispatchQueue.global().async {
			
			let realmThread = try! Realm()
			
			class DataEntryDub: DataEntry {
				
				var idx: Int
				var category: String
				
				init(idx: Int, category: String) {
					self.idx = idx
					self.category = category
				}
			}
		
			var returnArray = [DataEntry]()
			for entry in realmThread.objects(BalancesDataEntry.self) {
				 returnArray.append(DataEntryDub(idx: entry.idx, category: entry.category))
			}
			completionHandler(returnArray)
		}
	}

}

extension Results {
	
	func toArray<T>(ofType: T.Type) -> [T] {
		var array = [T]()
		for i in 0 ..< count {
			if let result = self[i] as? T {
				array.append(result)
			}
		}
		
		return array
	}
}
