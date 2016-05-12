class TokensController < InheritedResources::Base

  private

    def token_params
      params.require(:token).permit(:access_token)
    end
end

