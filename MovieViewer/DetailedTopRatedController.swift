//
//  DetailedTopRatedController.swift
//  MovieViewer
//
//  Created by Nikhil Thota on 1/13/16.
//  Copyright © 2016 Nikhil Thota. All rights reserved.
//

import UIKit

class DetailedTopRatedController: UIViewController {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var textBox: UIView!
    
    var movie: NSDictionary!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        let title = movie["title"] as? String
        titleLabel.text = title
        
        let overview = movie["overview"] as? String
        overviewLabel.text = overview
        
        let baseUrl = "http://image.tmdb.org/t/p/w500"
        
        if let posterPath = movie["poster_path"] as? String{
            let imageUrl = NSURL(string: baseUrl + posterPath)
            
        posterImageView.setImageWithURL(imageUrl!)
        }
        
        self.view.sendSubviewToBack(posterImageView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}