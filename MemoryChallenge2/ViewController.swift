//
//  ViewController.swift
//  MemoryChallenge2
//
//  Created by 許銘仁 on 2018/5/11.
//  Copyright © 2018年 Xumingjen. All rights reserved.
//

import UIKit
import GameplayKit
import AVFoundation

class ViewController: UIViewController {
    
    //音效
    var audioplayer:AVAudioPlayer!
    
    //獲取使用者選擇的圖案
    var userImageNumber : Int!
    
    var imageName : [[String]] = [["1.jpg","2.jpg","3.jpg","4.jpg","5.jpg","6.jpg","7.jpg","8.jpg","9.jpg","10.jpg","11.jpg","12.jpg"], ["13.jpg","14.jpg","15.jpg","16.jpg","17.jpg","18.jpg","19.jpg","20.jpg","21.jpg","22.jpg","23.jpg","24.jpg"],["25.jpg","26.jpg","27.jpg","28.jpg","29.jpg","30.jpg","31.jpg","32.jpg","33.jpg","34.jpg","35.jpg","36.jpg"]]
    
    var guestTime = 2
    var guestImage : [UIImage] = [UIImage]()
    var guestImageNum : [Int] = [Int]()
    var currentScore = 0 //計算分數
    var startGame = true //用來判斷遊戲是否開始
    var comboNumber = 0
    
    var allCard : [UIButton] = [UIButton]()
    
    @IBOutlet weak var card1: UIButton!
    @IBOutlet weak var card2: UIButton!
    @IBOutlet weak var card3: UIButton!
    @IBOutlet weak var card4: UIButton!
    @IBOutlet weak var card5: UIButton!
    @IBOutlet weak var card6: UIButton!
    @IBOutlet weak var card7: UIButton!
    @IBOutlet weak var card8: UIButton!
    @IBOutlet weak var card9: UIButton!
    @IBOutlet weak var card10: UIButton!
    @IBOutlet weak var card11: UIButton!
    @IBOutlet weak var card12: UIButton!
    @IBOutlet weak var card13: UIButton!
    @IBOutlet weak var card14: UIButton!
    @IBOutlet weak var card15: UIButton!
    @IBOutlet weak var card16: UIButton!
    @IBOutlet weak var card17: UIButton!
    @IBOutlet weak var card18: UIButton!
    @IBOutlet weak var card19: UIButton!
    @IBOutlet weak var card20: UIButton!
    @IBOutlet weak var card21: UIButton!
    @IBOutlet weak var card22: UIButton!
    @IBOutlet weak var card23: UIButton!
    @IBOutlet weak var card24: UIButton!
    @IBOutlet weak var Score: UITextField!
    @IBOutlet weak var combo: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        allCard.append(card1)
        allCard.append(card2)
        allCard.append(card3)
        allCard.append(card4)
        allCard.append(card5)
        allCard.append(card6)
        allCard.append(card7)
        allCard.append(card8)
        allCard.append(card9)
        allCard.append(card10)
        allCard.append(card11)
        allCard.append(card12)
        allCard.append(card13)
        allCard.append(card14)
        allCard.append(card15)
        allCard.append(card16)
        allCard.append(card17)
        allCard.append(card18)
        allCard.append(card19)
        allCard.append(card20)
        allCard.append(card21)
        allCard.append(card22)
        allCard.append(card23)
        allCard.append(card24)
        
        Score.text = "0"
        
        // 清除 Button 標題字樣
        for i in 0...allCard.count-1{
            allCard[i].setTitle(nil, for: .normal)
            allCard[i].adjustsImageWhenHighlighted = false // 使觸摸模式下按钮也不會變暗（半透明）
            allCard[i].adjustsImageWhenDisabled = false // 使禁用模式下按钮也不會變暗（半透明）
        }
        
