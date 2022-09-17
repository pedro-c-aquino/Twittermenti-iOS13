//
//  ViewController.swift
//  Twittermenti
//
//  Created by Angela Yu on 17/07/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit
import SwifteriOS
import CoreML
import SwiftyJSON

class ViewController: UIViewController {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sentimentLabel: UILabel!
    
    let sentimentClassifier = TweetsSentimentClassifier()
    
    let swifter = Swifter(consumerKey: "EHQBThWwlz2udYPMueiRjVGzx", consumerSecret: "OzYWZlqn257Fz4uZup8QTuwbF0PGwAbh0zHFNzgH2DgsA5yeAI")

    override func viewDidLoad() {
        super.viewDidLoad()
        
//       let prediction = try! sentimentClassifier.prediction(text: "@Apple is the best company!")
//
//        print(prediction.label)
        
        swifter.searchTweet(using: "@Apple", lang: "en", count: 100, tweetMode: .extended) { results, metaData in
            
            var tweets = [String]()
            
            for i in 0..<100 {
                if let tweet = results[i]["full_text"].string {
                    tweets.append(tweet)
                }
            }
            
            
            
        } failure: { error in
            print("There was an error with the Twitter API Request, \(error)")
        }

        
    }

    @IBAction func predictPressed(_ sender: Any) {
    
    
    }
    
}

