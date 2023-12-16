import Foundation

struct LoginDataModel {
    var userEmail: String = String()
    var userPassword: String = String()
    var errorMessage: String = String()
    var navigate: Bool = false
    var isPresentingErorAlert: Bool = false
}

class LoginViewModel: ObservableObject {
    @Published var loginDataModel: LoginDataModel = LoginDataModel()
    private let loginValidation = LoginValidation()
    private let loginResource = LoginResource()
    
    func validateUserInputs() -> Bool {
        let result = loginValidation.validateUserInputs(userEmail: loginDataModel.userEmail, userPassword: loginDataModel.userPassword)
        if(result.success == false) {
            loginDataModel.errorMessage = result.errorMessage ?? "Error Occurred"
            loginDataModel.isPresentingErorAlert = true
        }
        return true
    }
    
    func authenticateUser() {
        
        let loginRequest = LoginRequest(userEmail: loginDataModel.userEmail, userPassword: loginDataModel.userPassword)
        loginResource.authenticate(loginREquest: loginRequest) { response in
            
            DispatchQueue.main.async {
                if(response?.errorMessage == nil) {
                    self.loginDataModel.navigate = true
                } else {
                    self.loginDataModel.errorMessage = response?.errorMessage ?? "error occured"
                    self.loginDataModel.isPresentingErorAlert = true
                }
            }
            
        }
    }
}
