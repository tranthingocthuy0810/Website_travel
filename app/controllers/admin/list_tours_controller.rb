class Admin::ListToursController < ApplicationController
  before_action :set_list_tour, only: %i[ show edit update destroy ]

  # GET /list_tours or /list_tours.json
  def index
    @list_tours = policy_scope(ListTour)
  end

  # GET /list_tours/1 or /list_tours/1.json
  def show
    authorize @tour
  end

  # GET /list_tours/new
  def new
    authorize @tour
    @list_tour = ListTour.new
  end

  # GET /list_tours/1/edit
  def edit
    authorize @tour
  end

  # POST /list_tours or /list_tours.json
  def create
    authorize @tour
    @list_tour = ListTour.new(list_tour_params)

    respond_to do |format|
      if @list_tour.save
        format.html { redirect_to admin_list_tour_url(@list_tour), notice: "List tour was successfully created." }
        format.json { render :show, status: :created, location: @list_tour }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @list_tour.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /list_tours/1 or /list_tours/1.json
  def update
    authorize @tour
    respond_to do |format|
      if @list_tour.update(list_tour_params)
        format.html { redirect_to admin_list_tour_url(@list_tour), notice: "List tour was successfully updated." }
        format.json { render :show, status: :ok, location: @list_tour }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @list_tour.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /list_tours/1 or /list_tours/1.json
  def destroy
    @list_tour.destroy
    authorize @tour
    respond_to do |format|
      format.html { redirect_to admin_list_tours_url, notice: "List tour was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_list_tour
      @list_tour = ListTour.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def list_tour_params
      params.require(:list_tour).permit(:name, :category_id)
    end
end
