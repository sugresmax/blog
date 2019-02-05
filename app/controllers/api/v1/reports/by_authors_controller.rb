module Api::V1::Reports

  class ByAuthorsController < Api::V1::BaseController

    def create
      render json: { message: 'Report generation started' }
      ReportWorker.perform_async(params[:start_date], params[:end_date], params[:email])
    end

  end

end
