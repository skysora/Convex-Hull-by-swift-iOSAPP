//
//  ViewController.swift
//  Alg_hw2
//
//  Created by sora on 2020/5/22.
//  Copyright © 2020 sora. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate{
    var buttonAry = [UIButton()]
    var positionAry = [Point]()
    let path = UIBezierPath()
    let shapeLayer = CAShapeLayer()
    var answerLen = 0
    var originPoint = Point(x:0,y:0)
    var answer = [Point]()
    var accPosition = [Int]()
    var base = 0.0
    @IBOutlet weak var backGround: UIView!
    @IBOutlet weak var count: UITextField!
    @IBOutlet weak var pointSize: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonAry.popLast()
        count.delegate = self
        pointSize.delegate = self
        accPosition.popLast()
        // Do any additional setup after loading the view.
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
          textField.resignFirstResponder()
          return true
    }
    @IBAction func clearBtn(_ sender: Any) {
        for view in backGround.subviews {
            view.removeFromSuperview()
        }
        buttonAry = []
        positionAry = []
        answer = []
        answerLen = 0
        accPosition = []
        self.backGround.layer.sublayers?.removeAll()
    }
    func containsDuplicate(nums: [Point],target:Point) -> Bool {
        for point in nums{
            if(point.x == target.x && point.y == target.y){
                return false
            }
        }
        return true
    }
    @IBAction func clickBtn(_ sender: UIButton) {
        let  countNumber = Int(count.text!)!
        let pointSizeNumber = Double(pointSize.text!)!
        let  count = 10
        //產生random
        for i in 0..<countNumber{
            let btn = UIButton()
            btn.backgroundColor = .red
            var x = 0
            var y = 0
            repeat{
                x = Int.random(in: 0...count)
                y = Int.random(in: 0...count)
            }while(!containsDuplicate(nums:positionAry,target:Point(x: x, y: y)))
            positionAry.append(Point(x:x,y:y))
            base = Double(backGround.frame.width) / Double(count)
            btn.frame = CGRect(x: Double(base)*Double(x), y: Double(backGround.frame.width) - Double(base)*Double(y), width: pointSizeNumber, height: pointSizeNumber)
            btn.layer.cornerRadius = 5
            buttonAry.append(btn)
            backGround.addSubview(btn)
        }
        
        //排序
        for j in 0..<(positionAry.count-1){
            for k in (j...(positionAry.count-2)).reversed(){
                if (positionAry[k].x > positionAry[k+1].x){
                    var temp : Point
                    temp = positionAry[k]
                    positionAry[k] = positionAry[k+1]
                    positionAry[k+1] = temp
                    var tempBtn : UIButton
                    tempBtn = buttonAry[k]
                    buttonAry[k] = buttonAry[k+1]
                    buttonAry[k+1] = tempBtn
                }
            }
        }
        for j in 0..<(positionAry.count-1){
            for k in (j...(positionAry.count-2)).reversed(){
                if (positionAry[k].x == positionAry[k+1].x && positionAry[k].y > positionAry[k+1].y){
                    var temp : Point
                    temp = positionAry[k]
                    positionAry[k] = positionAry[k+1]
                    positionAry[k+1] = temp
                    var tempBtn : UIButton
                    tempBtn = buttonAry[k]
                    buttonAry[k] = buttonAry[k+1]
                    buttonAry[k+1] = tempBtn
                }
            }
        }
//        for i in positionAry{
//            print("\(i.x),\(i.y)")
//        }
//        送答案去檢查
        answer = originPoint.checking(aryTrue:positionAry, origin: positionAry[0], len: countNumber )
//        answer.append(answer[0])
        for i in answer{
            print("\(i.x),\(i.y)")
        }
        print("==================")
        for i in answer{
            for j in 0...(positionAry.count - 1){
                if(i.x == positionAry[j].x && i.y == positionAry[j].y){
                    accPosition.append(j)
                }
            }
        }
//        for i in accPosition{
//            print(i)
//        }
        let path = UIBezierPath()
        path.move(to: CGPoint(x: buttonAry[accPosition[0]].frame.origin.x, y: buttonAry[accPosition[0]].frame.origin.y))
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.lineWidth = 3
        shapeLayer.strokeColor = UIColor(red: 65/255, green: 65/255, blue: 65/255, alpha: 1).cgColor
                
        backGround.layer.addSublayer(shapeLayer)
        print("============")
        for i in 0..<accPosition.count{
            if(i != 0){
                path.addLine(to: CGPoint(x: buttonAry[accPosition[i]].frame.origin.x, y: buttonAry[accPosition[i]].frame.origin.y))
                let shapeLayer = CAShapeLayer()
                shapeLayer.path = path.cgPath
                shapeLayer.lineWidth = 3
                shapeLayer.strokeColor = UIColor(red: 65/255, green: 65/255, blue: 65/255, alpha: 1).cgColor
                shapeLayer.fillColor = UIColor(red: 65/255, green: 65/255, blue: 65/255, alpha: 0).cgColor
                backGround.layer.addSublayer(shapeLayer)
            }
//            print("\(answer[i].x),\(Double(answer[i].y))")
            buttonAry[accPosition[i]].backgroundColor = .black
        }
    }
}


