module Api::V1

  class BaseController < ActionController::API

    include UserAuthentication

  end

end
