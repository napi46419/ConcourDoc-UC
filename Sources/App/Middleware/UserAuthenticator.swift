//
//  File.swift
//  
//
//  Created by Wadÿe on 05/05/2023.
//

import Vapor
import Fluent

struct UserAuthenticator {
    /// Renders the login page (Leaf view).
    static func renderLoginPage(_ request: Request) async throws -> View {
        try await request.view.render("Login")
    }
    
    /// Logs in the user.
    static func login(_ request: Request) async throws -> Response {
        let user = try request.content.decode(User.AuthenticationContext.self)
        
        guard let persistentUser = try? await User.query(on: request.db)
            .filter(\.$email == user.email)
            .first()
        else {
            print("Could not find the user by email.")
            return request.redirect(to: "/login")
        }
        
        guard try Bcrypt.verify(user.password, created: persistentUser.passwordHash) else {
            return request.redirect(to: "/login")
        }
        
        let session = request.session
        session.data["user_id"] = persistentUser.id!.uuidString
        session.data["first_name"] = persistentUser.firstName
        session.data["last_name"] = persistentUser.lastName
        session.data["type"] = persistentUser.type.rawValue
        
        switch persistentUser.type {
        case .admin:
            return request.redirect(to: "/admin")
        case .cfdPresident:
            return request.redirect(to: "/cfd-president/copies/marked")
        case .dean:
            return request.redirect(to: "/dean")
        case .teacher:
            return request.redirect(to: "/teacher")
        case .candidate:
            return request.redirect(to: "/candidate")
        }
    }
    
    /// Logs out the authenticated user and destroys their session.
    static func logout(_ request: Request) async throws -> Response {
        request.session.destroy()
        let response = request.redirect(to: "/login")
        response.headers.cacheControl = .init(noCache: true)
        return response
    }
    
    /// Checks whether the session is still active
    static func verifyIdentity(for type: UserType, in request: Request) async throws -> User {
        let session = request.session
        guard let userIDString = session.data["user_id"], let id = UUID(userIDString) else {
            throw Abort.redirect(to: "/login")
        }
        guard let user = try? await User.find(id, on: request.db) else {
            throw Abort(.notFound)
        }
        guard user.type == type else {
            throw Abort.redirect(to: "/unauthorised")
        }
        return user
    }
    
    static func renderUnauthorisedPage(_ request: Request) async throws -> View {
        try await request.view.render("Unauthorised")
    }
}
