class Resolvers::ViewerResolver < GraphQL::Function
  type Types::UserType

  def call(_, _, ctx)
    return unless ctx.to_h[:viewer]

    User.find(ctx.to_h[:viewer].first["user_id"])
  end
end
