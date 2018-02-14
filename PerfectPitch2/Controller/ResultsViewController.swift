//
//  ResultsViewController.swift
//  PerfectPitch2
//
//  Created by Woodrow Melling on 1/29/18.
//  Copyright © 2018 Woodrow Melling. All rights reserved.
//

import UIKit

extension Dictionary where Value: Equatable {
    func key(forValue value: Value) -> Key? {
        return first { $0.1 == value }?.0
    }
}

class ResultsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    
    
    @IBAction func mainMenuButton(_ sender: UIButton) {
        performSegue(withIdentifier: "MainMenuSegue", sender: self)
    }
    
    
    var scoreData:String = ""
    var resultDict:[String:ResultsData] = [:]
    var labelList:[String] = []
    var isInterval = false
    
    let intervals:[String:String] = ["1":"Minor Second", "2":"Major Second", "3":"Minor Third", "4":"Major Third", "5":"Perfect Fourth", "6":"Tritone",  "7": "Perfect Fifth", "8":"Minor Sixth", "9":"Major Sixth", "10":"Minor Seventh", "11": "Major Seventh"]
    
    let reverseIntervals:[String:String] = ["Minor Second":"1", "Major Second":"2", "Minor Third":"3", "Major Third":"4", "Perfect Fourth":"5", "Tritone":"6", "Perfect Fifth":"7", "Minor Sixth":"8", "Major Sixth":"9", "Minor Seventh":"10", "Major Seventh":"11"]
    
    
    @IBOutlet weak var resultsDisplayLabel: UILabel!
    
    @IBOutlet weak var resultsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultsDisplayLabel.text = scoreData
        


        for key in resultDict.keys {
            labelList.append(key)
        }
    
        labelList.sort()
        
        
        if isInterval {
            var holdList:[String] = []
            for interval in labelList {
                holdList.append(intervals[interval]!)
            }
            labelList = holdList
        }
        
        
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return labelList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlainCell", for: indexPath)
        
        let label = labelList[indexPath.row]
        var score = ""
        cell.textLabel?.text = label
        if isInterval {

            score = "\(resultDict[reverseIntervals[label]!]!.correctCount)/\(resultDict[reverseIntervals[label]!]!.playCount)"
        } else {

            score = "\(resultDict[label]!.correctCount)/\(resultDict[label]!.playCount)"
        }
        
        
        
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
        
        if segue.destination is IntervalHelpViewController {
            let destVC : IntervalHelpViewController = segue.destination as! IntervalHelpViewController
        
            destVC.labelData = sender as! String
        }
    }

}
