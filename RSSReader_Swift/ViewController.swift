//
//  ViewController.swift
//  RSSReader_Swift
//
//  Created by MTL on 2015/03/05.
//  Copyright (c) 2015年 MTL. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    @IBOutlet weak var tableView: UITableView!
    
    let API_URL = "https://ajax.googleapis.com/ajax/services/feed/load?v=1.0&q=http://feedblog.ameba.jp/rss/ameblo/ryo640/rss20.xml&num=10"
    var timeline:[TimelineModel] = [TimelineModel]()
    
    // ローディング
    var isInLoad = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.requestAPI()
       // self.setupFriends()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func requestAPI(){
        self.isInLoad = true;
        var url = NSURL(string: self.API_URL)!
        var task = NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: {data, response, error in
            // リソースの取得が終わると、ここに書いた処理が実行される
            var json = JSON(data: data)
            // 各セルに情報を突っ込む
            for (key: String, subJson: JSON) in json["responseData"]["feed"]["entries"] {
                
//                println(key)
//                println(subJson)
                var title = subJson["title"]
                // imgタグの中身を取得
                let content:NSString = subJson["content"].string!

                var pattern:String = "(<img.*?src=\\\")(.*?)(\\\".*?>)"
                var regex = NSRegularExpression(pattern: pattern, options: NSRegularExpressionOptions.allZeros, error: nil)
                
                if let result = regex?.firstMatchInString(content, options: NSMatchingOptions.allZeros, range: NSMakeRange(0, content.length)) {
                    var img = content.substringWithRange(result.rangeAtIndex(2))
                    println(img)
                    var f1 = TimelineModel(title: "\(title)", imageUrl: NSURL(string: img))
                    self.timeline.append(f1)
                }

            }
            // ロードが完了したので、falseに
            self.isInLoad = false
        })
        task.resume()
        
        while isInLoad {
            usleep(10)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupFriends() {
        var f1 = TimelineModel(title: "Ken", imageUrl: NSURL(string: "http://waka111.com/wp-content/uploads/2014/08/watanabek.jpg"))
        var f2 = TimelineModel(title: "Erika", imageUrl: NSURL(string: "http://dqaeric34olch.cloudfront.net/lists/57514/sawajirierika1.jpg/original?1416322567"))
        var f3 = TimelineModel(title: "Anna", imageUrl: NSURL(string: "http://cdnvideo.dolimg.com/cdn_assets/b5da8e4c0046a83b81dbd945719f6b354edd764b.jpg"))
        
        timeline.append(f1)
        timeline.append(f2)
        timeline.append(f3)
    }
    
    
    // functions needed to be implemented
    // for table view
    
    // セクション数
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    // セクションの行数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timeline.count
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath:NSIndexPath) -> UITableViewCell {
        
        let cell: CustomCell = tableView.dequeueReusableCellWithIdentifier("CustomCell", forIndexPath: indexPath) as CustomCell
        
        println(cell)
        
        cell.setCell(timeline[indexPath.row])
        
        return cell
    }
    
    
}