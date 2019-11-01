module Api::V1
  class TokensController < ApiController
    def create
      @token = FirebaseDeviceToken.new(firebase_token_params)
      if @token.save
        render json: @token, status: :ok
      else
        render json: @token.errors, status: :unprocessable_entity
      end
    end

    private

    def firebase_token_params
      params.require(:firebase).permit(:token)
    end
  end
end
