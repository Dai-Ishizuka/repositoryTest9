//
//  ViewController.swift
//  test17
//
//  Created by 石塚大 on 2019/06/11.
//  Copyright © 2019 石塚大. All rights reserved.
//

import UIKit
import PGFramework

// MARK: - Property
class ViewController {
    // Path
    fileprivate static let PATH: String = "users"
    // parameters
    var id: Int?
    var name: String?
}
struct ViewControllerRequest {
    // parameters
    var id: Int?
    var name: String?
}
// MARK: - Parse
extension ViewController {
    static func parse(data: [String: Any]) -> ViewController {
        let model = ViewController()
        model.id = data["id"] as? Int
        model.name = data["name"] as? String
        return model
    }
    static func setParameter(request: ViewControllerRequest) -> [String: Any] {
        var parameter: [String: Any] = [:]
        if let id = request.id {
            parameter["id"] = id
        }
        return parameter
    }
}
// MARK: - Reads
extension ViewController {
    static func reads(success:@escaping (ListModel<ViewController>) -> Void) {
        let fetcher = Fetcher()
        fetcher.request(path: PATH + "?format=json",
                        method: .get,
                        parameters: nil,
                        success: { response in
                            var listModel = ListModel<ViewController>()
                            if let response = response,
                                let count = response["count"] {
                                listModel.max_count = count as! Int
                            }
                            if let response = response,
                                let _ = response["next"] {
                                listModel.loadMore = true
                            } else {
                                listModel.loadMore = false
                            }
                            if let response = response,
                                let results = response["results"] as? [[String: AnyObject]] {
                                let _ = results.map { data in
                                    let model: ViewController = parse(data: data)
                                    listModel.insert(model)
                                }
                            }
                            success(listModel)
        },
                        failed: { error in
        })
    }
}
// MARK: - ReadMore
extension ViewController {
    static func readMore(listModel: ListModel<ViewController>, success:@escaping (ListModel<ViewController>) -> Void) {
        let fetcher = Fetcher()
        fetcher.request(path: PATH + "?format=json" + "&offset=" + String(describing: listModel.contents.count),
                        method: .get,
                        parameters: nil,
                        success: { response in
                            var listModel = listModel
                            if let response = response,
                                let count = response["count"] {
                                listModel.max_count = count as! Int
                            }
                            if let response = response,
                                let _ = response["next"] {
                                listModel.loadMore = true
                            } else {
                                listModel.loadMore = false
                            }
                            if let response = response,
                                let results = response["results"] as? [[String: AnyObject]] {
                                let _ = results.map { data in
                                    let model: ViewController = parse(data: data)
                                    listModel.insert(model)
                                }
                            }
                            success(listModel)
        },
                        failed: { error in
        })
    }
}
// MARK: - ReadAt
extension ViewController {
    static func readAt(request: ViewControllerRequest, success:@escaping (ListModel<ViewController>) -> Void) {
        let fetcher = Fetcher()
        guard let id = request.id else {
            return
        }
        fetcher.request(path: PATH + String(describing: id) + "/?format=json",
                        method: .get,
                        parameters: nil,
                        success: { response in
                            var listModel = ListModel<ViewController>()
                            if let response = response,
                                let count = response["count"] {
                                listModel.max_count = count as! Int
                            }
                            if let response = response,
                                let _ = response["next"] {
                                listModel.loadMore = true
                            } else {
                                listModel.loadMore = false
                            }
                            if let data = response {
                                let model: ViewController = parse(data: data)
                                listModel.insert(model)
                            }
                            success(listModel)
        },
                        failed: { error in
        })
    }
}
// MARK: - Create
extension ViewController {
    static func create(request: ViewControllerRequest,
                       success:@escaping (ListModel<ViewController>) -> Void) {
        let fetcher = Fetcher()
        var param = setParameter(request: request)
        if let _ = param["id"] {
            param.remove(at: param.index(forKey: "id")!)
        }
        
        fetcher.request(path: PATH + "?format=json",
                        method: .post,
                        parameters: param,
                        success: { response in
                            var listModel = ListModel<ViewController>()
                            
                            if let response = response,
                                let count = response["count"] {
                                listModel.max_count = count as! Int
                            }
                            
                            if let response = response,
                                let _ = response["next"] {
                                listModel.loadMore = true
                            } else {
                                listModel.loadMore = false
                            }
                            
                            if let data = response {
                                let model: ViewController = parse(data: data)
                                listModel.insert(model)
                            }
                            success(listModel)
        },
                        failed: { error in
                            
        })
        
    }
}


// MARK: - Update
extension ViewController {
    static func update(request: ViewControllerRequest,
                       success:@escaping (ListModel<ViewController>) -> Void) {
        let fetcher = Fetcher()
        guard let id = request.id else {
            return
        }
        var param = setParameter(request: request)
        if let _ = param["id"] {
            param.remove(at: param.index(forKey: "id")!)
        }
        fetcher.request(path: PATH + String(describing: id) + "/?format=json",
                        method: .put,
                        parameters: param,
                        success: { response in
                            var listModel = ListModel<ViewController>()
                            
                            if let response = response,
                                let count = response["count"] {
                                listModel.max_count = count as! Int
                            }
                            
                            if let response = response,
                                let _ = response["next"] {
                                listModel.loadMore = true
                            } else {
                                listModel.loadMore = false
                            }
                            
                            if let data = response {
                                let model: ViewController = parse(data: data)
                                listModel.insert(model)
                            }
                            success(listModel)
        },
                        failed: { error in
        })
        
    }
}

// MARK: - Delete
extension ViewController {
    static func delete(request: ViewControllerRequest, success:@escaping () -> Void) {
        let fetcher = Fetcher()
        guard let id = request.id else {
            return
        }
        fetcher.request(path: PATH + String(describing: id) + "/?format=json",
                        method: .delete,
                        parameters: nil,
                        success: { response in
                            success()
        },
                        failed: { error in
        })
    }
}

