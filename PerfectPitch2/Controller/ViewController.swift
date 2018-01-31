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
    @IBOutlet weak var questionCounter: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var checkView: UIImageView!
    
    
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
    
    //var session:PracticeSession
    
    var session = PracticeSession(playInterval: true, questions: [], availableNotes: [], title: "")
   
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        roundButtons()
        
        //enable the active notes for this session
        updateUI()
        
        for note in session.availableNotes {
            resultsDict[note] = ResultsData()
        }
        playNote(note: "C", octave: 3, rootNote: false)
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        playQuestion()
        
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
        if notePressed == session.questions[questionNumber].questionNote {
            resultsDict[session.questions[questionNumber].questionNote]?.playCount += 1 // increase the playcount in our resultsDict
            
            
            // if it was on the first try, increase the score
            if firstTry {
                score += 1
                scoreLabel.text = "Score: \(score)"
                resultsDict[session.questions[questionNumber].questionNote]!.correctCount += 1 // Increase the score for that note
            }
            
            
            fadeCheckMark() //show checkmark, the user got it right
            
            // After a small pause, move to the next question
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                self.nextQuestion()
            }
            
            
        } else {
            firstTry = false
            sender.isEnabled = false //disable the note that was attempted
        }
    }
    
    // Skip/Next button pressed
    @IBAction func skipButton(_ sender: UIButton) {
        nextQuestion()
        
    }
    
    // Setup the next question
    func nextQuestion() {
        questionNumber += 1
        
        // If this is the last question, go to the results screen
        if questionNumber >= session.questions.count {
            performSegue(withIdentifier: "ResultsSegue", sender: self)
            return
        }
        
        
        firstTry = true
        updateUI()
        playQuestion()
    }
    
    // Update the score, counter, progression
    func updateUI() {
        enableAvailableNotes(availableNotes: session.availableNotes)
        questionCounter.text = "\(questionNumber)/\(session.questions.count)"
        scoreLabel.text = "Score: \(score)"
        
    }
    
    // play the notes for the current question
    func playQuestion() {
        session.questions[questionNumber].playQuestion(playNote: playNote)
    }
    
    @IBAction func playAgain(_ sender: UIButton) {
        playQuestion()
    }
    
    // Play a note from an audio file
    func playNote(note:String, octave:Int, rootNote:Bool){
        
        print("Playing: \(note)\(octave)")
        // If it's a root note, signal the note to the user, and wait for 1 second for the next note to play
        if rootNote {
            let button = noteToButton(note: note) //get the button object
            let originalColor = button.backgroundColor
            
            
            // Animate the key press, so user knows what the root is
            UIView.animate(withDuration: 0.75, animations: {
                button.backgroundColor = UIColor.gray //Set the color to gray
            },completion: { _ in
                button.backgroundColor = originalColor //change it back to original color
            })
            
            
        }
        
        let sound = Bundle.main.url(forResource: "\(note)\(String(octave))", withExtension: "wav") // Find the actual file of the sound being played
        do {
            // Play the sound
            player = try AVAudioPlayer(contentsOf: sound!)
            guard let player = player else {return}
            player.prepareToPlay()
            player.play()
            
            
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
        destVC.availableNotes = session.availableNotes
    }
    
    
    // Fade in and out the checkmark if a user got the right answer
    func fadeCheckMark(){
        UIView.animate(withDuration: 0.5, animations: {
            self.checkView.alpha = 1.0 //Fade in
        }, completion: { _ in
            
            UIView.animate(withDuration: 0.5, animations: {
                self.checkView.alpha = 0 //Fade out
            })
        })
    }
    
  
    


}

