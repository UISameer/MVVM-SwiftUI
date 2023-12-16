import SwiftUI

struct ContentView: View {
    
    @ObservedObject var loginViewModel = LoginViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("useremail", text: $loginViewModel.loginDataModel.userEmail)
                    .keyboardType(.emailAddress)
                SecureField("password", text: $loginViewModel.loginDataModel.userPassword)
                NavigationLink(
                    destination: HomeView(),
                    isActive: $loginViewModel.loginDataModel.navigate,
                    label: {
                        Button(action: {
                            if(loginViewModel.validateUserInputs()) {
                                loginViewModel.authenticateUser()
                            }
                        }, label: {
                            Text("Login")
                        }).alert(isPresented: $loginViewModel.loginDataModel.isPresentingErorAlert, content: {
                            Alert(title: Text("Alert"), message: Text(loginViewModel.loginDataModel
                                .errorMessage), dismissButton: .cancel(Text("Ok")))
                        })
                    }
                )
            }
            .padding()
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .navigationTitle("Login")
        }
    }
}

#Preview {
    ContentView()
}
