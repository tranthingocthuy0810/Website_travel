class Admin::ToursController < ApplicationController
  before_action :set_tour, only: %i[show edit update destroy]
  
  # GET /posts or /posts.json
  def index
    @tours = policy_scope(Tour)
  end

  # GET /posts/1 or /posts/1.json
  def show
    @tour = Tour.find(params[:id])
    authorize @tour
  end

  # GET /posts/new
  def new
    @tour = Tour.new
    authorize @tour
  end

  # GET /posts/1/edit
  def edit
    authorize @tour
  end

  # POST /posts or /posts.json
  def create
    @tour = Tour.new(tour_params)
    authorize @tour

    respond_to do |format|
      if @tour.save
        format.html { redirect_to admin_tour_url(@tour), notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @tour }
      else
        puts "Post Errors: #{@tour.errors.full_messages}"
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @tour.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    authorize @tour
    respond_to do |format|
      if @tour.update(tour_params)
        format.html { redirect_to admin_tour_url(@tour), notice: "Tour was successfully updated." }
        format.json { render :show, status: :ok, location: @tour }
      else
        puts "Post Errors: #{@tour.errors.full_messages}"
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @tour.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tour/1 or /tour/1.json
  def destroy
    @tour.destroy
    authorize @tour

    respond_to do |format|
      format.html { redirect_to admin_tours_path, notice: "Tour was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tour
      @tour = Tour.find_by(id: params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tour_params
      params.require(:tour).permit(:title, :description, :status, :image)
    end
end
