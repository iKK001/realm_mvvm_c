//
//  MVVMCListViewModel.swift
//  LifeSound
//
//  Created by Stephan Korner on 19.02.17.
//  Copyright © 2017 Stephan Korner. All rights reserved.
//

import Foundation
import RealmSwift

class MVVMCBalancesViewModel: BalancesViewModel
{
	weak var viewDelegate: BalancesViewModelViewDelegate?
	weak var coordinatorDelegate: BalancesViewModelCoordinatorDelegate?
	
	fileprivate var entries: [Int: [DataEntry]]? {
		didSet {
			self.viewDelegate?.entriesWereAdded(viewModel: self)
		}
	}
	
	var model: BalancesModel? {
		didSet {
			self.entries = nil;
			self.model?.getEntries({ (myEntries) in
				self.entries = myEntries
			})
		}
	}
	
	var title: String {
		return "My Balances"
	}
	
	var numberOfEntries: Int {
		
		if let entries = self.entries {
			var i: Int = 0
			for (_, valueArr) in entries {
				for _ in valueArr {
					i += 1
				}
			}
			return i
		}
		return 0
	}
	
	var numberOfSectionsFromEntries: Int {
		
		var tempArr: [String] = [String]()
		if let entries = self.entries, entries.count > 0 {
			for entry in entries {
				for e in entry.value {
					tempArr.append(e.sectionCategory.description)
				}
			}
			return Set(tempArr).count
		}
		return 0
	}
	
	var sectionsTitlesFromEntries: [String] {
	
		var tempArr: [String] = [String]()
		if let entries = self.entries, entries.count > 0 {

			for tmp in (Array(Set(Array(entries.keys))).sorted { $0 < $1 }) {

				if (entries[tmp]?[0].sectionCategory.rawValue == tmp) {
					tempArr.append((entries[tmp]?[0].sectionCategory.description)!)
				}

			}
			return tempArr
		}
		return [String]()
	}
	
	func numberOfRowsInSectionFromEntries(_ section: Int) -> Int{
	
		if let model = self.model {
			return  model.getNumberOfRowsInSectionFromModel(section)
		}
		return 0
	}
	
	func entryAtSectionAndRow(_ sectionNr: Int,_ rowNr: Int) -> DataEntry? {
		
		if let entries = self.entries, entries.count > 0 {

			for (key, valueArr) in entries {
				if (sectionNr == key) {
					return valueArr[rowNr]
				}
			}
		}
		return nil
	}

	func updateViewModelAtIndex(_ sectionNr: Int,_ rowNr: Int, _ sliderCurrentValue: Float) {
		
		// udpate view-model's entries
		if let entries = self.entries, entries.count > 0 {

			for (key, valueArr) in entries {
				if (sectionNr == key) {
					valueArr[rowNr].sliderCurrentValue = sliderCurrentValue
				}
			}
		}
		// udpate realm model
		self.model?.updateEntryAtIndex(sectionNr, rowNr, sliderCurrentValue)
	}
	
// selection of cell not used
//	func useEntryAtIndex(_ index: Int) {
//		
//		if let entries = entries, let coordinatorDelegate = coordinatorDelegate  , index < entries.count {
//			coordinatorDelegate.balancesViewModelDidSelectData(self, data: entries[index])
//		}
//	}
}
