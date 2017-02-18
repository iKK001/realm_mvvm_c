//
//  ListViewModel.swift
//  MVVM-C
//
//  Created by Scotty on 21/05/2016.
//  Copyright © 2016 Streambyte Limited. All rights reserved.
//

import Foundation
import RealmSwift

protocol BalancesViewModelViewDelegate: class
{
    func entriesDidChange(viewModel: BalancesViewModel)
}

protocol BalancesViewModelCoordinatorDelegate: class
{
    func balancesViewModelDidSelectData(_ viewModel: BalancesViewModel, data: DataEntry)
}

protocol BalancesViewModel
{
	var model: BalancesModel? { get set }
	var viewDelegate: BalancesViewModelViewDelegate? { get set }
	var coordinatorDelegate: BalancesViewModelCoordinatorDelegate? { get set}
    
	var title: String { get }
	
	var numberOfEntries: Int { get }
	func entryAtIndex(_ index: Int) -> DataEntry?
	func useEntryAtIndex(_ index: Int)
}
