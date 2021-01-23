//
//  BookingData.swift
//  UCD
//
//  Created by YutaroSakai on 2021/01/22.
//

import Foundation

/*  予約情報を格納する構造体及びグローバル変数  */
struct Booking {
    var hotelName: String
    var date: Date
    var numOfDay: Int
    var numOfPeople: Int
    
    init(hotelName: String, date: Date, numOfDay: Int, numOfPeople: Int) {
        self.hotelName = hotelName
        self.date = date
        self.numOfDay = numOfDay
        self.numOfPeople = numOfPeople
    }
}

var bookingList: [Booking] = []

/* ユーザの情報 */
var userName = "田仲 優希"

/* アプリの状態（ホテル利用中か利用外か） */
var isStayingInHotel = false
