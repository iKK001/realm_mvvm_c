//
//  MVVMCDataItem.swift
//  LifeSound
//
//  Created by Stephan Korner on 19.02.17.
//  Copyright © 2017 Stephan Korner. All rights reserved.
//

import Foundation
import RealmSwift

class BalancesDataEntry: Object, DataEntry {
	
	dynamic var idx: Int = 0
	private dynamic var categoryIdx: Int = SectionCategory.Work.rawValue
	var sectionCategory: SectionCategory {
		get { return SectionCategory(rawValue: self.categoryIdx)! }
		set { self.categoryIdx = newValue.rawValue }
	}
	private dynamic var slider: Int = SliderType.analog.rawValue
	var sliderType: SliderType {
		get { return SliderType(rawValue: self.slider)! }
		set { self.slider = newValue.rawValue }
	}
	dynamic var sliderTitle: String = ""
	dynamic var sliderMinValue: Float = 0.0
	dynamic var sliderMaxValue: Float = 0.0
	dynamic var sliderCurrentValue: Float = 0.0
	
	override static func primaryKey() -> String? {
		return "idx"
	}
}

extension BalancesDataEntry {
	
	static func createInitialEntry(idx: Int, category: SectionCategory, type: SliderType, title: String, minValue: Float, maxValue: Float, currValue: Float) -> BalancesDataEntry {
		let testEntry = BalancesDataEntry()
		testEntry.idx = idx
		testEntry.sectionCategory = category
		testEntry.sliderType = type
		testEntry.sliderTitle = title
		testEntry.sliderMinValue = minValue
		testEntry.sliderMaxValue = maxValue
		testEntry.sliderCurrentValue = currValue
		return testEntry
	}
}
