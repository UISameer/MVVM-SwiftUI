import Foundation

struct LoginResponse: Decodable {
    let errorMessage: String?
    let data: LoginResponseData?
}

struct LoginResponseData: Decodable {
    let userName, email: String
    let userId: Int
}
