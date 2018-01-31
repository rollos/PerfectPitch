//
//  IntervalHelpViewController.swift
//  PerfectPitch2
//
//  Created by Woodrow Melling on 1/30/18.
//  Copyright © 2018 Woodrow Melling. All rights reserved.
//

import UIKit

class IntervalHelpViewController: UIViewController {

    @IBOutlet weak var testLabel: UILabel!
    
    var labelData: String = ""
    
   
    @IBAction func stopButton(_ sender: Any) {
        dismissVC(self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testLabel.text = labelData

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func dismissVC(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
