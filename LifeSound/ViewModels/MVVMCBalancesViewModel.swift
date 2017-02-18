//
//  MVVMCListViewModel.swift
//  MVVM-C
//
//  Created by Scotty on 21/05/2016.
//  Copyright © 2016 Streambyte Limited. All rights reserved.
//

import Foundation
import RealmSwift

class MVVMCBalancesViewModel: BalancesViewModel
{
	weak var viewDelegate: BalancesViewModelViewDelegate?
	weak var coordinatorDelegate: BalancesViewModelCoordinatorDelegate?
	
	fileprivate var entries: [DataEntry]? {
		didSet {
			viewDelegate?.entriesDidChange(viewModel: self)
		}
	}
	
	var model: BalancesModel? {
		didSet {
			entries = nil;
			model?.getEntries({ (myEntries) in
				self.entries = myEntries
			})
		}
	}
	
	var title: String {
		return "My Balances"
	}
	
	var numberOfEntries: Int {
		if let entries = entries {
			return entries.count
		}
		return 0
	}
	
	func entryAtIndex(_ index: Int) -> DataEntry?
	{
		if let entries = entries , entries.count > index {

			return entries[index]
		}
		return nil
	}
	
	func useEntryAtIndex(_ index: Int)
	{
		if let entries = entries, let coordinatorDelegate = coordinatorDelegate  , index < entries.count {
			coordinatorDelegate.balancesViewModelDidSelectData(self, data: entries[index])
		}
	}
}
