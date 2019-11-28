//
//  ShowViewController.swift
//  FerrariPreview
//
//  Created by ShaoPo Huang on 2019/11/25.
//  Copyright © 2019 ShaoPo Huang. All rights reserved.
//

import UIKit
import AVFoundation

class ShowViewController: UIViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dateSlider: UISlider!
    @IBOutlet weak var imageShow: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var autoStitch: UISwitch!
    
    //設定日期格式
    let dateFormatter = DateFormatter()
    //日期字串初始化空字串
    var dateString:String = ""
    //初始化func selectImage中使用的字串
    var sliderString = ""
    //宣告timer
    var timer:Timer?
    //宣告timer需要用到的值
    var autoNumber = 0
    
    //圖片陣列
    let imageArray = [
        "20090611",
        "20100101",
        "20111025",
        "20120301",
        "20130305",
        "20140926",
        "20150305",
        "20160811",
        "20170425",
        "20180306",
        "20190305",
        "20190529",
        "20200202"
    ]
    
    let labelArray = [
        "458 Italia",
        "599 GTO",
        "FF",
        "458 Spider",
        "LaFerrari",
        "458 Speciale A",
        "488 GTB",
        "GTC4 Lusso",
        "812 Superfast",
        "488 Pista",
        "F8 Tributo",
        "SF90 Stradale",
        "Ferrari Roma"
    ]
    
    
    //選日期顯示圖片
    @IBAction func SelectDate(_ sender: UIDatePicker) {
        
        let dateValue = datePicker.date
        let dateString = dateFormatter.string(from: dateValue)
        
        if UIImage(named: dateString) != nil {
            //顯示Assets資料夾中的圖片, 圖片名稱已命名與日期轉換格式相同
            //直接使用轉換的日期字串放入
            imageShow.image = UIImage(named: dateString)
            
            //讀取圖片名稱的陣列
            for (index, value) in imageArray.enumerated(){
                if value == dateString{
                    //修改Slider的值
                    dateSlider.value = Float(index)
                    //修改Label顯示的文字
                    nameLabel.text = labelArray[index]
                }
            }
        }else{
            imageShow.image = UIImage(named: "00000000")
        }
    }
    
    //利用Slider顯示圖片
    @IBAction func SelectSlider(_ sender: UISlider) {
        
        let sliderValue = Int(dateSlider.value)
        
        if sliderValue >= 0{
            //把Slider的數值丟入func, 找到對應的case
            selectImage(number:sliderValue)
            //同前面顯示圖片
            imageShow.image = UIImage(named: sliderString)
            //因圖片為日期方式命名, 且已經把日期格式轉為yyyyMMdd
            //直接把圖片名稱轉回日期格式, 達到datePicker操作
            datePicker.date = dateFormatter.date(from: sliderString)!
            //利用Slider的數值放入, 尋找Array對應位置的名稱
            nameLabel.text = labelArray[sliderValue]
        }else{
            imageShow.image = UIImage(named: "00000000")
        }
    }
    //練習switch case
    func selectImage(number:Int){
        switch number {
        case 0:
            sliderString = "20090611"
        case 1:
            sliderString = "20100101"
        case 2:
            sliderString = "20111025"
        case 3:
            sliderString = "20120301"
        case 4:
            sliderString = "20130305"
        case 5:
            sliderString = "20140926"
        case 6:
            sliderString = "20150305"
        case 7:
            sliderString = "20160811"
        case 8:
            sliderString = "20170425"
        case 9:
            sliderString = "20180306"
        case 10:
            sliderString = "20190305"
        case 11:
            sliderString = "20190529"
        case 12:
            sliderString = "20200202"
        default:
            sliderString = "00000000"
        }
    }
    
    @IBAction func autoDisplay(_ sender: UISwitch) {
        
        if sender.isOn{
            autoDisplayTimer()
        }else{
            timer!.invalidate()
        }
    }
    
    func autoDisplayImage(){
        
        dateSlider.value = Float(autoNumber)
        let sliderValue = Int(dateSlider.value)
        
        if autoNumber < imageArray.count  {
            selectImage(number:sliderValue)
            datePicker.date = dateFormatter.date(from: sliderString)!
            imageShow.image = UIImage(named: imageArray[autoNumber])
            nameLabel.text = labelArray[autoNumber]
        }else{
            autoNumber = 0
            selectImage(number:autoNumber)
            datePicker.date = dateFormatter.date(from: sliderString)!
            dateSlider.value = Float(autoNumber)
            imageShow.image = UIImage(named: imageArray[autoNumber])
            nameLabel.text = labelArray[autoNumber]
        }
        
        autoNumber += 1
    }
    
    func autoDisplayTimer(){
        timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true, block: { (timer) in
            self.autoDisplayImage()
        })
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //轉換datePicker格式為中文
        datePicker.locale = Locale(identifier: "zh_TW")
        dateFormatter.dateFormat = "yyyyMMdd"
        //初始化畫面
        dateSlider.value = 0
        nameLabel.text = labelArray[0]
        imageShow.image = UIImage(named: imageArray[0])
        autoStitch.isOn = false
        timer?.invalidate()
    }
    
    
}
