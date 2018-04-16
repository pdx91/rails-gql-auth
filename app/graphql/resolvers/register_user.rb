class Resolvers::RegisterUser < GraphQL::Function
  argument :email, !types.String
  argument :password, !types.String
  argument :firstName, !types.String
  argument :lastName, !types.String

  type Types::UserType

  def call(_obj, args, _ctx)
    User.create!(
      email: args[:email],
      password: args[:password],
      first_name: args[:firstName],
      last_name: args[:lastName]
    )
  end
end
