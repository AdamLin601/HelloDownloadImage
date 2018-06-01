//
//  ViewController.swift
//  HelloDownloadImage
//
//  Created by 林奕德 on 2018/4/4.
//  Copyright © 2018年 AppsAdamLin. All rights reserved.
//

import UIKit
import WebKit
class ViewController: UIViewController {

    @IBOutlet weak var myImageView: UIImageView!
    
    var session:URLSession?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       session = URLSession(configuration: .default)//1.產生
        
        let imageAddress = "https://image.redbull.com/rbcom/010/2016-09-08/1331816583483_2/0010/1/1600/1067/1/which-one-are-you.jpg"
        if let imageUrl = URL(string: imageAddress){
            //URlsession 預設工作是共時佇列 DispatchQueue.global
//            let task = session?.dataTask(with: imageUrl, completionHandler: {
//                (date,response,error) in
//                if error != nil{
//                    print(error!.localizedDescription)
//                    return
//                }
//                if let loadedDate = date{
//                    let loadedImage = UIImage(data: loadedDate)
//                    DispatchQueue.main.async {
//                        self.myImageView.image = loadedImage
//                    }
//                }
//            })
//            //2.呼叫dateTask方法 回傳一個工作 for "task"
//            task?.resume()//3.開始下載
          let newTask = session?.downloadTask(with: imageUrl, completionHandler: {
                (url, respones, error) in
                if error != nil {
                  let errorCode = (error! as NSError).code//將錯誤 轉型 存入
                    if errorCode == -1009{
                        print("No Internet connection") //或做警告控制器(alert)
                    }else{
                        print(error!.localizedDescription)
                    }
                    print(error!.localizedDescription)
                    return
                }
                if let loadedurl = url{
                    do{
                      
                     let loadedImage = UIImage(data: try   Data(contentsOf: loadedurl))
                        DispatchQueue.main.async {
                            self.myImageView.image = loadedImage
                        }
                    }catch{
                        print(error.localizedDescription)
                    }
                    
                }
            })
            newTask?.resume()
            
        }
    }
            
            
//            DispatchQueue.global().async { //在不同步的佇列執行下載(避免檔案過大網路不穩)
//                do{
//                    let downloadImage = UIImage(data:try  Data(contentsOf:imageUrl))//date 下載資料
//                    //下載結果存進downloadImage
//                    DispatchQueue.main.async {
//                        self.myImageView.image = downloadImage
//                        //再將存完圖片於主佇列顯示
//                    }
//                }catch{
//                    print(error.localizedDescription)
//                }
//            }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

