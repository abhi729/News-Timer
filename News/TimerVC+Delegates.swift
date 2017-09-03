//
//  TimerVC+Delegates.swift
//  News
//
//  Created by Abhishek Agarwal on 03/09/17.
//  Copyright © 2017 Abhishek. All rights reserved.
//

import UIKit

extension TimerViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timerStates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "timerCell", for: indexPath) as! TimerTableViewCell
        cell.nameLabel.text = "Player \(timerNumber[indexPath.row])"
        if timerStates[indexPath.row] > 0 && !cell.timerView.countdownTimer.isValid {
            cell.timerView.setTimer(value: timerStates[indexPath.row])
            cell.timerView.startClockTimer()
            cell.timerView.tableCell = cell
            cell.timerView.delegate = self
        }
        return cell
    }
    
}

extension TimerViewController: CountdownViewDelegate {
    
    func countdownReached(forCell cell: TimerTableViewCell?) {
        
        if let cell = cell, let indexPath = timerTableView.indexPath(for: cell) {
            timerStates.remove(at: indexPath.row)
            timerNumber.remove(at: indexPath.row)
            timerTableView.deleteRows(at: [indexPath], with: .automatic)
            alertUI(withTitle: "Oops!", message: "Your time is up!")
        }
    }
    
    func updateCountdownTimer(forCell cell: TimerTableViewCell?, withTimerValue seconds: Int) {
        if let cell = cell, let indexPath = timerTableView.indexPath(for: cell) {
            timerStates[indexPath.row] = seconds
        }
    }
    
}

extension TimerViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if timerStates[indexPath.row] <= 0 {
            return 0
        } else {
            return 60
        }
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = cell as! TimerTableViewCell
        cell.timerView.countdownTimer.invalidate()
    }
    
}
