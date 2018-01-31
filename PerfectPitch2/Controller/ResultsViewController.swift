//
//  ResultsViewController.swift
//  PerfectPitch2
//
//  Created by Woodrow Melling on 1/29/18.
//  Copyright © 2018 Woodrow Melling. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    
    
    
    var scoreData:String = ""
    var resultDict:[String:ResultsData] = [:]
    var availableNotes:[String] = []
    
    
    @IBOutlet weak var resultsDisplayLabel: UILabel!
    
    @IBOutlet weak var resultsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultsDisplayLabel.text = scoreData
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return availableNotes.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlainCell", for: indexPath)
        
        let note = availableNotes[indexPath.row]
        
        
        cell.textLabel?.text = note
        
        let score = "\(resultDict[note]!.correctCount)/\(resultDict[note]!.playCount)"
        
        cell.detailTextLabel?.text = score
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    
        let indexPath = tableView.indexPathForSelectedRow
        
        let currentCell = tableView.cellForRow(at: indexPath!)! as UITableViewCell
        
        let currentItem = currentCell.textLabel!.text!
        
        
        performSegue(withIdentifier: "IntervalHelpSegue", sender: currentItem)
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
        let destVC : IntervalHelpViewController = segue.destination as! IntervalHelpViewController
        
        destVC.labelData = sender as! String
    }

}
