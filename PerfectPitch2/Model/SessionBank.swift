//
//  SessionBank.swift
//  PerfectPitch2
//
//  Created by Woodrow Melling on 1/25/18.
//  Copyright © 2018 Woodrow Melling. All rights reserved.
//

import Foundation


let sections = ["Relative Pitch", "Perfect Pitch"]

let sessionTypes = [["Single Major Key", "Any Major Key", "Single Key Chromatic", "Any Chromatic"], ["Reference Key", "No Reference Key"]]

class SessionBank{
    let sessions: [String: PracticeSession]
    
    init(){
        var ses:[String: PracticeSession] = [:]
        
        ses["Single Major Key"] = KeyIntervalSession(key: "C", availableIntervals: [2,4,5,7,9,11], availableOctaves: [2], length: 5, title: "Relative Pitch in a Single Major Key")
        
        ses["Any Major Key"] = RandRootIntervalSession(availableIntervals: [2,4,5,7,9,11], availableNotes: ["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"], availableOctaves: [2], length: 25, title: "Relative Pitch in Any Major Key")
        
        ses["Single Key Chromatic"] = KeyIntervalSession(key: "C", availableIntervals: [1,2,3,4,5,6,7,8,9,10,11], availableOctaves: [2], length: 25, title: "Chromatic Relative Pitch in a Single Key")
        
        ses["Any Key Chromatic"] = RandRootIntervalSession(availableIntervals: [1,2,3,4,5,6,7,8,9,10,11], availableNotes: ["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"], availableOctaves: [2], length: 25, title: "Chromatic Relative Pitch in Any Key")
        
        ses["Reference Key"] = NoReferenceSession(notes: ["C", "D", "E", "F", "G", "A", "B"], length: 25, availableOctaves: [2], title: "Perfect Pitch in a Single Key")
        
        ses["No Reference Key"] = NoReferenceSession(notes: ["C", "D", "E", "F", "G", "A", "B"], length: 25, availableOctaves: [2], title: "Chromatic Perfect Pitch")
        
        
        self.sessions = ses
        
        
    }

    
    
}
