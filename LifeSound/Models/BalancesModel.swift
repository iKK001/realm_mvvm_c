//
//  ListModel.swift
//  LifeSound
//
//  Created by Stephan Korner on 19.02.17.
//  Copyright © 2017 Stephan Korner. All rights reserved.
//

import Foundation
import RealmSwift

protocol BalancesModel {
	
	func getEntries(_ completionHandler: @escaping (_ entries: [Int: [DataEntry]]) -> Void)
	func updateEntryAtIndex(_ sectionNr: Int, _ rowNr: Int, _ sliderCurrentValue: Float)
	func getNumberOfRowsInSectionFromModel(_ categoryIdx: Int) -> Int
}
