//
//  CPScheduleManager.swift
//  ClassPlanner
//
//  Created by Justin Wong on 2/23/24.
//

import SwiftUI

// TODO: - 4B. Implement CPScheduleManager

@Observable
class viewModel {
    var yearPlans: [CPYearPlan]
    var themeColor: Color
    var currentYearPlanIndex: Int = 0
    var allClasses: [CPClass]{
        get {
        var classes: [CPClass] = []
        for i in yearPlans {
            for j in i.semesters {
                for x in j.classes {
                    classes.append(x)
                }
            }
        }
        return classes
    }
    }
    
    var sortedYearPlans: [CPYearPlan] {
        yearPlans.sorted(by: {(a, b) -> Bool in return a.year < b.year})
    }
    
    var currentYearString: String {
        String(sortedYearPlans[currentYearPlanIndex].year)
    }
    
    var currentYear: Int {
        sortedYearPlans[currentYearPlanIndex].year
    }
    
    init(yearPlans: [CPYearPlan], themeColor: Color) {
        self.yearPlans = yearPlans
        self.themeColor = themeColor
    }
    
    func yearlineleftbutton() {
        if currentYearPlanIndex - 1 < 0 {
            let newYearPlan = CPYearPlan(year: currentYear - 1, semesters: [
                CPSemester(type: .fall, classes: []),
                CPSemester(type: .spring, classes: [])
            ])
            yearPlans.append(newYearPlan)
        } else {
            currentYearPlanIndex -= 1
        }
    }
    
    func yearlinerightbutton() {
        if currentYearPlanIndex + 1 >= yearPlans.count {
            let newYearPlan = CPYearPlan(year: currentYear + 1, semesters: [
                CPSemester(type: .fall, classes: []),
                CPSemester(type: .spring, classes: [])
            ])
            yearPlans.append(newYearPlan)
        }
        currentYearPlanIndex += 1
    }
}
