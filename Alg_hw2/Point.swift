//
//  Point.swift
//  Alg_hw2
//
//  Created by sora on 2020/5/22.
//  Copyright © 2020 sora. All rights reserved.
//

import Foundation
class Point {
    var x : Int
    var y : Int
    init(x:Int,y:Int) {
        self.x = x
        self.y = y
    }
    // 向量OA叉積向量OB。大於零表示從OA到OB為逆時針旋轉。
    func cross(o:Point,a:Point ,b:Point) -> Int{
//        print("A:(\(a.x - o.x),\(a.y - o.y)),B:(\(b.x - o.x),\(b.y - o.y)) = \((a.x - o.x) * (b.y - o.y) - (a.y - o.y) * (b.x - o.x))")
        return (a.x - o.x) * (b.y - o.y) - (a.y - o.y) * (b.x - o.x);
    }
    //(a.y - o.y) * (b.x - o.x)
    // 兩點距離的平方
    func compareLen(a:Point,b:Point)->Int{
        return (a.x - b.x) * (a.x - b.x) + (a.y - b.y) * (a.y - b.y)
    }
    func checking(aryTrue:[Point],origin:Point,len:Int) -> [Point] {
        let points = aryTrue
//        for i in 0..<len{
//            print("sorted:(\(Ary[i].x),\(Ary[i].y))")
//        }

        var answerAry = [Point(x: 0, y: 0)]
        var flag = 0
        answerAry[0] = points[0]
        answerAry.append(points[1])
        var pointsLen = points.count - 1
        var count = 2
        for index in 2..<(points.count){
            while(true){
                if(answerAry.count<2){
                    answerAry.append(points[index])
                    count = index + 1
                    break
                }
                let result = cross(o: answerAry[(answerAry.count)-2], a: answerAry[(answerAry.count)-1], b: points[index])
//                print("origin:(\(answerAry[(answerAry.count)-2].x),\(answerAry[(answerAry.count)-2].y)),now:(\(answerAry[(answerAry.count)-1].x),\(answerAry[(answerAry.count)-1].y)),next:(\(points[index].x),\(points[index].y)),cross:\(result)")
                
                if(result>=0){
                    answerAry.append(points[index])
                    if(index  != points.count - 1  ){
//                    print("next:\(points[index+1].x),\(points[index+1].y)")
                    }
//                    count = index + 1
                    break
                }else{
                    answerAry.removeLast()
                    continue
                }
                count = count + 1
            }
        }
        for i in (0 ... answerAry.count-1){
             print("前面的:(\(answerAry[i].x),\(answerAry[i].y))")
        }
        
        
        let re_points = aryTrue.reversed() as [Point]
        let lowerPartNum = answerAry.count
        
        for index in 0..<(re_points.count){
            while(true){
                if(answerAry.count<lowerPartNum){
                    answerAry.append(re_points[index])
                    break
                }
                let result = cross(o: answerAry[(answerAry.count)-2], a: answerAry[(answerAry.count)-1], b: re_points[index])
                print("origin:(\(answerAry[(answerAry.count)-2].x),\(answerAry[(answerAry.count)-2].y)),now:(\(answerAry[(answerAry.count)-1].x),\(answerAry[(answerAry.count)-1].y)),next:(\(re_points[index].x),\(re_points[index].y)),cross:\(result)")
                        
                if(result>=0){
                    answerAry.append(re_points[index])
                    if(index  != points.count - 1  ){
                    print("next:\(points[index+1].x),\(points[index+1].y)")
                    }
                    break
                }else{
                    answerAry.removeLast()
                    continue
                }
            }
        }
        if(answerAry.count != lowerPartNum){
            for i in (lowerPartNum ... answerAry.count-1){
                 print("後面的:(\(answerAry[i].x),\(answerAry[i].y))")
            }
        }
        return answerAry
    }
}
