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

    rsa_private = OpenSSL::PKey::RSA.generate 2048
    rsa_public = rsa_private.public_key

    token = JWT.encode user, rsa_private, 'RS256'

    OpenStruct.new({
      user: user,
      token: token
    })
  end
end
