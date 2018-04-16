class Resolvers::LoginUser < GraphQL::Function
  argument :email, !types.String
  argument :password, !types.String

  type do
    name 'LoginUser'

    field :token, !types.String
    field :user, Types::UserType
  end

  def call(obj, args, ctx)
    user = User.find_by(email: args[:email])
    return unless user
    return unless user.authenticate(args[:password])

    token = JWT.encode user, nil, 'none'

    OpenStruct.new({
      user: user,
      token: token
    })
  end
end
