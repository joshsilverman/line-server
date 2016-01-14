class LinesController < ApplicationController
  before_action :set_line, only: [:show]

  # GET /lines/1
  # GET /lines/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_line
      @line = Line.find(params[:id])
    end
end
