//
//  SessionBank.swift
//  PerfectPitch2
//
//  Created by Woodrow Melling on 1/25/18.
//  Copyright © 2018 Woodrow Melling. All rights reserved.
//

import Foundation


class SessionBank{
    var sessions = [String:PracticeSession]()
    
    
    init() {
        sessions["C Major Intervals"] = PracticeSession(availableNotes: ["C", "D", "E", "F", "G", "A", "B"], sessionLength: 10, playRootNote: true)
        sessions["C Major Perfect"] = PracticeSession(availableNotes: ["C", "D", "E", "F", "G", "A", "B"], sessionLength: 10, playRootNote: false)
        sessions["A Minor Intervals"] = PracticeSession(availableNotes: ["C", "D", "E", "F", "G", "A", "B"], sessionLength: 10, playRootNote: true, rootNote: "A")
        
        sessions["Chromatic Intervals"] = PracticeSession(availableNotes: ["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"], sessionLength: 10, playRootNote: true)
        sessions["Chromatic Perfect"] = PracticeSession(availableNotes: ["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"], sessionLength: 10, playRootNote: false)
        
    }
}
