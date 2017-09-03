//
//  ViewController.swift
//  News
//
//  Created by Abhishek Agarwal on 02/09/17.
//  Copyright © 2017 Abhishek. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {
    
    @IBOutlet weak var timerTableView: UITableView!
    var timerStates = [Int]()
    var timerNumber = [Int]()
    var timerCount = 0
    var alertController: UIAlertController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
    }
    
    @IBAction func addTimer(_ sender: AnyObject) {
        timerCount += 1
        timerNumber.append(timerCount)
        timerStates.append(TimerConstants.TimerDuration)
        let indexPath = IndexPath(row: timerStates.count - 1, section: 0)
        timerTableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    func alertUI(withTitle title:String, message:String) {
        if alertController == nil {
            alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "Okay", style: .default) { (_) in
                self.alertController = nil
            }
            alertController!.addAction(action)
            present(alertController!, animated: true, completion: nil)
        }
    }
}