        // 判斷使用者選擇的圖案
        if userImageNumber == 1 {
            checkerBoard(number: 0)
        } else if userImageNumber == 2 {
            checkerBoard(number: 1)
        } else if userImageNumber == 3 {
            checkerBoard(number: 2)
        }
        do {
            let filePath = Bundle.main.path(forResource: "switch1", ofType: "mp3")
            audioplayer = try AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: filePath!) as URL)
        } catch {
            print("error")
        }
        audioplayer.prepareToPlay()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 控制連擊動畫
    func AnimateAlpha(comboNumber : Int) {
        self.combo.alpha = 1
        if comboNumber > 0{
            combo.text = String(comboNumber)+" COMBO"
        }
        UIView.animate(withDuration: 0.7, delay: 0, animations: {
            self.combo.alpha -= 1
            self.combo.transform = CGAffineTransform.identity
                .translatedBy(x: -100, y: 0)
                .rotated(by:CGFloat(Double.pi/4))
                .scaledBy(x: 2, y: 2)
        }, completion: { _ in
            self.combo.transform = CGAffineTransform.identity
        })
        
    }
    
    func checkerBoard(number : Int){ //產生出遊戲題目
        //亂數
        let shuffledDistribution = GKShuffledDistribution(lowestValue: 0, highestValue: imageName[number].count - 1)
        var count = 0;
        for i in 0...5{
            let index1  = shuffledDistribution.nextInt()
            let index2  = shuffledDistribution.nextInt()
            let index3  = shuffledDistribution.nextInt()
            let index4  = shuffledDistribution.nextInt()
            allCard[count].setBackgroundImage(UIImage(named: imageName[number][index1]), for: .normal)
            count += 1
            
            allCard[count].setBackgroundImage(UIImage(named: imageName[number][index2]), for: .normal)
            count += 1
            
            allCard[count].setBackgroundImage(UIImage(named: imageName[number][index3]), for: .normal)
            count += 1
            
            allCard[count].setBackgroundImage(UIImage(named: imageName[number][index4]), for: .normal)
            count += 1
        }
    }
    
    @IBAction func selectCard(_ sender: UIButton) { // 抓取點擊的button是第幾個，並判斷動作
        for i in 0...allCard.count-1{
            if(sender == allCard[i]){
                if(startGame == false){ // 確認是否開始遊戲了
                    if(guestTime != 0){
                        guestTime -= 1;
                        guestImage.append(allCard[i].currentBackgroundImage!)
                        guestImageNum.append(i)
                        allCard[i].setImage(nil, for: .normal)
                        // 避免點擊到同樣button，鎖起來
                        allCard[i].isEnabled = false
                        audioplayer.play()
                        print(i)
                    }else if(guestTime == 0){
                        guestTime = 2
                        if(guestImage[0].isEqual(guestImage[1])){ // 答對了
                            allCard[guestImageNum[0]].isHidden = true
                            allCard[guestImageNum[1]].isHidden = true
                            guestImage.removeAll()
                            guestImageNum.removeAll()
                            currentScore += 10
                            comboNumber += 1
                            AnimateAlpha(comboNumber: comboNumber)
                            Score.text = String(currentScore)
                        }else{
                            allCard[guestImageNum[0]].setImage(UIImage(named: "問號.jpg")?.withRenderingMode(.alwaysOriginal), for: .normal)
                            allCard[guestImageNum[1]].setImage(UIImage(named: "問號.jpg")?.withRenderingMode(.alwaysOriginal), for: .normal)
                            allCard[guestImageNum[0]].isEnabled = true
                            allCard[guestImageNum[1]].isEnabled = true
                            guestImage.removeAll()
                            guestImageNum.removeAll()
                            currentScore -= 10
                            if currentScore < 0 { // 不讓分數低於零
                                currentScore = 0
                                Score.text = "0"
                            } else {
                                Score.text = String(currentScore)
                            }
                            comboNumber = 0
                            combo.text = ""
                        }
                        guestTime -= 1;
                        guestImage.append(allCard[i].currentBackgroundImage!)
                        guestImageNum.append(i)
                        allCard[i].setImage(nil, for: .normal)
                        allCard[i].isEnabled = false
                        audioplayer.play()
                    }
                }
            }
        }
    }
    

    @IBAction func reStartGame(_ sender: Any) {
        checkerBoard(number: userImageNumber-1)
        for i in 0...allCard.count-1{
            allCard[i].isHidden = false
        }
        for i in 0...allCard.count-1{
            allCard[i].setImage(nil, for: .normal)
        }
        for i in 0...allCard.count-1{
            allCard[i].isEnabled = true
        }
        guestImage.removeAll()
        guestImageNum.removeAll()
        guestTime = 2
        Score.text = "0"
        currentScore = 0
        startGame = true
    }
    
    @IBAction func startGame(_ sender: Any) {
        if(startGame){
            for i in 0...allCard.count-1{
                allCard[i].setImage(UIImage(named: "問號.jpg")?.withRenderingMode(.alwaysOriginal), for: .normal)
            }
            Score.text = "0"
            currentScore = 0
            startGame = false
        }else{
            print("game start can not start again")
        }
    }
    
    
}

