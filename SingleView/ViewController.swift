//
//  ViewController.swift
//  SingleView
//
//  Created by 西本 至秀 on 2016/09/04.
//  Copyright © 2016年 西本 至秀. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {
   

    
    @IBOutlet weak var input1: UITextField!
    
    @IBOutlet weak var input2: UITextField!
    
    @IBOutlet weak var input3: UITextField!
    
    @IBOutlet weak var input4: UITextField!

    @IBOutlet weak var check: UIButton!
    
    @IBOutlet weak var result: UILabel!

    //チェックボタンを押した時
    @IBAction func check(sender: AnyObject) {
        let num1:Int! = Int(input1.text!)
        let num2:Int! = Int(input2.text!)

        let num3:Int! = Int(input3.text!)
        let num4:Int! = Int(input4.text!)
        var inp: [Int] = []
        inp.append(num1!)
        inp.append(num2!)
        inp.append(num3!)
        inp.append(num4!)
        var subsets: [[Int]]
        var out_array: [Int] = []
        var out_2d: [[Int]] = []
        var rst: String
        rst = ""
        subsets = create_subset(&inp, out_array: &out_array, out_2d: &out_2d)!
        for subset in subsets {
            rst = calc_tree(subset)
            if rst != "" {
                break
            }
        }
        if rst == "" {
            result.text = "×"
        } else {
            result.text = "○¥n"+rst
        }
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a, nib.
        let screenwidth = self.view.bounds.width
        let screenheight = self.view.bounds.height
        
        let image = UIImage(named:"carnumber.jpg")
        let imageView = UIImageView()
        imageView.image = image
        let width  = image!.size.width
        let height = image!.size.height
        imageView.frame = CGRectMake(0,0,screenwidth/2,height * screenwidth / (2*width) )
        imageView.center = CGPoint(x: screenwidth/2,y: (screenheight/2)-70)
        self.view.addSubview(imageView)
        result.text = String(image!.size.width/4)
        
        view.removeConstraints(view.constraints)
        view.addConstraints([
            NSLayoutConstraint(
                item: input1,
                attribute: .Top,
                relatedBy: .Equal,
                toItem: imageView,
                attribute: .Top,
                multiplier: 1,
                constant: imageView.frame.size.height/2
            ),

            NSLayoutConstraint(
                item: input1,
                attribute: .Left,
                relatedBy: .Equal,
                toItem: imageView,
                attribute: .Left,
                multiplier: 1,
                constant: 0//-(imageView.frame.size.width)
            ),

            
            NSLayoutConstraint(
                item: input1,
                attribute: .Width,
                relatedBy: .Equal,
                toItem: nil,
                attribute: .Width,
                multiplier: 1,
                constant: imageView.frame.size.width/4
            ),
            
            NSLayoutConstraint(
                item: input2,
                attribute: .Top,
                relatedBy: .Equal,
                toItem: imageView,
                attribute: .Top,
                multiplier: 1,
                constant: imageView.frame.size.height/2
            ),
            
            NSLayoutConstraint(
                item: input2,
                attribute: .Left,
                relatedBy: .Equal,
                toItem: imageView,
                attribute: .Left,
                multiplier: 1,
                constant: imageView.frame.size.width/4
            ),
            
            
            NSLayoutConstraint(
                item: input2,
                attribute: .Width,
                relatedBy: .Equal,
                toItem: nil,
                attribute: .Width,
                multiplier: 1,
                constant: imageView.frame.size.width/4
            ),
            
            NSLayoutConstraint(
                item: input3,
                attribute: .Top,
                relatedBy: .Equal,
                toItem: imageView,
                attribute: .Top,
                multiplier: 1,
                constant: imageView.frame.size.height/2
            ),
            
            NSLayoutConstraint(
                item: input3,
                attribute: .Left,
                relatedBy: .Equal,
                toItem: imageView,
                attribute: .Left,
                multiplier: 1,
                constant: 2*imageView.frame.size.width/4
            ),
            
            
            NSLayoutConstraint(
                item: input3,
                attribute: .Width,
                relatedBy: .Equal,
                toItem: nil,
                attribute: .Width,
                multiplier: 1,
                constant: imageView.frame.size.width/4
            ),
            
            NSLayoutConstraint(
                item: input4,
                attribute: .Top,
                relatedBy: .Equal,
                toItem: imageView,
                attribute: .Top,
                multiplier: 1,
                constant: imageView.frame.size.height/2
            ),
            
            NSLayoutConstraint(
                item: input4,
                attribute: .Left,
                relatedBy: .Equal,
                toItem: imageView,
                attribute: .Left,
                multiplier: 1,
                constant: 3*imageView.frame.size.width/4
            ),
            
            NSLayoutConstraint(
                item: input4,
                attribute: .Width,
                relatedBy: .Equal,
                toItem: nil,
                attribute: .Width,
                multiplier: 1,
                constant: imageView.frame.size.width/4
            ),
            
            NSLayoutConstraint(
                item: self.result,
                attribute: .Top,
                relatedBy: .Equal,
                toItem: imageView,
                attribute: .Top,
                multiplier: 1,
                constant: imageView.frame.size.height*3
            ),
            
            NSLayoutConstraint(
                item: self.result,
                attribute: .Width,
                relatedBy: .Equal,
                toItem: nil,
                attribute: .Width,
                multiplier: 1,
                constant: screenwidth
            ),
            NSLayoutConstraint(
                item: self.check,
                attribute: .Top,
                relatedBy: .Equal,
                toItem: imageView,
                attribute: .Top,
                multiplier: 1,
                constant: imageView.frame.size.height*2
            ),
            NSLayoutConstraint(
                item: self.check,
                attribute: .Width,
                relatedBy: .Equal,
                toItem: nil,
                attribute: .Width,
                multiplier: 1,
                constant: screenwidth
            )]
            
        )
        self.view.bringSubviewToFront(self.input1)
        self.view.bringSubviewToFront(self.input2)
        self.view.bringSubviewToFront(self.input3)
        self.view.bringSubviewToFront(self.input4)
        input1.delegate = self
        input2.delegate = self
        input3.delegate = self
        input4.delegate = self
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func create_subset(inout in_array :[Int],inout out_array :[Int],inout out_2d :[[Int]]) -> [[Int]]? {
        if in_array.count == 0 {
            out_2d.append(out_array)
            return nil;
        }
        var in_ = in_array
        let out = out_array
        let pop = in_.removeLast()
        for i in 0 ..< out.count + 1 {
            var out_ = out
            out_.insert(pop,atIndex: i)
            create_subset(&in_, out_array: &out_, out_2d: &out_2d)
        }
        let set = NSOrderedSet(array: out_2d)
        let result = set.array as! [[Int]]
        return result
    }
    
    func calc(left: Double,right: Double,pattern: Int) -> Double? {
        switch pattern {
        case 0:
            return left + right
        case 1:
            return left - right
        case 2:
            return left * right
        case 3:
            if right == 0 {
                return nil
            }
            return left / right
        default:
            return nil
        }
        
    }
    
    func show_calc(art: Int) -> String {
        switch art {
        case 0:
            return "+"
        case 1:
            return "-"
        case 2:
            return "×"
        case 3:
            return "÷"
        default:
            return ""
        }
        
    }
    
    func calc_tree(array: [Int]) -> String {
        var ans1: Double?
        var ans2: Double?
        var ans3: Double?
        var txt: String!
        txt = ""
        top: for i in 0..<4 {
            for j in 0..<4 {
                for k in 0..<4 {
                    ans1 = calc(Double(array[0]),right: Double(array[1]),pattern: i)
                    ans2 = calc(Double(array[2]),right: Double(array[3]),pattern: j)
                    if ans1 != nil && ans2 != nil {
                        ans3 = calc(ans1!,right: ans2!,pattern: k)
                        if ans3 == 10 {
                            txt = "(" + String(array[0]) + show_calc(i) + String(array[1]) + ")"
                            txt = txt + show_calc(k) + "(" + String(array[2]) + show_calc(j) + String(array[3]) + ")"
                            break top
                        }
                    }
                }
            }
        }
        return txt
    }

}