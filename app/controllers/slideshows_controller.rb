class SlideshowsController < ApplicationController
  before_action :set_slideshow, only: [:show, :edit, :update, :destroy,         :show_slide, :update_slide_order]

  # GET /slideshows
  # GET /slideshows.json
  def index
    @slideshows = Slideshow.all
  end

  # GET /slideshows/1
  # GET /slideshows/1.json
  def show
    session[:slideshow] = @slideshow
    session[:slide_index] = 0
    @slide = @slideshow.slides[0]
  end

  # GET /slideshows/new
  def new
    @slideshow = Slideshow.new
  end

  # GET /slideshows/1/edit
  def edit
     session[:slideshow]= @slideshow
     @photos_unused = unused_photos(@slideshow)
  end

  # POST /slideshows
  # POST /slideshows.json
  def create
    @slideshow = Slideshow.new(slideshow_params)

    respond_to do |format|
      if @slideshow.save
        format.html { redirect_to @slideshow, notice: 'Slideshow was successfully created.' }
        format.json { render :show, status: :created, location: @slideshow }
      else
        format.html { render :new }
        format.json { render json: @slideshow.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /slideshows/1
  # PATCH/PUT /slideshows/1.json
  def update
    respond_to do |format|
      if @slideshow.update(slideshow_params)
        format.html { redirect_to @slideshow, notice: 'Slideshow was successfully updated.' }
        format.json { render :show, status: :ok, location: @slideshow }
      else
        format.html { render :edit }
        format.json { render json: @slideshow.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /slideshows/1
  # DELETE /slideshows/1.json
  def destroy
    @slideshow.destroy
    respond_to do |format|
      format.html { redirect_to slideshows_url, notice: 'Slideshow was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # GET "/slideshows/show_slide" -> In charge of showing each slide with photo.
  def show_slide
    @slide = @slideshow.slides[session[:slide_index]]
    session[:slide_index] += 1
    if @slide.nil?
      session[:slide_index] = 0
      @slide = @slideshow.slides[0]
    end
    render partial: "show_slides"
  end

  def update_slide_order
    params[:order].each_value do |pair_id_pos|
      Slide.update(pair_id_pos["id"].to_i,position:pair_id_pos["position"].to_i)
    end
    render partial: "show_slides_draggable"
  end

  def unused_photos(slideshow)
    all_photos = Photo.all
    slideshow_photos  = slideshow.slides.map {|slide| slide.photo}
    candidates = all_photos + slideshow_photos - (all_photos & slideshow_photos)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_slideshow
      if !params[:id].nil?
        @slideshow = Slideshow.find(params[:id])
      else
        @slideshow = Slideshow.find(session[:slideshow]["id"])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def slideshow_params
      params.require(:slideshow).permit(:index, :show, :new, :create, :edit, :update, :destroy)
    end
end
