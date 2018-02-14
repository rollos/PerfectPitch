//
//  OptionsViewController.swift
//  PerfectPitch2
//
//  Created by Woodrow Melling on 2/13/18.
//  Copyright © 2018 Woodrow Melling. All rights reserved.
//

import UIKit

class OptionsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return keyPickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.keyPickerData[row]
    }
    
    var session = PracticeSession(playInterval: true, questions: [], availableNotes: [], title: "")

    let keyPickerData = ["C", "C#/D♭", "D", "D#/E♭", "E", "F", "F#/G♭", "G", "G#/A♭" , "A", "A#/B♭", "B"]
    
    @IBOutlet weak var questionCountLabel: UILabel!
    @IBOutlet weak var stepperOutlet: UIStepper!
    
    @IBOutlet weak var keySelectStack: UIStackView!
    @IBOutlet weak var titleLabel: UILabel!

    
    @IBOutlet weak var keyPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = self.session.title
        
        if !(self.session is KeyIntervalSession) {
            self.keySelectStack.isHidden = true
        }
        updateQuestionCountLabel()
        
        self.keyPicker.delegate = self
        self.keyPicker.dataSource = self
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    @IBAction func stepperChanged(_ sender: Any) {
        updateQuestionCountLabel()
    }
    
    @IBAction func startButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "GameSegue", sender:self)
    }

    
    // Update the question count label to the value held in the stepper.
    // Cast to string, and truncate decimals
    func updateQuestionCountLabel(){
        questionCountLabel.text = String(Int(stepperOutlet.value))
    }
    
    func getKey() -> String {
        
        let key = self.keyPickerData[self.keyPicker.selectedRow(inComponent: 0)]
        
        // Only return the sharp, truncate the slash and flat
        // "A#/Bb" -> "A#"
        if key.count > 1 {
            return String(key.prefix(2))
        }
        
        return key
    }
  
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is GameViewController {
            let destVC: GameViewController = segue.destination as! GameViewController
            
            if session is KeyIntervalSession {
                let ses = session as! KeyIntervalSession
                ses.regenerateQuestions(key: getKey(), length: Int(stepperOutlet.value), availableOctaves: [2])
                self.session = ses
                
            } else {
                session.regenerateQuestions(length: Int(stepperOutlet.value), availableOctaves: [2])
            }
            
            
            destVC.session = session
            
        }
        
    }
    
    

}
