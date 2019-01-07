//
//  ViewController.swift
//  OMDBAPI
//
//  Created by Sam on 05/01/2019.
//  Copyright © 2019 Ramos. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    var type = "movie"
    var count = 0
    @IBOutlet weak var MoviesCV: UICollectionView!
    
    @IBOutlet weak var searchb: UISearchBar!
    @IBOutlet weak var seriesbtn: UIButton!
    @IBOutlet weak var moviebtn: UIButton!
    
    @IBOutlet weak var viewfound: UIView!
    @IBOutlet weak var viewnotfound: UIView!
    
    let url = "http://www.omdbapi.com/?s=avengers&apiKey=295e6386"
    var urlsearch = "http://www.omdbapi.com/?apiKey=295e6386&s="
    let urlseries = "http://www.omdbapi.com/?s=avengers&apiKey=295e6386&type=series"
    var urlseriessearch = "http://www.omdbapi.com/?apiKey=295e6386&type=series&s="
    var MoviesArray = [AnyObject]()
    var SeriesArray = [AnyObject]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.seriesbtn.setBackgroundImage(UIImage(named: "fillgrey"), for: .normal)

        self.viewnotfound.isHidden = true
        GetMovies( flag: true,completionHandler: { success in
            
            self.MoviesCV.reloadData()
        })        // Do any additional setup after loading the view, typically from a nib.
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if type == "movie"{
            count =  MoviesArray.count
            
        }
        else {
            count =  SeriesArray.count
        }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "moviecell", for: indexPath) as? MovieCollectionViewCell
        if type == "movie"{
            
            var Movie = MoviesArray[indexPath.row] as! Dictionary<String , Any>
            let imgurl = (Movie["Poster"] as? String)!
            
            cell?.movieImg.af_setImage(withURL:URL(string: imgurl)!)
            cell?.Movielbl.text = (Movie["Title"] as? String)!
        }
        else{
            var Serie = SeriesArray[indexPath.row] as! Dictionary<String , Any>
            let imgurl = (Serie["Poster"] as? String)!
            
            cell?.movieImg.af_setImage(withURL:URL(string: imgurl)!)
            cell?.Movielbl.text = (Serie["Title"] as? String)!
        }
        return cell!
    }
    
    @IBAction func MovieBtnclicked(_ sender: UIButton) {
        type = "movie"
        //performSegue(withIdentifier: "detail", sender: self)
        GetMovies( flag: true,completionHandler: { success in
            self.moviebtn.setBackgroundImage(UIImage(named: "fill"), for: .normal)
            self.seriesbtn.setBackgroundImage(UIImage(named: "fillgrey"), for: .normal)
            self.MoviesCV.reloadData()
        })
        
    }
    
    
    @IBAction func Seriebtnpressed(_ sender: UIButton) {
        type = "Serie"
        GetSeries( flag: true,completionHandler: { success in
            self.seriesbtn.setBackgroundImage(UIImage(named: "fill"), for: .normal)
            self.moviebtn.setBackgroundImage(UIImage(named: "fillgrey"), for: .normal)
            self.MoviesCV.reloadData()
        })
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main" , bundle : nil)
        //performSegue(withIdentifier: "det", sender: self)
        let desVC = mainStoryboard.instantiateViewController(withIdentifier: "DetailsViewController") as!  DetailViewController
        // let desVC = DetailscollectionViewController()
        if type == "movie" {
            let im = (MoviesArray[indexPath.row]["Poster"] as? String)!
            
            
            desVC.movieimg = im
            desVC.id = (MoviesArray[indexPath.row]["imdbID"] as? String)!
            
        }
        else{
            let im = (SeriesArray[indexPath.row]["Poster"] as? String)!
            
            
            desVC.movieimg = im
            desVC.id = (SeriesArray[indexPath.row]["imdbID"] as? String)!
        }
        self.navigationController?.pushViewController(desVC, animated: true)
    }
    
    
    func GetMoviessearch( title:String,flag:Bool, completionHandler: @escaping (Bool) -> Void ) {
        
        
        Alamofire.request(urlsearch+title).responseJSON
            {
                response  in
                
                
                //getting the json value from the server
                
                
                let result = response.result
                if let dict = result.value as? Dictionary<String,AnyObject>{
                    print(dict)
                    
                    if dict["Response"] as! String == "False" {
                        self.viewfound.isHidden = true
                        self.viewnotfound.isHidden = false
                    }
                    else{
                        self.viewfound.isHidden = false
                        self.viewnotfound.isHidden = true
                        self.MoviesArray = dict["Search"] as! [AnyObject]
                        
                    }
                    
                    //  self.BarsArray = innerdict as! [AnyObject]
                    // let val = jsonData.value(forKey: "") as! [[String:Any]]
                    
                    
                    
                    
                    
                }
                completionHandler(true)
        }
    }
    
    
    
    func GetMovies( flag:Bool, completionHandler: @escaping (Bool) -> Void ) {
        
        
        Alamofire.request(url).responseJSON
            {
                response  in
                
                
                //getting the json value from the server
                
                
                let result = response.result
                if let dict = result.value as? Dictionary<String,AnyObject>{
                    
                    self.MoviesArray = dict["Search"] as! [AnyObject]
                    
                    //  self.BarsArray = innerdict as! [AnyObject]
                    // let val = jsonData.value(forKey: "") as! [[String:Any]]
                    
                    
                    
                    
                    
                }
                completionHandler(true)
        }
    }
    
    
    func GetSeries( flag:Bool, completionHandler: @escaping (Bool) -> Void ) {
        
        
        Alamofire.request(urlseries).responseJSON
            {
                response  in
                
                
                //getting the json value from the server
                
                
                let result = response.result
                if let dict = result.value as? Dictionary<String,AnyObject>{
                    
                    self.SeriesArray = dict["Search"] as! [AnyObject]
                    
                    //  self.BarsArray = innerdict as! [AnyObject]
                    // let val = jsonData.value(forKey: "") as! [[String:Any]]
                    
                    
                    
                    
                    
                }
                completionHandler(true)
        }
    }
    
    func GetSeriessearch( title:String,flag:Bool, completionHandler: @escaping (Bool) -> Void ) {
        
        
        Alamofire.request(urlseriessearch+title).responseJSON
            {
                response  in
                
                
                //getting the json value from the server
                
                
                let result = response.result
                if let dict = result.value as? Dictionary<String,AnyObject>{
                    
                    if dict["Response"] as! String == "False" {
                        self.viewfound.isHidden = true
                        self.viewnotfound.isHidden = false                    }
                    else{
                        self.viewfound.isHidden = false
                        self.viewnotfound.isHidden = true
                        self.SeriesArray = dict["Search"] as! [AnyObject]
                    }
                    
                    
                    
                    
                    
                    
                    
                }
                completionHandler(true)
        }
    }
    
    
    
}
extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if type == "movie" {
            GetMoviessearch( title:searchText ,flag: true,completionHandler: { success in
                
                self.MoviesCV.reloadData()
            })
        }
        else{
            GetSeriessearch( title:searchText ,flag: true,completionHandler: { success in
                
                self.MoviesCV.reloadData()
            })
        }
        
        
    }
}
