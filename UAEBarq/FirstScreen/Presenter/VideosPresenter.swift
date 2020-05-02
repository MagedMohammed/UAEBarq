//
//  VideosPresenter.swift
//  UAEBarq
//
//  Created by Maged Omar on 5/2/20.
//  Copyright © 2020 Maged Omar. All rights reserved.
//

import Foundation

protocol VideosPresenterProtocol: class {
    func getAllVideos()
}

class VideosPresenter: VideosPresenterProtocol{
    
    //    MARK:- Properties
    var view: VideosViewProtocol!
    
    
    //    MARK:- Init
    init(view:VideosViewProtocol){
        self.view = view
    }
    
    
    //    MARK:- Method
    func getAllVideos() {
        Request.getData(routerCase: AppRouter.GetAllVideos) {[weak self] (data:VideosModel?, error) in
            guard let self = self else{return}
            if let data = data, error == nil{
                if let isError = data.error, !isError{
                    if let videos = data.videos {
                        self.view.videosData(data:videos)
                    }else{
                        let errorMessage = "Videos List is empty"
                        self.view.showAlert(title:"Error", message: errorMessage)
                    }
                }else{
                    let errorMessage = data.message ?? ""
                    self.view.showAlert(title:"Error", message: errorMessage )
                }
            }
        }
    }
}
