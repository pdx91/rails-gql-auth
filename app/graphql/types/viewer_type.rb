Types::ViewerType = GraphQL::ObjectType.define do
  name "Viewer"

  field :user, Types::UserType
end
