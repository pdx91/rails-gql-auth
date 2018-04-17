class GraphqlController < ApplicationController
  skip_before_action :verify_authenticity_token

  def execute
    variables = ensure_hash(params[:variables])
    query = params[:query]
    operation_name = params[:operationName]
    context = {
      viewer: viewer
    }
    result = RailsGqlAuthSchema.execute(query, variables: variables, context: context, operation_name: operation_name)
    render json: result
  end

  private

  # def warden
  #   request.env['warden']
  # end

  def viewer
    return nil if request.headers['Authorization'].blank?

    token = request.headers['Authorization']
    # JWT.decode token, nil, false
    JWT.decode(
      token,
      Rails.application.credentials.secret_key_base,
      true,
      { algorithm: 'HS256' }
    )
  end

  # Handle form data, JSON body, or a blank value
  def ensure_hash(ambiguous_param)
    case ambiguous_param
    when String
      if ambiguous_param.present?
        ensure_hash(JSON.parse(ambiguous_param))
      else
        {}
      end
    when Hash, ActionController::Parameters
      ambiguous_param
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{ambiguous_param}"
    end
  end
end
