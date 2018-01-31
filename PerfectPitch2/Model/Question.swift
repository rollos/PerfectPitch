//
//  Question.swift
//  PerfectPitch2
//
//  Created by Woodrow Melling on 1/30/18.
//  Copyright © 2018 Woodrow Melling. All rights reserved.
//

import Foundation

// Base class for a question
class Question {
    let key: String
    let octave: Int
    let isInterval: Bool
    
    
    init(key:String, octave:Int, isInterval:Bool) {
        self.key = key
        self.octave = octave
        self.isInterval = isInterval
    }
}



// A question that contains an interval
class IntervalQuestion: Question {
    let intervalDistance:Int
    let secondNote: String
    let secondOctave: Int
    
    // Initialize an interval question
    init(key: String, octave:Int, intervalDistance: Int) {
        
        let nextIdx = notes.index(of: key)! + intervalDistance // The distance from the C in the octave of the root, to the secon note
        self.secondNote = notes[(nextIdx) % notes.count]        // Wrap around the octaves to get the next note being played
        
        // If the second note is in the next octave, add one to the octave of the root
        if nextIdx > notes.count{
            self.secondOctave = octave + 1
            
        } else {
            self.secondOctave = octave
        }
        
        super.init(key: key, octave: octave, isInterval: true)
    }
    
    
}

class NoReferenceQuestion: Question {
    init(key: String, octave:Int) {
        super.init(key: key, octave: octave, isInterval: false)
    }
}
