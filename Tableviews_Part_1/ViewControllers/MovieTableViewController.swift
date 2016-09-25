//
//  MovieTableViewController.swift
//  Tableviews_Part_1
//
//  Created by Jason Gresh on 9/22/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class MovieTableViewController: UITableViewController {
    enum Genre: Int {
        case animation
        case action
        case drama
    }
    
    enum Year: Int{
        case y1900s
        case y2000s
    }
    
    enum sortType{
        case year
        case genre
    }
    
    internal var movieData: [Movie]?
    internal var sortSwitch: sortType = .genre
    internal let rawMovieData: [[String : Any]] = movies
    let cellIdentifier: String = "MovieTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Movies"
        self.tableView.backgroundColor = UIColor.blue
        // converting from array of dictionaries
        // to an array of Movie structs
        var movieContainer: [Movie] = []
        for rawMovie in rawMovieData {
            movieContainer.append(Movie(from: rawMovie))
        }
        movieData = movieContainer
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        switch sortSwitch{
        case .year:
            return 2
        case .genre:
            return 3
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch sortSwitch {
        case .genre:
            guard let genre = Genre.init(rawValue: section), let data = byGenre(genre)
                else {
                    return 0
            }
            return data.count
        case .year:
            guard let year = Year.init(rawValue: section), let data = byYear(year)
                else {
                    return 0
            }
            return data.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        switch sortSwitch {
        case .genre:
            guard let genre = Genre.init(rawValue: indexPath.section), let data = byGenre(genre)
                else {
                    return cell
            }
            cell.textLabel?.text = data[indexPath.row].title
            cell.detailTextLabel?.text = String(data[indexPath.row].year)
            return cell
        case .year:
            guard let year = Year.init(rawValue: indexPath.section), let data = byYear(year)
                else {
                    return cell
            }
            cell.textLabel?.text = data[indexPath.row].title
            cell.detailTextLabel?.text = String(data[indexPath.row].year)
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch sortSwitch {
        case .genre:
            guard let genre = Genre.init(rawValue: section) else { return "" }
            switch genre {
            case .action:
                return "Action"
            case .animation:
                return "Animation"
            case .drama:
                return "Drama"
            }
        case .year:
            guard let year = Year.init(rawValue: section) else { return "" }
            switch year {
            case .y1900s:
                return "20th Century"
            case .y2000s:
                return "21st Century"
            }
        }
    }
    
    
    // MARK: - Sort Functions
    
    func byGenre(_ genre: Genre) -> [Movie]? {
        let filter: (Movie) -> Bool
        switch genre {
        case .action:
            filter = { (a) -> Bool in
                a.genre == "action"
            }
        case .animation:
            filter = { (a) -> Bool in
                a.genre == "animation"
            }
        case .drama:
            filter = { (a) -> Bool in
                a.genre == "drama"
            }
        }
        
        // after filtering, sort
        let filtered = movieData?.filter(filter).sorted {  $0.year < $1.year }
        
        return filtered
    }
    
    func byYear(_ year: Year) -> [Movie]? {
        let filter: (Movie) -> Bool
        switch year {
        case .y1900s:
            filter = { (a) -> Bool in
                a.year >= 1900 && a.year < 2000
            }
        case .y2000s:
            filter = { (a) -> Bool in
                a.year >= 2000 && a.year < 2100
            }
        }
        
        // after filtering, sort
        let filtered = movieData?.filter(filter).sorted {  $0.year < $1.year }
        
        return filtered
    }
    
    @IBAction func sortOptions(_ sender: UIBarButtonItem) {
        if sortSwitch == .genre{
            sortSwitch = .year
        }else{
            sortSwitch = .genre
        }
        self.tableView.reloadData()
    }
}
