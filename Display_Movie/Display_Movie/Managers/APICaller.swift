//
//  APICaller.swift
//  Display_Movie
//
//  Created by Neacsu Dragos on 04.08.2022.
//

import Foundation

struct Contants {
    static let API_KEY = "f1b8b13e0f1c7935c17d5b9e5b4f24e5"
    static let baseURL = "https://api.themoviedb.org"
}
enum APIError: Error {
    case failedToGetData
}

class APICaller {
    static let shared = APICaller()
    
    
    func getPopularMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URL(string: "\(Contants.baseURL)/3/movie/popular?api_key=\(Contants.API_KEY)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url:url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(MovieResponse.self, from: data)
                completion(.success(results.results))
                
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
            
        }
        task.resume()
    }
    
    func getUpcomingMovies (completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URL(string: "\(Contants.baseURL)/3/movie/upcoming?api_key=\(Contants.API_KEY)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url:url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(MovieResponse.self, from: data)
                completion(.success(results.results))
                
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
            
        }
        task.resume()
    }
    
    
    func getTopRatedMovies (completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URL(string: "\(Contants.baseURL)/3/movie/top_rated?api_key=\(Contants.API_KEY)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url:url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(MovieResponse.self, from: data)
                completion(.success(results.results))
                
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
            
        }
        task.resume()
    }
    
    func getDiscoverMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URL(string:"\(Contants.baseURL)/3/discover/movie?api_key=\(Contants.API_KEY)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate") else {return }
            let task = URLSession.shared.dataTask(with: URLRequest(url:url)) { data, _, error in
                guard let data = data, error == nil else {
                return
                }
                do {
                    let results = try JSONDecoder().decode(MovieResponse.self, from: data)
                    completion(.success(results.results))
                                    
                } catch {
                    completion(.failure(APIError.failedToGetData))
                }
                                
                }
        task.resume()
    }
    
    func search (with query: String, completion: @escaping (Result<[Movie], Error>) -> Void) {
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "\(Contants.baseURL)/3/search/movie?api_key=\(Contants.API_KEY)&query=\(query)") else {
            return
        }
            let task = URLSession.shared.dataTask(with: URLRequest(url:url)) { data, _, error in
                guard let data = data, error == nil else {
                return
                }
                do {
                    let results = try JSONDecoder().decode(MovieResponse.self, from: data)
                    completion(.success(results.results))
                                    
                } catch {
                    completion(.failure(APIError.failedToGetData))
                }
                                
                }
        task.resume()
    }
}
