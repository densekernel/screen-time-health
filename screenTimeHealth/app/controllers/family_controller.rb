class FamilyController < ApplicationController

  def view
    @family = current_family
  end

  def edit
    @family = current_family
    @family_name = @family.surname
  end

end


