//
//  File.swift
//  
//
//  Created by Wadÿe on 08/05/2023.
//

import Vapor
import Fluent

struct DeanController: TypedController {
    let type: UserType = .dean
    
    func boot(routes: RoutesBuilder) throws {
        let controller = routes.grouped("dean")
        controller.get(use: getPosts)
        controller.get("secret-codes", use: getSecretCodes)
        controller.get("assign-code", use: getAssignCodesView)
        controller.get("new-post", use: renderNewPostView)
        controller.post("new-post", use: createPost)
        controller.post("assign-code", ":candidateID", use: assignSecretCode)
        controller.post(":postID", "delete", use: deletePost)
    }
    
    func getPosts(request: Request) async throws -> View {
        let dean = try await UserAuthenticator.verifyIdentity(for: type, in: request)
        
        let rawPosts = try await Post.query(on: request.db)
            .with(\.$user)
            .filter(\.$user.$id == dean.id!)
            .sort(\.$postedAt)
            .all()
            .reversed()
        
        let posts = rawPosts.map { post in
            return Post.Data(from: post)
        }
        
        let context = DeanController.ViewContext.Posts(dean: dean, posts: posts)
        
        return try await request.view.render("my_post", context)
        
    }
    
    func getCandidates(request: Request) async throws -> [User] {
         _ = try await UserAuthenticator.verifyIdentity(for: type, in: request)
        
        guard let users = try? await User.query(on: request.db)
            .filter(\.$type == .candidate)
            .all() else {
            throw Abort(.notFound, reason: "Could not retrieve candidates form database.")
        }
        return users
    }
    
    func renderNewPostView(request: Request) async throws -> View {
        let dean = try await UserAuthenticator.verifyIdentity(for: type, in: request)
        return try await request.view.render("new_post", DeanController.ViewContext.NewPost(dean: dean))
    }
    
    func createPost(request: Request) async throws -> Response {
        let dean = try await UserAuthenticator.verifyIdentity(for: type, in: request)
        print("entering...")
        let postData = try request.content.decode(Post.CreateContext.self)
        let post = Post(userID: dean.id!, title: postData.title, content: postData.content, link: postData.link)
        try await post.save(on: request.db)
        return request.redirect(to: "/dean")
    }
    
    func getSecretCodes(request: Request) async throws -> View {
        let dean = try await UserAuthenticator.verifyIdentity(for: type, in: request)
        
        let rawSecretCodes = try await SecretCode.query(on: request.db)
            .with(\.$candidate)
            .all()
        
        let secretCodes = rawSecretCodes.map { return SecretCode.Data(from: $0) }
        
        let context = DeanController.ViewContext.SecretCodes(dean: dean, secretCodes: secretCodes)
        
        return try await request.view.render("secret_code", context)
    }
    
    func getAssignCodesView(request: Request) async throws -> View {
        let dean = try await UserAuthenticator.verifyIdentity(for: type, in: request)
        
        let database = request.db
        
        var candidates = try await User.query(on: database)
            .filter(\.$type == .candidate)
            .all()
        
        let candidatesAlreadyHavingSecretCodesIDs = try await User.query(on: database)
            .join(SecretCode.self, on: \User.$id == \SecretCode.$candidate.$id)
            .all()
            .map { $0.id }
        
        candidates.removeAll { candidatesAlreadyHavingSecretCodesIDs.contains($0.id) }
        
        print(candidates)
        
        let context = DeanController.ViewContext.AssignSecretCodes(dean: dean, candidates: candidates)
        
        return try await request.view.render("generate_code", context)
    }
    
    func assignSecretCode(request: Request) async throws -> Response {
         _ = try await UserAuthenticator.verifyIdentity(for: type, in: request)
        
        guard let candidateID: UUID = request.parameters.get("candidateID") else {
            throw Abort(.badRequest, reason: "Could not get parameter candidateID from request.")
        }
        
        let existingCodesArray = try await SecretCode.query(on: request.db)
            .all()
            .map { $0.content }
        var existingCodes: Set<String> = Set(existingCodesArray)
        
        let content = try SWCodeGenerator(length: 4).generate(considering: &existingCodes)
        
        let secretCode = SecretCode(candidateID: candidateID, content: content)
        try await secretCode.save(on: request.db)
        
        return request.redirect(to: "/dean/assign-code")
    }
    
    func deletePost(request: Request) async throws -> Response {
        guard let postID: UUID = request.parameters.get("postID") else {
            throw Abort(.badRequest, reason: "Could not get parameter postID from request.")
        }
        
        try await Post.query(on: request.db)
            .filter(\.$id == postID)
            .first()!
            .delete(on: request.db)
        
        return request.redirect(to: "/dean")
    }
}

extension DeanController {
    enum ViewContext {
        struct Posts: Encodable {
            let dean: User
            let posts: [Post.Data]
        }
        
        struct SecretCodes: Encodable {
            let dean: User
            let secretCodes: [SecretCode.Data]
        }
        
        struct NewPost: Encodable {
            let dean: User
        }
        
        struct AssignSecretCodes: Encodable {
            let dean: User
            let candidates: [User]
        }
    }
}
