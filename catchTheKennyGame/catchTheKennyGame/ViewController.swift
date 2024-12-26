//
//  ViewController.swift
//  catchTheKennyGame
//
//  Created by Harun Selçuk Çetin on 26.12.2024.
//

import UIKit

class ViewController: UIViewController {
    
    var score = 0;
    var gameTimer = Timer();
    var counter = 0;
    var highScore = 0;
    var kennyArray = [UIImageView]();
    var hideTimer = Timer();


    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var kenny9: UIImageView!
    @IBOutlet weak var kenny8: UIImageView!
    @IBOutlet weak var kenny7: UIImageView!
    @IBOutlet weak var kenny6: UIImageView!
    @IBOutlet weak var kenny5: UIImageView!
    @IBOutlet weak var kenny4: UIImageView!
    @IBOutlet weak var kenny3: UIImageView!
    @IBOutlet weak var kenny2: UIImageView!
    @IBOutlet weak var kenny1: UIImageView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        score=0;
        //high score check
        let storedHighScore = UserDefaults.standard.object(forKey: "highScore");
        
        if storedHighScore == nil{
            highScore = 0;
            highScoreLabel.text="High Score: \(highScore)"
        }
        
        if let newScore = storedHighScore as? Int{
            highScore = newScore
            highScoreLabel.text="High Score: \(highScore)";
        }
        
        scoreLabel.text="Score: \(score)"
        
        kenny1.isUserInteractionEnabled = true
        kenny2.isUserInteractionEnabled = true
        kenny3.isUserInteractionEnabled = true
        kenny4.isUserInteractionEnabled = true
        kenny5.isUserInteractionEnabled = true
        kenny6.isUserInteractionEnabled = true
        kenny7.isUserInteractionEnabled = true
        kenny8.isUserInteractionEnabled = true
        kenny9.isUserInteractionEnabled = true
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore));
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore));
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore));
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore));
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore));
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore));
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore));
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore));
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore));
        
        kenny1.addGestureRecognizer(recognizer1);
        kenny2.addGestureRecognizer(recognizer2);
        kenny3.addGestureRecognizer(recognizer3);
        kenny4.addGestureRecognizer(recognizer4);
        kenny5.addGestureRecognizer(recognizer5);
        kenny6.addGestureRecognizer(recognizer6);
        kenny7.addGestureRecognizer(recognizer7);
        kenny8.addGestureRecognizer(recognizer8);
        kenny9.addGestureRecognizer(recognizer9);
        
        
        
        //timer
        counter = 10;
        timeLabel.text = String(counter);
        
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(decreaseTime), userInfo: nil, repeats: true);
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideKenny), userInfo: nil, repeats: true);
        
        kennyArray=[kenny1,kenny2,kenny3,kenny4,kenny5,kenny6,kenny7,kenny8,kenny9];
        hideKenny();
        
    }
    
    @objc func replay(){
        score = 0;
        counter = 10;
        timeLabel.text = String(counter);
        scoreLabel.text = "Score: \(score)";

        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(decreaseTime), userInfo: nil, repeats: true);
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideKenny), userInfo: nil, repeats: true);
    }
    
    @objc func hideKenny(){
        
        for kenny in kennyArray{
            kenny.isHidden = true
        }
    
        let random = Int(arc4random_uniform(UInt32(kennyArray.count-1)));
        kennyArray[random].isHidden = false;
    }

    @objc func increaseScore(){
        score += 1;
        scoreLabel.text = "Score: \(score)";
    }
    
    @objc func decreaseTime() {
        counter -= 1
        timeLabel.text = String(counter)
        if counter == 0 {
            gameTimer.invalidate();
            hideTimer.invalidate();
            for kenny in kennyArray{
                kenny.isHidden = true
            }
            
            //high score
            if self.score > highScore{
                self.highScore = self.score;
                highScoreLabel.text="Highscore: \(highScore)";
                UserDefaults.standard.set(highScore, forKey: "highScore");
            }
            // Alert
            let alert = UIAlertController(
                title: "Time is over!",
                message: "Do you want to play again?",
                preferredStyle: .alert
            )
            
            // Cancel Action
            let okeyButton = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            
            // Default Action for Replay
            let replayButton = UIAlertAction(title: "Replay", style: .default) { _ in
                self.replay();
            }
            
            alert.addAction(okeyButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
        }
    }

}

