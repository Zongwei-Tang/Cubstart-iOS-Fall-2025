//
//  StickiesViewModel.swift
//  Stickies
//
//  Created by Justin Wong on 3/13/25.
//

import Observation
import SwiftUI

@Observable
class Stickie: Identifiable {
    let id = UUID()
    var zIndex: Double = 0
    
    init(zIndex: Double) {
        self.zIndex = zIndex
    }
}

@Observable
class StickiesViewModel {
    var stickies: [Stickie] = []
    
    func createStickie() {
        let newStickie = Stickie(zIndex: Double(stickies.count))
        stickies.append(newStickie)
    }
    
    func removeStickie(for stickie: Stickie) {
        stickies.removeAll { $0.id == stickie.id }
    }
    
    /// Change a stickie's zIndex when we are holding it. The currently holding stickie should have a zIndex greater than that of all other stickies. The zIndex of other stickies should remain unchanged.
    /// - Parameter stickie: A Stickie
    func changeStickieZIndex(for stickie: Stickie) {
        stickie.zIndex = (stickies.map(\.zIndex).max() ?? 0) + 1
    }
}
