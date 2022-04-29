//
//  SearchManager.swift
//  Weather.
//
//  Created by Matúš Mištrik on 18/04/2022.
//

import Foundation
import MapKit

struct Place: Codable {
    
    let city: String
    let country: String
}

typealias LocalSearchCompletionHandler = (([Place]) -> Void)

class SearchManager: NSObject {
    
    // MARK: - Constants
    
    private let searchCompleter = MKLocalSearchCompleter()
    
    // MARK: - Variables
    private var searchCompletion: LocalSearchCompletionHandler?
    
    
    override init() {
        super.init()
        
        searchCompleter.delegate = self
        searchCompleter.resultTypes = .address
    }
    
    func getLocalSearchResults(from query: String, completion: @escaping LocalSearchCompletionHandler) {
        self.searchCompletion = completion
        
        if query.isEmpty {
            completion([])
        }
        
        searchCompleter.resultTypes = .address
        searchCompleter.queryFragment = query
        searchCompleter.delegate = self
    }
}


extension SearchManager: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        
        
        let places = completer.results
            .filter { !$0.title.isEmpty }
            .map { $0.title.components(separatedBy: ",")}
            .filter {$0.count > 1}
            .map { Place(city: $0[0], country: $0[1]) }
        searchCompletion?(places)
        print(places)
    }
}
