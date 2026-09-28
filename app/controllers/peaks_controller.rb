class PeaksController < ApplicationController
  before_action :set_peak, only: %i[ show edit update destroy ]

  def index
    @peaks = Peak.order(altitude: :desc)
  end

  def show
  end

  def new
    @peak = Peak.new
  end

  def edit
  end

  def create
    @peak = Peak.new(peak_params)

    if @peak.save
      redirect_to @peak, notice: "Gipfel eingetragen."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @peak.update(peak_params)
      redirect_to @peak, notice: "Gipfel aktualisiert.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @peak.destroy!
    redirect_to peaks_path, notice: "Gipfel gelöscht.", status: :see_other
  end

  private

  def set_peak
    @peak = Peak.find(params.expect(:id))
  end

  def peak_params
    params.expect(peak: [ :name, :altitude ])
  end
end
