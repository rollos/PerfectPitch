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
    let questionNote: String // The key we are testing
    let octave: Int // The octave of the key we are testing
    let isInterval: Bool
    
    
    init(questionNote:String, octave:Int, isInterval:Bool) {
        self.questionNote = questionNote
        self.octave = octave
        self.isInterval = isInterval
    }
    
    func playQuestion(playNote:(String) -> ()){
    }
}



// A question that contains an interval
class IntervalQuestion: Question {
    let intervalDistance:Int
    let rootNote: String
    let rootOctave: Int
    
    
    init(key: String, octave:Int, intervalDistance: Int) {
        self.rootNote = key
        self.rootOctave = octave
        self.intervalDistance = intervalDistance
        
        // Find the next note
        let nextIdx = notes.index(of: key)! + intervalDistance // The distance from the C in the octave of the root, to the question note, so we can index into our note list
        let note = notes[(nextIdx) % notes.count]        // Wrap around the octaves to get the next note being played
        
        
        var oct:Int
        // If the second note is in the next octave, add one to the octave of the root
        if nextIdx > notes.count{
             oct = octave + 1
        } else {
            oct = octave
        }
        
        super.init(questionNote: note, octave: oct, isInterval: true)
    }
    
    override func playQuestion(playNote: (String) -> ()) {
        playNote(rootNote)
        sleep(1)
        playNote(questionNote)
    }
}

class NoReferenceQuestion: Question {
    init(key: String, octave:Int) {
        super.init(questionNote: key, octave: octave, isInterval: false)
    }
    
    override func playQuestion(playNote: (String) -> ()) {
        playNote(questionNote)
    }
}
