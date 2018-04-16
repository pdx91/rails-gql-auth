module Mutations::UserMutations
  Register = GraphQL::Relay::Mutation.define do
    name 'Register'

    input_field :email, !types.String
    input_field :password, !types.String
    input_field :firstName, !types.String
    input_field :lastName, !types.String

    # return_field :user, Types::UserType

    resolve ->(_obj, inputs, ctx) {
      if User.find_by(email: inputs[:email])
        # GraphQL::ExecutionError.new("Email already taken")
        OpenStruct.new({
          errors: "Email taken!"
        })
      else
        user = User.new(
          email: inputs[:email],
          password: inputs[:password],
          first_name: inputs[:firstName],
          last_name: inputs[:lastName]
        )

        if user.save
          ctx[:warden].set_user(user)
          {user: user}
        else
          {errors: user.errors}
        end
      end
    }
  end
end
