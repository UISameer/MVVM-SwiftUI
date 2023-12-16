import Foundation

struct LoginResource {
    
    func authenticate(loginREquest: LoginRequest, completioHandler: @escaping(_ result: LoginResponse?) -> Void) {
        var urlRequest  = URLRequest(url: URL(string: "https://reqres.in/api/login")!)
        urlRequest.httpMethod = "post"
        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        urlRequest.httpBody = try? JSONEncoder().encode(loginREquest)
        
        HttpUtility.shared.postData(request: urlRequest, resultType: LoginResponse.self) { response in
            _ = completioHandler(response)
        }
    }
}
