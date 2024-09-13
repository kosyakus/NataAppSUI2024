//
//  DeepLinkAppViewModel.swift
//  NataAppSUI2024
//
//  Created by Natalia Sinitsyna on 12.09.2024.
//

import Foundation
import SwiftUI

class DeepLinkAppViewModel: ObservableObject {
    
    @Published var currentTab: ScreenTab = .navigation
    @Published var myDeepLink: String?
    
    func checkDeepLink(url: URL) -> Bool {
        guard let deepLinkComponent = URLComponents(url: url, resolvingAgainstBaseURL: true)?.host else {
            return false
        }
        print(deepLinkComponent)
//        switch deepLinkComponent {
//        case ScreenTab.full.:
//            currentTab = .full
//        case ScreenTab.navigation.rawValue:
//            currentTab = .navigation
//        case ScreenTab.news.rawValue:
//            currentTab = .news
//        default:
//            return self.checkInternalDeepLink(host: deepLinkComponent)
//        }
        return true
    }
    
    func checkInternalDeepLink(host: String) -> Bool {
        if let index = DataSource.data.firstIndex(where: { myDeepLink in
            return myDeepLink.id == host
        }) {
            currentTab = .navigation
            /// Для перехода на конкретную вкладку из списка
            myDeepLink = DataSource.data[index].id
        }
        return true
    }
}
