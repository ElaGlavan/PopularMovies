//
//  PopularFeedPresenterTests.swift
//  PopularMovieTests
//
//  Created by Mihaela Glavan on 04/12/2019.
//  Copyright © 2019 Mihaela Glavan. All rights reserved.
//

@testable import PopularMovie
import XCTest


class PopularFeedPresenterTests: XCTestCase {
    
    var subject: PopularFeedPresenter!
    var mockView: MockView!
    var mockRouter: MockRouter!
    var mockInteractor: MockInteractor!

    override func setUp() {
        mockView = MockView()
        mockInteractor = MockInteractor()
        mockRouter = MockRouter()
        subject = PopularFeedPresenter(view: mockView, interactor: mockInteractor, router: mockRouter)
    }

    override func tearDown() {
        subject = nil
        mockView = nil
        mockInteractor = nil
        mockRouter = nil
    }
    
    func test_viewDidLoad_interactorIsQueriedForResultsForPageOne() {
        
        subject.viewDidLoad()
        
        XCTAssertEqual(mockInteractor.fetchNumberOfResultsCalledWithPage, 1)
    }
    
    func test_viewDidLoad_interactorReturnsPopularMovies_andPopularMoviesAreStored() {
        
        let movieResults = [
            PopularMovies(poster_path: "StubPosterPath1"),
            PopularMovies(poster_path: "StubPosterPath2")
        ]
        mockInteractor.stubResults = DecodeResults(results: movieResults)
        
        subject.viewDidLoad()
        
        XCTAssertEqual(subject.results, movieResults)
    }

//    func test_viewDidLoad_givenInteractorHasStoredPopularMovies_checkingTheNumberOfViewModelResults() {
//        subject.viewDidLoad()
//        
//        let popularMovie1 = PopularMovies(poster_path: "1")
//        let popularMovie2 = PopularMovies(poster_path: "2")
//        let popularMovie3 = PopularMovies(poster_path: "3")
//        let popularMovie4 = PopularMovies(poster_path: "4")
//        
//        mockInteractor.fetchNumberOfResults(page: 1) { (decoderResults) in
//            XCTAssertEqual(decoderResults.results.count, [popularMovie1, popularMovie2, popularMovie3, popularMovie4].count)
//        }
//    }
//    
//    func test_viewDidLoad_givenInteractorHasStoredPopularMovies_checkingThePosterPathForEachIndex() {
//        let popularMovie1 = PopularMovies(poster_path: "1")
//        let popularMovie2 = PopularMovies(poster_path: "2")
//        let popularMovie3 = PopularMovies(poster_path: "3")
//        let popularMovie4 = PopularMovies(poster_path: "4")
//        
//        var results = [popularMovie1, popularMovie2, popularMovie3, popularMovie4]
//        var index = 0
//        
//        mockInteractor.fetchNumberOfResults(page: 1) { (decoderResults) in
//            XCTAssertEqual(decoderResults.results.count, [popularMovie1, popularMovie2, popularMovie3, popularMovie4].count)
//            for result in decoderResults.results {
//                XCTAssertEqual(result.poster_path, results[index].poster_path)
//                index = index + 1
//            }
//            
//        }
//        
//    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

class MockView: PopularFeedView {
    var viewModelDidUpdate: (() -> Void)?
    
    var viewModel: PopularFeedViewModel! {
        didSet {
            viewModelDidUpdate?()
        }
    }
    
    
}

class MockRouter: RouterType {
    func navigateToFeed() {
        
    }
    
    
}

class MockInteractor: PopularFeedInteractorType {
    
    var stubResults = DecodeResults(results: [])
    var fetchNumberOfResultsCalledWithPage = 0
    
    func fetchNumberOfResults(page: Int, completion: @escaping (DecodeResults) -> ()) {
        
        fetchNumberOfResultsCalledWithPage = page

        completion(stubResults)
    }
    
    func fetchImages(posterPath: String, completion: @escaping (Data) -> ()) {
        let data = Data(base64Encoded: posterPath)
        completion(data ?? Data())
    }
    
    
}
