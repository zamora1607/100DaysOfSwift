//
//  ContentView.swift
//  Shared
//
//  Created by Ania on 30/12/2020.
//

import SwiftUI

enum NetworkError: Error {
    case badURL, requestFailed, unknown
}

struct ContentView: View {
    
    @ObservedObject var updater = DelayedUpdater()
    
    var body: some View {
        VStack {
            Text("value is: \(updater.value)")
            Image("example")
                .interpolation(.none)
                .resizable()
                .scaledToFit()
                .frame(maxHeight: .infinity)
                .background(Color.black)
                .edgesIgnoringSafeArea(.all)
            
//            Text("Hello, World!")
//                .onAppear {
//                    self.fetchData(from: "https://www.apple.com") { (result) in
//                        switch result {
//                        case .success(let str):
//                            print(str)
//                        case .failure(let error):
//                            switch error {
//                            case .badURL:
//                                print("Bad URL")
//                            case .requestFailed:
//                                print("Network problems")
//                            case .unknown:
//                                print("Uknown error")
//                            }
//                        }
//                    }
//                }
        }
    }
    
    func fetchData(from urlString: String, completion: @escaping ((Result<String, NetworkError>) -> Void)) {
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.badURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let data = data {
                    let stringData = String(decoding: data, as: UTF8.self)
                    completion(.success(stringData))
                } else if error != nil {
                    completion(.failure(.requestFailed))
                } else {
                    completion(.failure(.unknown))
                }
            }
        }.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
