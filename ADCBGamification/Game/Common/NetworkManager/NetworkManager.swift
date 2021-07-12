//
//  NetworkManager.swift
//  ADCBGamification
//
//  Created by SKY on 07/07/21.
//

import Foundation
enum ErrorType {
    case invalidUrl
    case checkError
    case decodeError(String)
}

enum MethodType: String {
    case get = "GET"
    case post = "POST"
}
class NetworkManager {
    
    private static let timeOut = 30
    
    private class func createCommonRequest(url: URL, urlReq: URLRequest, methodType: MethodType) -> URLRequest {
        var req = urlReq
         //req = URLRequest(url: url,timeoutInterval: TimeInterval(timeOut))
        req.httpMethod = methodType.rawValue
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        req.setValue("Bearer \(StoreManager.shared.accessToken)", forHTTPHeaderField: "Authorization")
        return req
    }
    
    class func postRequest<T:Decodable>(struct: T.Type, url: String, urlReq: URLRequest? = nil, requestData: Dictionary<String, Any>? = nil, complition: ((T?,ErrorType?)->Void)?) {
        guard let ur = URL(string: url) else { complition?(nil, .invalidUrl); return}
        let urReq = urlReq ?? URLRequest(url: ur)
        print("urlReq \(urReq)")
        var req = createCommonRequest(url: ur, urlReq: urReq, methodType: .post)
        if let reData = requestData {
            print("req pac = \(reData)")
            let jsonData = try? JSONSerialization.data(withJSONObject: reData, options:[])
            req.httpBody = jsonData
    }
        task(req: req, complition: complition)
    }
    
    class func getRequest<T:Decodable>(struct: T.Type, url: String, urlReq: URLRequest? = nil, complition:((T?,ErrorType?)->Void)?) {
        guard let ur = URL(string: url) else { complition?(nil, .invalidUrl); return}
        let urReq = urlReq ?? URLRequest(url: ur)
        print("urlReq \(urReq)")
        let req = createCommonRequest(url: ur, urlReq: urReq, methodType: .get)
        
        task(req: req, complition: complition)
    }
    
    private class func task<T:Decodable>(req: URLRequest, complition:((T?, ErrorType?)->Void?)?) {
        let task = URLSession.shared.dataTask(with: req) { (data, resp, error) in
            printStatement(req: req, data: data, resp: resp, error: error)
            parseData(data: data, resp: resp, error: error, complition: complition)
        }
        task.resume()
    }
    
    private static func printStatement(req: URLRequest, data: Data?, resp: URLResponse?, error: Error?) {
        print("\n\n\n")
        if let data = data {
            print("data into String \(String(data: data, encoding: .utf8))")
        }
        //print("Responce is \(String(describing: resp))")
        print("\n\n\n")
        print("Header is \(req.allHTTPHeaderFields)")
        print("Data is \(String(describing: data))")
        print("Error is \(String(describing: error))")
        print("\n\n\n")
        print("Req \(req)")
        print("url \(String(describing: req.url))")
        if let da = data {
            let json = try? JSONSerialization.jsonObject(with: da, options: .allowFragments)
            print("Json data is \(json)")
        }
        
        print("\n\n\n")
        
        print("\n\n\n")
    }
    
    private class func parseData<T: Decodable>(data: Data?, resp: URLResponse?, error: Error?,complition:((T?, ErrorType?)->Void?)?) {
        guard let data = data else { complition?(nil,.checkError) ;return}
        do {
            let result = try JSONDecoder().decode(T.self, from: data)
            print("Result is after decode = \(result)")
            print("Result is after decode = \(result)")
            complition?(result, nil)
        } catch let error {
            print("error is \(error)")
            print("Json decode error \(error.localizedDescription)")
            complition?(nil, .decodeError(error.localizedDescription))
        }
    }
}
