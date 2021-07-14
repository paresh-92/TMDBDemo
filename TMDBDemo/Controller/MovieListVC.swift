//
//  MovieListVC.swift
//  TMDBDemo
//
//  Created by Paresh Thakkar on 13/07/21.
//

import UIKit
import Alamofire
import SDWebImage
import Cosmos

class MovieListVC: UIViewController {
    
    @IBOutlet weak var tblMovieList: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
   
    
    
    var result : [Result] = []
    var gen : [Genre] = []
    var movieNumber = 0
    var storedResponse : [Any] = []
    var ratingView = CosmosView()
    var genres : Genre?
    var passGenArray : [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        tndbApi()
    }
    
}
extension MovieListVC : UITableViewDelegate,UITableViewDataSource
{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblMovieList.dequeueReusableCell(withIdentifier: "MoviesCell", for: indexPath) as! MoviesCell
        cell.lblMovieName.text = result[indexPath.row].title
        let url = imageBaseURL + result[indexPath.row].posterPath
        cell.imgPoster.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: ""))
        self.ratingView = cell.ratingView
        self.ratingView.settings.fillMode = .half
        self.ratingView.text = "\(result[indexPath.row].voteAverage)"
        self.ratingView.rating = result[indexPath.row].voteAverage/2
        cell.lblReleaseDate.text = "Release Date:- " + result[indexPath.row].releaseDate
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tblMovieList.cellForRow(at: indexPath) as! MoviesCell
        for id in result[indexPath.row].genreIDS
        {
            let id1 = id
            for data in gen
            {
                let name1 = data.id
                if name1 == id1
                {
                    passGenArray.append(data.name)
                    break
                }
            }
        }
        let vc = storyboard?.instantiateViewController(withIdentifier: "MovieDetailVC") as! MovieDetailVC
        vc.image = cell.imgPoster.image!
        vc.ratingText = "\(result[indexPath.row].voteAverage)"
        vc.ratings = result[indexPath.row].voteAverage/2
        vc.movieTitle = cell.lblMovieName.text!
        vc.overview = result[indexPath.row].overview
        vc.genArray = passGenArray
        passGenArray.removeAll()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension MovieListVC
{
    func tndbApi()
    {
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        let url = BaseURL + Api_Key + "&language=en-US&page=1"
        let headers : HTTPHeaders = ["Authorization":"Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3MDlmNDA3YWRhYWYyZjQ0ZDE2NzI4NTI4NDBkYzdmNyIsInN1YiI6IjYwZWQ3YWM0ZGNmODc1MDA0OGU4ZWY3NSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.8GC4pYP0ca86IC8ZNrF2qBIshOMZRWenV2xByUkTwfY","Content-Type":"application/json"]
        
        let manager = AF.session
        manager.configuration.timeoutIntervalForRequest = 1000000
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON {
            (response) in
            print(response)
            switch response.result {
            case .success:
                if let data = response.data {
                    // Convert This in JSON
                    do {
                        let responseModel = try JSONDecoder().decode(TMDBModel.self, from: data)
                        self.result = responseModel.results
                            self.activityIndicator.stopAnimating()
                            self.activityIndicator.isHidden = true
                        self.genreApi()
                            
                            
                        }
                        catch let error as NSError{
                        print(error)
                    }
                    
                }
            case .failure(let error):
                print("Error:", error)
            }
            
        }
        
    }
    func genreApi()
    {

        let url = BaseURL2
        let headers : HTTPHeaders = ["Authorization":"Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3MDlmNDA3YWRhYWYyZjQ0ZDE2NzI4NTI4NDBkYzdmNyIsInN1YiI6IjYwZWQ3YWM0ZGNmODc1MDA0OGU4ZWY3NSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.8GC4pYP0ca86IC8ZNrF2qBIshOMZRWenV2xByUkTwfY","Content-Type":"application/json"]
        
        let manager = AF.session
        manager.configuration.timeoutIntervalForRequest = 1000000
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON {
            (response) in
            print(response)
            switch response.result {
            case .success:
                if let data = response.data {
                    // Convert This in JSON
                    do {
                        let responseModel = try JSONDecoder().decode(Genres.self, from: data)
                        self.gen = responseModel.genres
                        self.tblMovieList.reloadData()
                        }
                        catch let error as NSError{
                        print(error)
                    }
                    
                }
            case .failure(let error):
                print("Error:", error)
            }
            
        }
        
    }
 //
}
@IBDesignable extension UIView {
    
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}

