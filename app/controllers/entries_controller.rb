class EntriesController < ApplicationController
  before_action :set_entry, only: %i[ show edit update destroy ]

  def index
    @entries = Entry.all.order(created_at: :desc)
    @entry = Entry.new
  end

  def show
  end

  def new
    @entry = Entry.new
  end

  def edit
  end

  def create
    @entry = Entry.new(start: DateTime.now)

    if @entry.save
      respond_to do |format|
        format.html { redirect_to entries_path, notice: "Entry was successfully created." }
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @entry.update(entry_params)
      respond_to do |format|
        format.html { redirect_to entries_path, notice: "Entry was successfully updated." }
        format.turbo_stream
        format.json { render json: { entry: @entry, time_elapsed: @entry.time_elapsed }, status: :ok }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @entry.destroy!
    
    redirect_to entries_path, status: :see_other, notice: "Entry was successfully destroyed." 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_entry
      @entry = Entry.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def entry_params
      params.expect(entry: [ :project, :description, :start, :stop ])
    end
end
