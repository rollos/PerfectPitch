//
//  Session.swift
//  PerfectPitch2
//
//  Created by Woodrow Melling on 1/25/18.
//  Copyright © 2018 Woodrow Melling. All rights reserved.
//

import Foundation

class PracticeSession {
    let root: String
    let playRoot: Bool  // play a root note before, for interval practice
    let notes: [String]
    var questions: [String]
    
    
    init(availableNotes: [String], sessionLength: Int, playRootNote: Bool, rootNote: String = "C") {
        playRoot = playRootNote
        root = rootNote
        notes = availableNotes
        questions = generateSession(notes: availableNotes, length: sessionLength)
    }
    
    func regenerateQuestions(){
        questions = generateSession(notes: notes, length: questions.count)
    }
    
    
}


//generate a random session of notes from a set of notes
func generateSession(notes:[String], length: Int) -> [String] {
    var questions: [String] = []
    
    for _ in 1...length {
        let randomIndex = Int(arc4random_uniform(UInt32(notes.count)))
        questions.append(notes[randomIndex])
    }
    
    return questions
}
