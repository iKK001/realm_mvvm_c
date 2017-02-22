//
//  MVVMCListModel.swift
//  LifeSound
//
//  Created by Stephan Korner on 19.02.17.
//  Copyright © 2017 Stephan Korner. All rights reserved.
//

import Foundation
import RealmSwift

class MVVMCBalancesModel: BalancesModel
{
	
	fileprivate var entries = [DataEntry]()
	let realm = try! Realm()
	
	init() {
		
		// if database is empty then create the initial entries now
		if realm.objects(BalancesDataEntry.self).count == 0 {
			self.createInitialDataEntriesIfRealmEmpty()
		}
	}
	
	fileprivate func createInitialDataEntriesIfRealmEmpty() {
		
		let myBalance1 = BalancesDataEntry.createInitialEntry(idx: 0, category: .Work, type: .analog,
		                                                      title: "Work-Hours", minValue: 0.0, maxValue: 10.0, currValue: 4.0)
		let myBalance2 = BalancesDataEntry.createInitialEntry(idx: 1, category: .Work, type: .analog,
		                                                      title: "Flexible Working Time", minValue: 0.0, maxValue: 10.0, currValue: 4.5)
		let myBalance3 = BalancesDataEntry.createInitialEntry(idx: 2, category: .Work, type: .analog,
		                                                      title: "Mensa", minValue: 0.0, maxValue: 10.0, currValue: 5.5)
		let myBalance4 = BalancesDataEntry.createInitialEntry(idx: 3, category: .Love, type: .analog,
		                                                      title: "Partner", minValue: 0.0, maxValue: 10.0, currValue: 2.5)
		let myBalance5 = BalancesDataEntry.createInitialEntry(idx: 4, category: .Love, type: .analog,
		                                                      title: "Security", minValue: 0.0, maxValue: 10.0, currValue: 3.5)
		let myBalance6 = BalancesDataEntry.createInitialEntry(idx: 5, category: .Travel, type: .analog,
		                                                      title: "Destination choice", minValue: 0.0, maxValue: 10.0, currValue: 7.5)
		let myBalance7 = BalancesDataEntry.createInitialEntry(idx: 6, category: .Travel, type: .analog,
		                                                      title: "Frequency", minValue: 0.0, maxValue: 10.0, currValue: 8.5)
		try! self.realm.write {
			
			// since initial state: delete all existing entries
			self.realm.deleteAll()
			
			// add initial data entries
			self.realm.add(myBalance1)
			self.realm.add(myBalance2)
			self.realm.add(myBalance3)
			self.realm.add(myBalance4)
			self.realm.add(myBalance5)
			self.realm.add(myBalance6)
			self.realm.add(myBalance7)
		}
	}
	
	func getEntries(_ completionHandler: @escaping (_ entries: [Int: [DataEntry]]) -> Void)
	{
		// Simulate Aysnchronous data access
		DispatchQueue.global().async {
			
			let realmThread = try! Realm()
			
			class DataEntryDub: DataEntry {
				
				var idx: Int
				var sectionCategory: SectionCategory
				var sliderType: SliderType
				var sliderTitle: String
				var sliderCurrentValue: Float
				var sliderMinValue: Float
				var sliderMaxValue: Float
				
				init(idx: Int, sectionCategory: SectionCategory, sliderType: SliderType, sliderTitle: String, sliderCurrentValue: Float, sliderMinValue: Float, sliderMaxValue: Float) {
					self.idx = idx
					self.sectionCategory = sectionCategory
					self.sliderType = sliderType
					self.sliderTitle = sliderTitle
					self.sliderCurrentValue = sliderCurrentValue
					self.sliderMinValue = sliderMinValue
					self.sliderMaxValue = sliderMaxValue
				}
			}
		
			var returnArray = [Int: [DataEntry]]()
			for entry in realmThread.objects(BalancesDataEntry.self).sorted(byKeyPath: "idx", ascending: true) {
				
				// create temporary DataEntry-conform object in order to prevent error: "Realm accessed from incorrect thread"
				let e = DataEntryDub(idx: entry.idx,
				                     sectionCategory: entry.sectionCategory,
				                     sliderType: entry.sliderType,
				                     sliderTitle: entry.sliderTitle,
				                     sliderCurrentValue: entry.sliderCurrentValue,
				                     sliderMinValue: entry.sliderMinValue,
				                     sliderMaxValue: entry.sliderMaxValue)
				
				// Write new returnArray Dictionary (having an Int as key and [DataEntry]-array as value)
				// The reason for the relatively complicated data-structure is that with an Int as a key, you will be able to achieve order in your dictionary later on...
				if (returnArray[entry.sectionCategory.rawValue] != nil) {
					if var arr = returnArray[entry.sectionCategory.rawValue] {
						arr.append(e)
						returnArray[entry.sectionCategory.rawValue] = arr
					}
				} else {
					returnArray[entry.sectionCategory.rawValue] = [e]
				}
			}
			completionHandler(returnArray)
		}
	}
	
	func updateEntryAtIndex(_ sectionNr: Int, _ rowNr: Int, _ sliderCurrentValue: Float) {
	
		let updatedEntry = realm.objects(BalancesDataEntry.self).sorted(byKeyPath: "idx").filter("categoryIdx = \(sectionNr)")
		
		try! self.realm.write {
			updatedEntry[rowNr].sliderCurrentValue = sliderCurrentValue
		}
	}
	
	func getNumberOfRowsInSectionFromModel(_ section: Int) -> Int {
		
		let qEntry = realm.objects(BalancesDataEntry.self).filter("categoryIdx = \(section)")
		
		return qEntry.count
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
