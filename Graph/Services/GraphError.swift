//
//  GraphError.swift
//  Graph
//
//  Created by sarin on 04/03/2019.
//  Copyright © 2019 nikitasarin. All rights reserved.
//

import UIKit

public enum GraphError: Error, CaseIterable {
    case jsonEncodingFailed
    case invalidPointsCount
    case responseValidationFailure
    case invalidServerResponse
    case another
    
    public var localizedDescription: String {
        switch self {
        case .jsonEncodingFailed:
            return NSLocalizedString("При обработке ответа сервера что-то пошло не так",
                                     comment: "")
        case .invalidPointsCount:
            return NSLocalizedString("Кажется, вы ввели странное количество точек :) Пожалуйста, введите целое число больше 0",
                                     comment: "")
        case .invalidServerResponse:
            return NSLocalizedString("Хм.. Ответ сервера содержит невалидные данные, повторите ваш запрос позже",
                                     comment: "")
        case .responseValidationFailure:
            return NSLocalizedString("Хм.. Сервер в данный момент недоступен, повторите ваш запрос позже",
                                     comment: "")
        case .another:
            return NSLocalizedString("Произошла некоторая ошибка... Но мы уже работаем над ее исправлением!",
                                     comment: "")
        }
    }
}
