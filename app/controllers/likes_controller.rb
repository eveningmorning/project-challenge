class LikesController < ApplicationController

  # POST /likes/1
  def create
    if current_user

      @like = Like.new
      @like.dog_id = params[:dog_id]
      @like.user_id = current_user.id

      @dog = Dog.find(params[:dog_id])

      respond_to do |format|
        if @like.save
          format.html { redirect_to @dog, notice: 'Like success' }
          format.json { render :show, status: :created, location: @dog }
        else
          format.html { render :new }
          format.json { render json: @like.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /likes/1
  def destroy
    @like = current_user.likes.where(dog_id: params[:id]).first
    @like.destroy
    @dog = Dog.find(params[:id])
    respond_to do |format|
      format.html { redirect_to @dog, notice: 'Unlike success.' }
      format.json { head :no_content }
    end
  end

  def like_params
    params.require(:like).permit(:dog_id)
  end
end