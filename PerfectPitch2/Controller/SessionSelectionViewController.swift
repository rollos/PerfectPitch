//
//  SessionSelectionViewController.swift
//  PerfectPitch2
//
//  Created by Woodrow Melling on 1/31/18.
//  Copyright © 2018 Woodrow Melling. All rights reserved.
//

import UIKit

class SessionSelectionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let sessionBank = SessionBank()
    
    @IBOutlet weak var sessionsTableView: UITableView!
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sessionTypes[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for:indexPath) as UITableViewCell
        
        cell.textLabel?.text = sessionTypes[indexPath.section][indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        performSegue(withIdentifier: "GameSegue", sender: self)
        
        
        
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.sessionsTableView.dataSource = self
        self.sessionsTableView.delegate = self
        
        
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        let indexPath = self.sessionsTableView.indexPathForSelectedRow
        let currentCell = self.sessionsTableView.cellForRow(at: indexPath!)! as UITableViewCell
        
        let currentItem = currentCell.textLabel!.text!
        
        let destVC : ViewController = segue.destination as! ViewController
        
        destVC.session = self.sessionBank.sessions[currentItem]!
        
    }

}
