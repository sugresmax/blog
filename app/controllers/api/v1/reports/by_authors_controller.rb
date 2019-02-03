module Api::V1::Reports

  class ByAuthorsController < BaseController

    def create
      render json: { message: 'Report generation started' }
    end

  end

end
