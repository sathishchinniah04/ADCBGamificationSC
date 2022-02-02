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

class NetworkManager: NSObject {
    
    private static let timeOut = 30
    
    private func createCommonRequest(url: URL, urlReq: URLRequest, methodType: MethodType) -> URLRequest {
        var req = urlReq
         //req = URLRequest(url: url,timeoutInterval: TimeInterval(timeOut))
        req.httpMethod = methodType.rawValue
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        req.setValue("Bearer \(StoreManager.shared.accessToken)", forHTTPHeaderField: "Authorization")
        return req
    }
    
     func postRequest<T:Decodable>(struct: T.Type?, url: String, urlReq: URLRequest? = nil, requestData: Dictionary<String, Any>? = nil, complition: ((T?,ErrorType?)->Void)?) {
        guard let ur = URL(string: url) else { complition?(nil, .invalidUrl); return}
        let urReq = urlReq ?? URLRequest(url: ur)
        print("urlReq \(urReq)")
        print("urlReq \(urReq)")
        var req = createCommonRequest(url: ur, urlReq: urReq, methodType: .post)
        if let reData = requestData {
            print("req pac = \(reData)")
            let jsonData = try? JSONSerialization.data(withJSONObject: reData, options:[.fragmentsAllowed])
            let intoStr = String(data: jsonData!, encoding: .utf8)
            print("req pac into json formate = \(intoStr!)")
            req.httpBody = jsonData//Data(intoStr!.utf8)
    }
        task(req: req, complition: complition)
    }
    
     func getRequest<T:Decodable>(struct: T.Type, url: String, urlReq: URLRequest? = nil, complition:((T?,ErrorType?)->Void)?) {
        guard let ur = URL(string: url) else { complition?(nil, .invalidUrl); return}
        let urReq = urlReq ?? URLRequest(url: ur)
        print("urlReq \(urReq)")
        let req = createCommonRequest(url: ur, urlReq: urReq, methodType: .get)
        
        task(req: req, complition: complition)
    }
    
    func getArrayRequest<T:Decodable>(struct: [T.Type], url: String, urlReq: URLRequest? = nil, complition:(([T]?, ErrorType?)->Void)?) {
       guard let ur = URL(string: url) else { complition?(nil, .invalidUrl); return}
       let urReq = urlReq ?? URLRequest(url: ur)
       print("urlReq \(urReq)")
       let req = createCommonRequest(url: ur, urlReq: urReq, methodType: .get)
       
       task(req: req, complition: complition)
   }
    
    func plainGetRequest(url: String, urlReq: URLRequest? = nil, complition:((String?,ErrorType?)->Void)?) {
       guard let ur = URL(string: url) else { complition?(nil, .invalidUrl); return}
       let urReq = urlReq ?? URLRequest(url: ur)
       print("urlReq \(urReq)")
       let req = createCommonRequest(url: ur, urlReq: urReq, methodType: .get)
       
        plainTask(req: req, complition: complition)
   }
    
    
     func plainPostRequest(url: String, urlReq: URLRequest? = nil, requestData: Dictionary<String, Any>? = nil, complition: ((String?,ErrorType?)->Void)?) {
        guard let ur = URL(string: url) else { complition?(nil, .invalidUrl); return}
        let urReq = urlReq ?? URLRequest(url: ur)
        print("urlReq \(urReq)")
        print("urlReq \(urReq)")
        var req = createCommonRequest(url: ur, urlReq: urReq, methodType: .post)
        if let reData = requestData {
            print("req pac = \(reData)")
            let jsonData = try? JSONSerialization.data(withJSONObject: reData, options:[.fragmentsAllowed])
            let intoStr = String(data: jsonData!, encoding: .utf8)
            print("req pac into json formate = \(intoStr!)")
            req.httpBody = jsonData//Data(intoStr!.utf8)
    }
        plainTask(req: req, complition: complition)
    }
    
    private func plainTask(req: URLRequest, complition:((String?, ErrorType?)->Void?)?) {
        
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: nil)
        
