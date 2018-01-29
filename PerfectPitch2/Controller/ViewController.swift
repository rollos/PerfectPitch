//
//  ViewController.swift
//  PerfectPitch2
//
//  Created by Woodrow Melling on 1/25/18.
//  Copyright © 2018 Woodrow Melling. All rights reserved.
//

import UIKit
import AVFoundation





class ViewController: UIViewController {

    
    //Keyboard Notes
    // White Keys
    @IBOutlet weak var noteC: UIButton!
    @IBOutlet weak var noteD: UIButton!
    @IBOutlet weak var noteE: UIButton!
    @IBOutlet weak var noteF: UIButton!
    @IBOutlet weak var noteG: UIButton!
    @IBOutlet weak var noteA: UIButton!
    @IBOutlet weak var noteB: UIButton!
    
    // Black Keys
    @IBOutlet weak var noteCs: UIButton!
    @IBOutlet weak var noteDs: UIButton!
    @IBOutlet weak var noteFs: UIButton!
    @IBOutlet weak var noteGs: UIButton!
    @IBOutlet weak var noteAs: UIButton!
    
    // Other Buttons
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    
    // Labels
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var questionCounter: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    // Progress Bar
    @IBOutlet weak var progressView: UIView!
    
    
    var resultsDict:[String:ResultsData] = [:]
    

    
    // Audio player
    var player: AVAudioPlayer?
    
    // Notes
    let notes = ["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"]
    let noteTags:[String:Int] = ["C":1, "C#":2, "D":3, "D#":4, "E":5, "F":6, "F#":7, "G":8, "G#":9, "A":10, "A#":11, "B":12]
    
    // Game variables
    let allSessions = SessionBank()
    var questionNumber: Int = 0
    var score: Int = 0
    var firstTry: Bool = true //Only add to the score if the user got it on the first try
    
    let session = PracticeSession(availableNotes: ["C", "D", "E", "F", "G", "A", "B"], sessionLength: 10, playRootNote: true)

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        roundButtons()
        
        //enable the active notes for this session
        updateUI()
        
        playQuestion()
        
        for note in session.notes {
            resultsDict[note] = ResultsData()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Piano key pressed
    @IBAction func keyPressed(_ sender: UIButton) {
        print("\(tagToNote(tag: sender.tag))")
        
        let notePressed = tagToNote(tag: sender.tag)
        
        
        // If the user got the right answer
        if notePressed == session.questions[questionNumber] {
            resultsDict[session.questions[questionNumber]]?.playCount += 1
            
            
            // if it was on the first try, increase the score
            if firstTry {
                score += 1
                scoreLabel.text = "Score: \(score)"
                resultsDict[session.questions[questionNumber]]!.correctCount += 1
            }
            resultLabel.text = "Correct! That note was a \(session.questions[questionNumber])"
            skipButton.setTitle("Next", for: .normal)
            
            
        } else {
            firstTry = false
            sender.isEnabled = false //disable the note that was attempted
        }
    }
    
    // Skip/Next button pressed
    @IBAction func skipButton(_ sender: UIButton) {
        questionNumber += 1
        if questionNumber >= session.questions.count {
            //restartSession()
            performSegue(withIdentifier: "ResultsSegue", sender: self)
            return
        }
        firstTry = true
        skipButton.setTitle("Skip", for: .normal)
        updateUI()
        playQuestion()
        
    }
    
    // Update the score, counter, progression
    func updateUI() {
        enableAvailableNotes(availableNotes: session.notes)
        questionCounter.text = "\(questionNumber)/\(session.questions.count)"
        scoreLabel.text = "Score: \(score)"
        
    }
    
    func restartSession() {
        session.regenerateQuestions()
        firstTry = true
        score = 0
        questionNumber = 0
        updateUI()
    }
    
    
    // play the notes for the current question
    func playQuestion() {
        if session.playRoot {
            playNote(note: session.root)
            sleep(1)
        }
        playNote(note:session.questions[questionNumber])
    
    }
    
    @IBAction func playAgain(_ sender: UIButton) {
        playQuestion()
        
    }
    
    // Play a note from an audio file
    func playNote(note:String){
        
        let sound = Bundle.main.url(forResource: "\(note)2", withExtension: "wav")
        do {
            player = try AVAudioPlayer(contentsOf: sound!)
            guard let player = player else {return}
            player.prepareToPlay()
            player.play()
            print(player.isPlaying)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    
    // Round out the edges of the buttons
    func roundButtons(){
        // White Keys
        noteC.layer.cornerRadius = noteC.frame.width / 2
        noteD.layer.cornerRadius = noteD.frame.width / 2
        noteE.layer.cornerRadius = noteE.frame.width / 2
        noteF.layer.cornerRadius = noteF.frame.width / 2
        noteG.layer.cornerRadius = noteG.frame.width / 2
        noteA.layer.cornerRadius = noteA.frame.width / 2
        noteB.layer.cornerRadius = noteB.frame.width / 2
        
        // Black Keys
        noteCs.layer.cornerRadius = noteCs.frame.width / 2
        noteDs.layer.cornerRadius = noteDs.frame.width / 2
        noteFs.layer.cornerRadius = noteFs.frame.width / 2
        noteGs.layer.cornerRadius = noteGs.frame.width / 2
        noteAs.layer.cornerRadius = noteAs.frame.width / 2
        
        // Other buttons
        playAgainButton.layer.cornerRadius = 10
        skipButton.layer.cornerRadius = 10
    }
    
    func disableAllNotes(){
        noteC.isEnabled = false
        noteCs.isEnabled = false
        noteD.isEnabled = false
        noteDs.isEnabled = false
        noteE.isEnabled = false
        noteF.isEnabled = false
        noteFs.isEnabled = false
        noteG.isEnabled = false
        noteGs.isEnabled = false
        noteA.isEnabled = false
        noteAs.isEnabled = false
        noteB.isEnabled = false
        
    }
    
    func enableAvailableNotes(availableNotes: [String]){
        disableAllNotes()
        for note in availableNotes {
            noteToButton(note: note).isEnabled = true
        }
    }
    
    // Convert a button press to the name of the corresponding note
    func tagToNote(tag: Int) -> String{
        return notes[tag-1]
    }
    
    // Get the button of a note for disabling
    func noteToButton(note: String) -> UIButton{
        return self.view.viewWithTag(noteTags[note]!) as! UIButton
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC : ResultsViewController = segue.destination as! ResultsViewController
        
        destVC.scoreData = "Score: \(score)/\(session.questions.count)"
        destVC.resultDict = resultsDict
        destVC.availableNotes = session.notes
    }
    
  
    


}

