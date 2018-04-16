Types::MutationType = GraphQL::ObjectType.define do
  name "Mutation"

  field :registerUser, function: Resolvers::RegisterUser.new
  field :loginUser, function: Resolvers::LoginUser.new
end
