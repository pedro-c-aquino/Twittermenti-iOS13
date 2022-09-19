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
        
        swifter.searchTweet(using: "#blessed", lang: "en", count: 100, tweetMode: .extended) { results, metaData in
            
            var tweets = [TweetsSentimentClassifierInput]()
            
            for i in 0..<100 {
                if let tweet = results[i]["full_text"].string {
                    let tweetForClassification = TweetsSentimentClassifierInput(text: tweet)
                    tweets.append(tweetForClassification)
                }
            }
            
            do {
                let predictions = try self.sentimentClassifier.predictions(inputs: tweets)
                
                var sentimentScore = 0
                
                for prediction in predictions {
                    let sentiment = prediction.label
                    
                    if sentiment == "Pos" {
                        sentimentScore += 1
                    } else if sentiment == "Neg" {
                        sentimentScore -= 1
                    }
                }
                
                print(sentimentScore)
                
            } catch {
                print("There was an error with making a prediction: \(error)")
            }
            
            
        } failure: { error in
            print("There was an error with the Twitter API Request, \(error)")
        }

        
    }

    @IBAction func predictPressed(_ sender: Any) {
    
    
    }
    
}

