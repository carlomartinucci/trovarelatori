class API::V1::ReaderController < API::V1::BaseController

  # GET 'api/v1/reader/:theme/:argument'
  # {"cannabis":
  #   {"mediche":
  #     [
  #       {
  #         "theorem_id": 1,
  #         "claim_id": 1,
  #         "claim_value": "Claim"
  #       }
  #     ]
  #   }
  # }
  def get_argument
    theme = Theme.find_by name: params[:theme]
    if theme.nil?
      render json: {error: "No valid theme provided"}.to_json
      return
    end
    p "theme: #{theme.name}"
    argument = theme.arguments.find_by name: params[:argument]
    if argument.nil?
      render json: {error: "No valid argument provided"}.to_json
      return
    end
    p "argument: #{argument.name}"
    json = {
      theme.name => {
        argument.name => argument.theorems.map(&:export)
      }
    }.to_json
    render json: json
  end

end