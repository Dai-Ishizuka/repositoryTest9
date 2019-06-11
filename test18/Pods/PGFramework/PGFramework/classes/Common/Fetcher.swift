//
//  Fetcher.swift
//  Sam
//
//  Created by Hiroki Umatani on 2018/08/21.
//  Copyright © 2018 Engineer. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

public struct Const {
    static let HOST: String = "https://"
    static let TIME_INTERVAL: TimeInterval = 10.0
}

public class ApiManager {
    public static let sharedInstance: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        configuration.timeoutIntervalForRequest = Const.TIME_INTERVAL
        return SessionManager(configuration: configuration)
    }()
}

public class Fetcher: NSObject {
    // MARK: - Property
    public var url: String!

    public func request(path: String?,
                 method: HTTPMethod,
                 parameters: [String: Any]?,
                 success: @escaping ([String: Any]?) -> Void,
                 failed: @escaping (Error) -> Void) {
        let manager = ApiManager.sharedInstance
        setHost()
        setPath(path: path)
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"]

        manager
            .request(self.url,
                     method: method,
                     parameters: parameters,
                     encoding: JSONEncoding.default,
                     headers: headers)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    success(value as? [String: Any])
                case .failure(let error):
                    failed(error)
                }
        }
    }

    public func uploadImage(path: String?,
                     data: Data,
                     success: @escaping ([String: Any]?) -> Void,
                     failed: @escaping (Error) -> Void) {
        setHost()
        setPath(path: path)

        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(data, withName: "image", fileName: randomString(length: 12)+".jpg", mimeType: "image/jpg")

        },
                         to: self.url ,
                         method: .put,
                         encodingCompletion: { encodingResult in
                            switch encodingResult {
                            case .success(let upload, _, _):
                                upload.responseJSON { res in
                                    switch res.result {
                                    case .success(let value):
                                        success(value as? [String: Any])
                                    case .failure(_):
                                        break
                                    }
                                }
                            case .failure(let error):
                                failed(error)
                            }
        })
    }

    public func downloadImage(imageView: UIImageView, url: String) {
        if let _url = URL(string: url) {
            imageView.af_setImage(withURL: _url)
        }
    }

    public func setHost() {
        url = Const.HOST
    }

    public func setPath(path: String?) {
        if let path = path {
            url = url + path
        }
    }
}
