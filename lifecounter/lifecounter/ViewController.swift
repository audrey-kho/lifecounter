//
//  ViewController.swift
//  lifecounter
//
//  Created by Audrey Kho on 4/19/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var p1: UILabel!
    @IBOutlet weak var p2: UILabel!
    @IBOutlet weak var p3: UILabel!
    @IBOutlet weak var p4: UILabel!
    @IBOutlet weak var loser: UILabel!
    @IBOutlet weak var p1Name: UITextField!
    @IBOutlet weak var p2Name: UITextField!
    @IBOutlet weak var p3Name: UITextField!
    @IBOutlet weak var p4Name: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loser.isHidden = true
        p1Name.placeholder = "Player 1"
        p2Name.placeholder = "Player 2"
        p3Name.placeholder = "Player 3"
        p4Name.placeholder = "Player 4"
    }
    
    func changeVal(target: Int, val: Int) {
        switch target {
        case 1:
            let score = Int(p1.text!)! + val
            p1.text = String(score)
            if score <= 0 {
                loser.isHidden = false
                loser.text = "\(p1Name.text ?? "") loses!"
            }
        case 2:
            let score = Int(p2.text!)! + val
            p2.text = String(score)
            if score <= 0 {
                loser.isHidden = false
                loser.text = "\(p2Name.text ?? "") loses!"
            }
        case 3:
            let score = Int(p3.text!)! + val
            p3.text = String(score)
            if score <= 0 {
                loser.isHidden = false
                loser.text = "\(p3Name.text ?? "") loses!"
            }
        case 4:
            let score = Int(p4.text!)! + val
            p4.text = String(score)
            if score <= 0 {
                loser.isHidden = false
                loser.text = "\(p4Name.text ?? "") loses!"
            }
        default:
            print("error")
        }
    }
    
    @IBAction func p1SubtractFive(_ sender: Any) {
        changeVal(target: 1, val: -5)
    }
    
    @IBAction func p1Subtract(_ sender: Any) {
        changeVal(target: 1, val: -1)
    }
    
    @IBAction func p1Add(_ sender: Any) {
        changeVal(target: 1, val: 1)
    }
    
    @IBAction func p1AddFive(_ sender: Any) {
        changeVal(target: 1, val: 5)
    }
    
    @IBAction func p2SubtractFive(_ sender: Any) {
        changeVal(target: 2, val: -5)
    }
    
    @IBAction func p2Subtract(_ sender: Any) {
        changeVal(target: 2, val: -1)
    }
    
    @IBAction func p2Add(_ sender: Any) {
        changeVal(target: 2, val: 1)
    }
    
    @IBAction func p2AddFive(_ sender: Any) {
        changeVal(target: 2, val: 5)
    }
    
    @IBAction func p3SubtractFive(_ sender: Any) {
        changeVal(target: 3, val: -5)
    }
    
    @IBAction func p3Subtract(_ sender: Any) {
        changeVal(target: 3, val: -1)
    }
    
    @IBAction func p3Add(_ sender: Any) {
        changeVal(target: 3, val: 1)
    }
    
    @IBAction func p3AddFive(_ sender: Any) {
        changeVal(target: 3, val: 5)
    }
    
    @IBAction func p4SubtractFive(_ sender: Any) {
        changeVal(target: 4, val: -5)
    }
    
    @IBAction func p4Subtract(_ sender: Any) {
        changeVal(target: 4, val: -1)
    }
    
    @IBAction func p4Add(_ sender: Any) {
        changeVal(target: 4, val: 1)
    }
    
    @IBAction func p4AddFive(_ sender: Any) {
        changeVal(target: 4, val: 5)
    }
}