        let task = session.dataTask(with: req) { (data, resp, error) in
        
            if let httpResponse = resp as? HTTPURLResponse {
                complition!("\(httpResponse.statusCode)", nil)
            }
        }
        task.resume()
    }
    
    
    
    private func task<T:Decodable>(req: URLRequest, complition:((T?, ErrorType?)->Void?)?) {
        
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: nil)
        
        let task = session.dataTask(with: req) { (data, resp, error) in
            self.printStatement(req: req, data: data, resp: resp, error: error)
            self.parseData(data: data, resp: resp, error: error, complition: complition)
            if let httpResponse = resp as? HTTPURLResponse{
                if  let dict = httpResponse.allHeaderFields as? [String: String] {
                    let message = dict["Share_Message"]?.removingPercentEncoding
                    var currentMessage = message?.replacingOccurrences(of: "+", with: " ")
                    let emailSub = dict["emailSubject"]?.removingPercentEncoding
                    var currentEmailSub = emailSub?.replacingOccurrences(of: "+", with: " ")
                    print("message is \(String(describing: message))")
                    Constants.referMessage = currentMessage ?? ""
                    Constants.commonEmailSubject = currentEmailSub ?? ""
                }
                
            }
        }
        task.resume()
    }
    
    private func printStatement(req: URLRequest, data: Data?, resp: URLResponse?, error: Error?) {
        print("\n\n\n")
        
        print("responce is \(resp)\n\n\n")
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

    private func parseData<T: Decodable>(data: Data?, resp: URLResponse?, error: Error?,complition:((T?, ErrorType?)->Void?)?) {
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

extension NetworkManager : URLSessionDelegate {
    
    public func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
           //Trust the certificate even if not valid
           let urlCredential = URLCredential(trust: challenge.protectionSpace.serverTrust!)

           completionHandler(.useCredential, urlCredential)
        }
    
}
    
    
//    public  func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
//
//        // Adapted from OWASP https://www.owasp.org/index.php/Certificate_and_Public_Key_Pinning#iOS
//
//        if (challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust) {
//            if let serverTrust = challenge.protectionSpace.serverTrust {
//                var secresult = SecTrustResultType.invalid
//                let status = SecTrustEvaluate(serverTrust, &secresult)
//
//                if(errSecSuccess == status) {
//                    if let serverCertificate = SecTrustGetCertificateAtIndex(serverTrust, 0) {
//                        let serverCertificateData = SecCertificateCopyData(serverCertificate)
//                        let data = CFDataGetBytePtr(serverCertificateData);
//                        let size = CFDataGetLength(serverCertificateData);
//                        let cert1 = NSData(bytes: data, length: size)
//                        let serverCert = SecCertificateCreateWithData(kCFAllocatorDefault, cert1)
//
//                        let bundle = Bundle(for: NetworkManager.self)
//
//                        if let path = bundle.path(forResource: "cert", ofType: "pem") {
//
//                            do {
//                                let contents = try String(contentsOfFile: path)
//
//                                var certPath = contents
//
//                                // remove the header string
//
//                                let offset = ("-----BEGIN CERTIFICATE-----").count
//                                let index = certPath.index(path.startIndex, offsetBy: offset+1)
//                                certPath = certPath.substring(from: index)
//
//                                // remove the tail string
//
//                                let tailWord = "-----END CERTIFICATE-----"
//                                if let lowerBound = certPath.range(of: tailWord)?.lowerBound {
//                                    certPath = certPath.substring(to: lowerBound)
//                                }
//
//                                guard let data = NSData(base64Encoded: certPath,
//                                                        options:NSData.Base64DecodingOptions.ignoreUnknownCharacters) else {
//                                    return
//                                }
//
//                                let selfSignedCert = SecCertificateCreateWithData(kCFAllocatorDefault, data)
//
//                                if serverCert == selfSignedCert {
//
//                                    let urlCredential = URLCredential(trust: challenge.protectionSpace.serverTrust!)
//                                    completionHandler(.useCredential, urlCredential)
//
//                                    //completionHandler(URLSession.AuthChallengeDisposition.useCredential, URLCredential(trust:serverTrust))
//                                    //return
//                                } else {
//                                    // Pinning failed
//                                    completionHandler(URLSession.AuthChallengeDisposition.cancelAuthenticationChallenge, nil)
//                                }
//
//                            } catch {
//                                // contents could not be loaded
//                                print("Not able to convert to data with the added pem files")
//                            }
//
//
//                        }
//                    }
//                }
//            }
//        }
//
//    }
//}

