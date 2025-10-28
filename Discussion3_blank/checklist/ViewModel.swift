//
//  ViewModel.swift
//  checklist
//
//  Created by Citrus Furina on 10/6/25.
//
import Foundation
import Observation

@Observable
class ViewModel {
    var description: String = ""
    var doing: [String] = []
    var completed: [String] = []
    
    init (){}
    
    func add() {
        doing.append(description)
        description = ""
    }
    
    func swapInPro(task: String) {
        completed.removeAll(where:{s1 in s1 == task})
        doing.append(task)
    }
    
    func swapToC(task: String) {
        doing.removeAll(where: {(s1: String) -> Bool in return s1 == task})
        completed.append(task)
    }
}
