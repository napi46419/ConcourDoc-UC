//
//  File.swift
//  
//
//  Created by Wadÿe on 06/05/2023.
//

import Vapor
import Fluent

struct CandidateController: TypedController {
    let type: UserType = .candidate
    
    func boot(routes: RoutesBuilder) throws {
        let controller = routes.grouped("candidate")
        controller.get(use: getData)
        // Operations...
    }
    
    func getData(request: Request) async throws -> View {
        let candidate = try await UserAuthenticator.verifyIdentity(for: type, in: request)
        
        guard let rawPosts = try? await Post.query(on: request.db).with(\.$user).all().reversed() else {
            throw Abort(.notFound, reason: "Could not get posts from the database.")
        }
        
        guard var rawResults = try? await Result.query(on: request.db).with(\.$candidate).sort(\.$value).all() else {
            throw Abort(.notFound, reason: "Could not get results from the database.")
        }
        
        let postsData = rawPosts.map { post in
            return Post.Data(from: post)
        }
        
        var resultsData: [Result.Data] = []
        
        rawResults.sort { $0.value > $1.value }
        
        for (index, rawResult) in rawResults.enumerated() {
            resultsData.append(Result.Data(from: rawResult, index: index))
        }
        
        return try await request.view.render("Candidate", CandidateController.ViewContext(candidate: candidate, posts: postsData, results: resultsData))
    }
}

extension CandidateController {
    struct ViewContext: Encodable {
        let candidate: User
        let posts: [Post.Data]
        let results: [Result.Data]
    }
}
