class TimersController < ApplicationController
  def show
    @entry = Entry.find(params[:id])

    respond_to do |format|
      format.json do
        render json: {
          elapsed_time: @entry.elapsed_time_in_seconds
        }
      end
    end
  end

  def update
    @entry = Entry.find(params[:id])

    @entry.timers << { start: DateTime.now } if params[:start]
    @entry.timers << { stop: DateTime.now } if params[:stop]
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
