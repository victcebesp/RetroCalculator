//
//  ViewController.swift
//  RestroCalculator
//
//  Created by Victor Ceballos on 13/1/17.
//  Copyright © 2017 Victor Ceballos. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var resultLbl: UILabel!
    var btnSound : AVAudioPlayer!
    var runningNumber = ""
    var currentOperation = Operation.Empty
    var leftValue = ""
    var rightValue = ""
    var result = ""
    
    enum Operation: String{
        case Divide = "/"
        case Multiply = "*"
        case Add = "+"
        case Subtract = "-"
        case Empty = "Empty"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
        
        do{
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
                btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
    }
    
    @IBAction func numberIsPressed(sender: UIButton){
        playSound()
        runningNumber += "\(sender.tag)"
        resultLbl.text = runningNumber
    }
    
    @IBAction func dividePressed(sender: AnyObject){
        processOperation(operation: .Divide)
    }
    
    @IBAction func multiplyPressed(sender: AnyObject){
        processOperation(operation: .Multiply)
    }
    
    @IBAction func addPressed(sender: AnyObject){
        processOperation(operation: .Add)
    }
    
    @IBAction func subtractPressed(sender: AnyObject){
        processOperation(operation: .Subtract)
    }
    
    @IBAction func equalPressed(){
        processOperation(operation: currentOperation)
    }
    
    func playSound(){
        if btnSound.isPlaying {
            btnSound.stop()
        }
        btnSound.play()
    }
    
    func processOperation(operation: Operation){
        playSound()
        if currentOperation != Operation.Empty{
            if runningNumber != ""{
                rightValue = runningNumber
                runningNumber = ""
                
                if currentOperation == .Divide{
                    result = "\(Double(leftValue)! / Double(rightValue)!)"
                }else if currentOperation == .Multiply{
                    result = "\(Double(leftValue)! * Double(rightValue)!)"
                }else if currentOperation == .Add{
                    result = "\(Double(leftValue)! + Double(rightValue)!)"
                }else if currentOperation == .Subtract{
                    result = "\(Double(leftValue)! - Double(rightValue)!)"
                }
                leftValue = result
                resultLbl.text = result
            }
            currentOperation = operation
        } else {
            leftValue = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
    }

}

