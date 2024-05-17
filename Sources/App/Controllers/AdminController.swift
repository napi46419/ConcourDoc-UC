//
//  File.swift
//  
//
//  Created by Wadÿe on 30/04/2023.
//

import Vapor
import Fluent

/// A controller that holds most functionality for admins.
struct AdminController: TypedController {
    let type: UserType = .admin
    
    func boot(routes: RoutesBuilder) throws {
        let controller = routes.grouped("admin")
        controller.get(use: getAllUsers)
        controller.get(":userID", use: getUser)
        controller.post(use: createUser)
        controller.post(":userID", "delete", use: deleteUser)
        controller.put(":userID", "update", use: updateUser)
        controller.post("batchCreate", use: batchCreate)
    }
    
    func getAllUsers(request: Request) async throws -> View {
        let admin = try await UserAuthenticator.verifyIdentity(for: type, in: request)
        let database = request.db
        
        let admins = try await User.query(on: database)
            .filter(\.$type == .admin)
            .all()

        let employees = try await User.query(on: database)
            .filter(\.$type != .admin)
            .filter(\.$type != .candidate)
            .all()

        let candidates = try await User.query(on: database)
            .filter(\.$type == .candidate)
            .all()

        let context = Self.ViewContext(
            connectedAdmin: admin,
            admins: admins,
            employees: employees,
            candidates: candidates
        )
        
        return try await request.view.render("Admin", context)
    }
    
    func getUser(request: Request) async throws -> User {
        _ = try await UserAuthenticator.verifyIdentity(for: type, in: request)
        
        guard let userID: UUID = request.parameters.get("userID") else {
            throw Abort(.notFound, reason: "Could not get parameter: userID from request.")
        }
        
        guard let user = try? await User.find(userID, on: request.db) else {
            throw Abort(.notFound, reason: "Could not find the user in the database.")
        }
        
        return user
    }
    
    func createUser(request: Request) async throws -> Response {
        _ = try await UserAuthenticator.verifyIdentity(for: type, in: request)
        
        guard let createdUser = try? request.content.decode(User.CreateContext.self) else {
            throw Abort(.badRequest)
        }
        
        let user = try User(
            firstName: createdUser.firstName,
            lastName: createdUser.lastName,
            email: createdUser.email,
            passwordHash: Bcrypt.hash(createdUser.password),
            type: createdUser.type
        )
        
        try await user.save(on: request.db)
        return request.redirect(to: "/admin")
    }
    
    func updateUser(request: Request) async throws -> Response {
        _ = try await UserAuthenticator.verifyIdentity(for: type, in: request)
        
        guard let userID: UUID = request.parameters.get("userID") else {
            throw Abort(.notFound, reason: "Could not get parameter userID from request.")
        }
        
        guard let persistentUser = try? await User.find(userID, on: request.db) else {
            throw Abort(.notFound, reason: "Could not retrieve the user from the database.")
        }
        
        guard let user = try? request.content.decode(User.UpdateContext.self) else {
            throw Abort(.badRequest, reason: "Could not decode user from request.")
        }
        
        persistentUser.firstName = user.firstName
        persistentUser.lastName = user.lastName
        persistentUser.email = user.email
        persistentUser.type = user.type
        
        try await persistentUser.update(on: request.db)
        
        return request.redirect(to: "/admin")
    }
    
    func deleteUser(request: Request) async throws -> Response {
        _ = try await UserAuthenticator.verifyIdentity(for: type, in: request)
        
        guard let userID: UUID = request.parameters.get("userID") else {
            throw Abort(.badRequest, reason: "Could not get userID parameter from request.")
        }
        
        return try await User.deleteUser(userID, in: request) { request in
            return request.redirect(to: "/admin")
        }
    }
    
    func batchCreate(request: Request) async throws -> Response {
        _ = try await UserAuthenticator.verifyIdentity(for: type, in: request)
        
        let decoder = JSONDecoder()
        let usersToCreate = try request.content.decode([User.CSVCreateContext].self, using: decoder)
        print(usersToCreate)
        
        let users = try usersToCreate.map { userContext in
            return try User(context: userContext)
        }
        
        for user in users {
            try await user.save(on: request.db)
        }
        
        return request.redirect(to: "/admin")
    }
}

extension AdminController {
    struct ViewContext: Encodable {
        let connectedAdmin: User
        let admins: [User]
        let employees: [User]
        let candidates: [User]
    }
}
