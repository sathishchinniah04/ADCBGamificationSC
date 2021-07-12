//
//  PredictViewModel.swift
//  ADCBGamification
//
//  Created by SKY on 09/07/21.
//

import Foundation

class PredictViewModel {
    static func getPredictDetail(gameId: String, complition:((PredictGame)->Void)?) {
        let urlStr = Constants.predictgameDetail+"\(gameId)/1"
        guard let url = URL(string: urlStr) else {print("Inavlid url getPredictDetail"); return }
        var urlReq = URLRequest(url: url)
        urlReq.setValue(gameId, forHTTPHeaderField: "gameId")
        urlReq.setValue("1", forHTTPHeaderField: "milestoneId")
        urlReq.setValue(Utility.getRandonNo(), forHTTPHeaderField: "requestId")
        urlReq.setValue(StoreManager.shared.msisdn, forHTTPHeaderField: "msisdn")
        urlReq.setValue(StoreManager.shared.msisdn, forHTTPHeaderField: "customerId")
        urlReq.setValue(StoreManager.shared.language, forHTTPHeaderField: "language")
        
        NetworkManager.getRequest(struct: PredictGame.self, url: urlStr, urlReq: urlReq) { (data, error) in
            if let data = data {
                complition?(data)
            } else {
                print("Error found \(error)")
            }
        }
    }
    
    static func submitAnswer(gameId: String, event: EventsList, index: Int, complition: (()->Void)?) {
        let urlStr = Constants.predictgameDetail+"\(gameId)/1"
        guard let url = URL(string: urlStr) else {print("Inavlid url getPredictDetail"); return }
        var urlReq = URLRequest(url: url)
//        urlReq.setValue(gameId, forHTTPHeaderField: "gameId")
//        urlReq.setValue("1", forHTTPHeaderField: "milestoneId")
        urlReq.setValue(Utility.getRandonNo(), forHTTPHeaderField: "requestId")
        urlReq.setValue(StoreManager.shared.msisdn, forHTTPHeaderField: "msisdn")
        urlReq.setValue(StoreManager.shared.msisdn, forHTTPHeaderField: "customerId")
        urlReq.setValue(StoreManager.shared.language, forHTTPHeaderField: "language")
        NetworkManager.postRequest(struct: GameList.self, url: urlStr, urlReq: urlReq, requestData: reqData(event: event, index: index)!) { (data, error) in
            if let dat = data {
             complition?()
            }
            print("data is \(data)")
            print("Error is \(error)")
        }
//        reqData(event: event, index: index)
    }
    
    static private func reqData(event: EventsList, index: Int) -> [String : Any]? {
        guard let questList = event.questionList else { return nil}
        
        var eventId = event.eventid ?? 0
        var ansList = [["questionid": "",
                       "optionId": ""]]
        ansList.removeAll()
        var answeredQ: [PredOption]?
        
        var count: Int = 0
        for item in questList {
            guard let opsList = item.predOptions else { return nil}
            var id = ""
            answeredQ = opsList.filter({$0.isSelected == true})
            
            for ops in opsList {
                if !ops.isSelected  {

                } else {
                    count += 1
                    id = "\(ops.id ?? 0)"
                }
            }
            ansList.append(["questionid": "\(item.questionId ?? 0)",
                            "optionId": "\(id)"])
         
        }
        print("answered question \(count)")
        print("answered quet is \(answeredQ?.count)")
        let jsonData = try? JSONSerialization.data(withJSONObject: ansList, options: [])
        let eventJson = String(data: jsonData!, encoding: .utf8)
    //    print("items to send is \(ansList)")
        let ansListStr = ["eventid": eventId, "answerList": eventJson!] as [String : Any]
        
        
//        print("ansListStr data is \(ansListStr)")

        let submitPred = ["submitPredictions": ansListStr]
  //      print("submitPred \(submitPred)")
        if count == questList.count {
            print("Answered all question")
        } else {
            print("All questions are not answered")
        }
        return submitPred
    }
    
    static func checkAllQuestionAnswered(event: EventsList, index: Int)-> Bool {
        guard let questList = event.questionList else { return false}
        var count: Int = 0
        for item in questList {
            guard let opsList = item.predOptions else { return false}
            for ops in opsList {
                if !ops.isSelected  {

                } else {
                    count += 1
                }
            }
        }
        if count == questList.count {
            print("Answered all question")
            return true
        } else {
            print("All questions are not answered")
            return false
        }
    }
    
}
