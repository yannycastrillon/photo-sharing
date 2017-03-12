class PhotosController < ApplicationController
  before_action :set_photo, only: [:show, :edit, :update, :destroy]

  # GET /photos
  # GET /photos.json
  def index
    @photos = Photo.all.paginate(page:params[:page], :per_page => 5)
  end

  # GET /photos/1
  # GET /photos/1.json
  def show
  end

  # GET /photos/new
  def new
    @photo = Photo.new
    @all_categories = Category.all.order_by_name
    @select = []
  end

  # POST /photos
  def create
    @photo = Photo.new(photo_params)
    @all_categories = Category.find(params[:categories]) if params[:categories]
    if @photo.save
      flash[:notice] = 'Photo was successfully created.'
      redirect_to photos_path
    else
      @all_categories = Category.all.order_by_name
      render :new
    end
  end

  # GET /photos/1/edit
  def edit
    @all_categories = Category.all.order_by_name
    @selected = @photo.categories.collect{|cat| cat.id.to_i}
  end


  # PATCH/PUT /photos/1
  def update
    @photo.categories = Category.find(params[:categorie]) if params[:categories]
    if @photo.update(params[:photo])
      flash[:notice] = 'Photo was successfully updated.'
      redirect_to photo_path(@photo)
    else
      render :edit
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
    @photo.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      @photo = Photo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def photo_params
      params.require(:photo).permit(:filename)
    end
end
