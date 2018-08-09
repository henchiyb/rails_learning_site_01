class CategoriesController < ApplicationController
  def index
    @categories = Category.all.page(params[:page])
                          .per Settings.page.child_in_page
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      redirect_to new_lesson_path
    else
      flash.now[:danger] = t "create_category_fail"
      render :new
    end
  end

  def show
    @category = Category.find_by id: params[:id]
    if @category
      @lessons = @category.lessons.page(params[:page])
                          .per Settings.page.child_in_page
    else
      flash.now[:danger] = t "show_category_fail"
      redirect_to categories_path
    end
  end

  private

  def category_params
    params.require(:category).permit :name, :description
  end
end
