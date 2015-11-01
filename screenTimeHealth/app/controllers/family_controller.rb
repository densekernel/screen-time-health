class FamilyController < ApplicationController

  def view
    @family = current_family
    @kids = current_family.kids

  end

  def edit
    @family = current_family
    @family_name = @family.surname
  end

  def add

  end

  def family_params
    params.require(:family).permit(:id, :email, :surname, kids_attributes: [:id, :name, :_destroy])
  end


end


