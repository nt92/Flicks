//
//  MoviesViewController.swift
//  MovieViewer
//
//  Created by Nikhil Thota on 1/4/16.
//  Copyright © 2016 Nikhil Thota. All rights reserved.
//

import UIKit
import AFNetworking
import EZLoadingActivity

class MoviesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    var refreshControl: UIRefreshControl!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        EZLoadingActivity.showWithDelay("Loading...", disableUI: true, seconds: 1)
        if let movies = movies{
            return movies.count
        }
        else{
            return 0
        }
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionMovieCell", forIndexPath: indexPath) as! CollectionMovieCell
        
        let movie = movies![indexPath.row]
        let baseUrl = "http://image.tmdb.org/t/p/w500"
        let posterPath = movie["poster_path"] as! String
        let imageUrl = NSURL(string: baseUrl + posterPath)
        
        cell.posterImage.setImageWithURL(imageUrl!)
        
        return cell
    }
    
    
    var movies: [NSDictionary]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
        collectionView.insertSubview(refreshControl, atIndex: 0)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = NSURL(string:"https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)")
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
        )
        
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                if let data = dataOrNil {
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                        data, options:[]) as? NSDictionary {
                            //NSLog("response: \(responseDictionary)")
                            self.movies = responseDictionary["results"] as? [NSDictionary]
                            self.collectionView.reloadData()
                            EZLoadingActivity.hide(success: true, animated: true)
                    }
                }
                else{
                    EZLoadingActivity.hide(success: false, animated: true)
                }
        });
        task.resume()
    }
    
    override func viewDidAppear(animated: Bool) {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    func onRefresh() {
        delay(2, closure: {
            self.refreshControl.endRefreshing()
            self.collectionView.reloadData()
        })
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
