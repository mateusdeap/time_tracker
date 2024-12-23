class TimersController < ApplicationController
  def update
    @entry = Entry.find(params[:id])

    @entry.timers << { start: DateTime.now } if params[:start]
    @entry.timers << { stop: DateTime.now } if params[:stop]
    @entry.save

    respond_to do |format|
      format.json { render json: {
        elapsed_time: formatted_elapsed_time(@entry)
      } }
    end
  end

  private

  def formatted_elapsed_time(entry)
    return "Timer running..." if entry.running?

    formatted = []
    total_seconds = entry.elapsed_time_in_seconds
    hours = total_seconds / 3600
    minutes = (total_seconds % 3600) / 60
    seconds = total_seconds % 60

    formatted << formatted_time(hours)
    formatted << formatted_time(minutes)
    formatted << formatted_time(seconds)

    formatted.join(":")
  end

  def formatted_time(time)
    return "00" if time == 0

    sprintf "%02d", time
  end
end
