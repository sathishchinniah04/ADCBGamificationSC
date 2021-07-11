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
    
    static func submitAnswer(gameId: String, event: EventsList, index: Int) {
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
            print("data is \(data)")
            print("Error is \(error)")
        }
        
    }
    
    static private func reqData(event: EventsList, index: Int) -> [String : Any]? {
        guard let questList = event.questionList else { return nil}
        
        var eventId = event.eventid ?? 0
        var ansList = [["questionid": "",
                       "optionId": ""]]
        ansList.removeAll()
        for item in questList {
            guard let opsList = item.predOptions else { return nil}
            var id = ""
            for ops in opsList {
                if !ops.isSelected  {
                    print("questionis not answered ")
                } else {
                    id = "\(ops.id ?? 0)"
                }
            }
            ansList.append(["questionid": "\(item.questionId ?? 0)",
                            "optionId": "\(id)"])
            print("no of question \(item)")
        }
        
        print("items to send is \(ansList)")
        let event = ["eventid": eventId, "answerList": ansList] as [String : Any]
        let submitPred = ["submitPredictions": event]
        
        return submitPred
    }
    
}
