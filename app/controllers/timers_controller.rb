class TimersController < ApplicationController
  def show
    @entry = Entry.find(params[:id])

    respond_to do |format|
      format.json do
        render json: {
          elapsed_time: @entry.elapsed_time_in_seconds,
          running: @entry.running?
        }
      end
    end
  end

  def update
    @entry = Entry.find(params[:id])

    @entry.start_timer if params[:start]
    @entry.stop_timer(params[:stop_time]) if params[:stop]
    @entry.save

    respond_to do |format|
      format.json do
        render json: {
          elapsed_time: @entry.elapsed_time_in_seconds
        }
      end
    end
  end
end
