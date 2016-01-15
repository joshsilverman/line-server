class LinesController < ApplicationController
  before_action :set_line, only: [:show]
  rescue_from ::ActiveRecord::RecordNotFound, with: :record_not_found

  # GET /lines/1
  # GET /lines/1.json
  def show
  end

  def record_not_found e
    render json: {error: e}, status: :not_found
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_line
      @line = Line.find(params[:id])
    end
end
