//
//  Session.swift
//  PerfectPitch2
//
//  Created by Woodrow Melling on 1/25/18.
//  Copyright © 2018 Woodrow Melling. All rights reserved.
//

import Foundation



let notes = ["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"]



// Base practice Session
class PracticeSession {
    let playInterval: Bool  // play a root note before, for interval practice
    let availableNotes: [String]
    var questions: [Question]
    let title: String
    
    
    init(playInterval: Bool, questions: [Question], availableNotes: [String], title:String) {
        self.playInterval = playInterval
        self.questions = questions
        self.availableNotes = availableNotes
        self.title = title
    }
}

// A Session with no intervals, testing perfect pitch with no reference point
class NoReferenceSession: PracticeSession {
    
    init(notes:[String], length: Int, availableOctaves:[Int], title:String) {
        let sessionQuestions = generateSession(notes: notes, length: length, availableOctaves: availableOctaves)
        
        super.init(playInterval: false, questions: sessionQuestions, availableNotes: notes, title: title)
    }
}


// A Session with specified intervals in a single key
class KeyIntervalSession: PracticeSession {
    let key:String
    
    init(key:String, availableIntervals:[Int], availableOctaves:[Int], length: Int, title:String) {
        self.key = key
        
        // Generate questions
        let sessionQuestions = generateSession(key: key, availableIntervals: availableIntervals, availableOctaves: availableOctaves, length: length)
        
        // Find the available notes
        var possibleNotes:[String] = []
    
        let keyIdx = notes.index(of: key)! // get the index of the key
        
        for interval in availableIntervals {
            possibleNotes.append(notes[(keyIdx + interval) % notes.count]) // The available notes are the interval distance away from the key, wrapped around for octaves
        }
        
        super.init(playInterval: true, questions: sessionQuestions, availableNotes: possibleNotes, title:title)
        
    }
    
    

}


// A Session that plays specified intervals, with a random root note
class RandRootIntervalSession: PracticeSession {
    init(availableIntervals:[Int], availableNotes:[String] , availableOctaves:[Int], length:Int, title:String){
        let sessionQuestions = generateSession(availableIntervals: availableIntervals, availableOctaves: availableOctaves, length: length)
        
        super.init(playInterval: true, questions: sessionQuestions, availableNotes: notes, title:title)
    }
    
}


//generate a random session of notes from a set of notes, with no intervals
func generateSession(notes:[String], length: Int, availableOctaves:[Int]) -> [Question] {
    var questions: [Question] = []
    
    for _ in 1...length {
        let randomNoteIDX = Int(arc4random_uniform(UInt32(notes.count))) //Generate a random index that represents the note to be played
        let randomOctaveIDX = Int(arc4random_uniform(UInt32(availableOctaves.count))) //Generate a random index for that notes octave
        
        let question = NoReferenceQuestion(key: notes[randomNoteIDX], octave: availableOctaves[randomOctaveIDX]) // Create a new noReferenceQuestion
        
        
        questions.append(question)
    }
    
    return questions
}


// generate a random session of interval questions from a key, with specified intervals
func generateSession(key:String, availableIntervals:[Int], availableOctaves:[Int], length: Int) -> [Question] {
    var questions: [Question] = []
    
    for _ in 1...length {
        let randomIntervalIDX = Int(arc4random_uniform(UInt32(availableIntervals.count))) //Generate a random index that determines the interval to be played
        let randomOctaveIDX = Int(arc4random_uniform(UInt32(availableOctaves.count))) //Generate a random index for that notes octave
        
        let question = IntervalQuestion(key: key, octave: availableOctaves[randomOctaveIDX], intervalDistance: availableIntervals[randomIntervalIDX]) // Create a new IntervalQuestion
        
        
        questions.append(question)
    }
    
    return questions
}


// generate a random session of interval questions with a random base key
func generateSession(availableIntervals:[Int],  availableOctaves:[Int], length:Int) -> [Question] {
    var questions: [Question] = []
    
    for _ in 1...length {
        let randomRootIDX = Int(arc4random_uniform(UInt32(notes.count))) // Random root key
        let randomIntervalIDX = Int(arc4random_uniform(UInt32(availableIntervals.count))) //Generate a random index that represents the note to be played
        let randomOctaveIDX = Int(arc4random_uniform(UInt32(availableOctaves.count))) //Generate a random index for that notes octave
        
        let question = IntervalQuestion(key: notes[randomRootIDX], octave: availableOctaves[randomOctaveIDX],
                                        intervalDistance: availableIntervals[randomIntervalIDX]) // Create a new IntervalQuestion
        
        questions.append(question)
    }
    
    return questions
}
