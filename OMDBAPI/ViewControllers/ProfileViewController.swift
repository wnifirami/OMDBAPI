//
//  ProfileViewController.swift
//  OMDBAPI
//
//  Created by Sam on 06/01/2019.
//  Copyright © 2019 Ramos. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
class ProfileViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    
    var MoviesArray = [AnyObject]()
    let url = "http://www.omdbapi.com/?s=avengers&apiKey=295e6386"

    @IBOutlet weak var cvprofile: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GetMovies( flag: true,completionHandler: { success in
            
            self.cvprofile.reloadData()
        })  
        // Do any additional setup after loading the view.
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MoviesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieprofile", for: indexPath) as? mymoviesCollectionViewCell
        var Movie = MoviesArray[indexPath.row] as! Dictionary<String , Any>
        let imgurl = (Movie["Poster"] as? String)!
        
     
        cell?.mymovieimg.af_setImage(withURL:URL(string: imgurl)!)
      
        return cell!

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
}
