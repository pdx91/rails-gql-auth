Types::UserType = GraphQL::ObjectType.define do
  name 'User'
  global_id_field :id

  field :id, !types.ID
  field :email, !types.String

  field :firstName, !types.String do
    resolve ->(obj, _args, _ctx) {
      obj.first_name
    }
  end
  field :lastName, !types.String do
    resolve ->(obj, _args, _ctx) {
      obj.last_name
    }
  end
end
