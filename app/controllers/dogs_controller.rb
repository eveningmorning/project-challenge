class DogsController < ApplicationController
  before_action :set_dog, only: [:show, :edit, :update, :destroy]

  # GET /dogs
  # GET /dogs.json
  def index
    if params[:sort] == 'popular'
      @dogs = Dog.joins(:likes).select('dogs.*, COUNT(likes.id) as likes_count').group('dogs.id').order('likes_count DESC').page(params[:page]).per(5)
    else    
      @dogs = Dog.page(params[:page]).per(5)
    end
  end

  # GET /dogs/1
  # GET /dogs/1.json
  def show
  end

  # GET /dogs/new
  def new
    @dog = Dog.new
  end

  # GET /dogs/1/edit
  def edit
  end

  # POST /dogs
  # POST /dogs.json
	def create
		if current_user
			@dog = Dog.new(dog_params)
			@dog.owner = current_user.id;

			respond_to do |format|
				if @dog.save

					if params[:dog][:image].present?
						@dog.images.attach(*params[:dog][:image])
					end

					format.html { redirect_to @dog, notice: 'Dog was successfully created.' }
					format.json { render :show, status: :created, location: @dog }
				else
					format.html { render :new }
					format.json { render json: @dog.errors, status: :unprocessable_entity }
				end
			end
    end
  end

  # PATCH/PUT /dogs/1
  # PATCH/PUT /dogs/1.json
  def update
		respond_to do |format|
			if current_user && @dog.owner == current_user.id 
				if @dog.update(dog_params)

					if params[:dog][:image].present?
						@dog.images.attach(*params[:dog][:image])
					end

					format.html { redirect_to @dog, notice: 'Dog was successfully updated.' }
					format.json { render :show, status: :ok, location: @dog }
				else
					format.html { render :edit }
					format.json { render json: @dog.errors, status: :unprocessable_entity }
				end
			else
				format.html { render :edit }
				format.json { render json: @dog.errors, status: :unprocessable_entity }
			end
    end
  end

  # DELETE /dogs/1
  # DELETE /dogs/1.json
  def destroy
    @dog.destroy
    respond_to do |format|
      format.html { redirect_to dogs_url, notice: 'Dog was successfully destroyed.' }
      format.json { head :no_content }
    end
	end
	
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dog
      @dog = Dog.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dog_params
      params.require(:dog).permit(:name, :description, :images)
    end
end
