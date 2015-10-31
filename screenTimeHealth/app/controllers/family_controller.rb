class FamilyController < ApplicationController

  def view
    @family = current_family
    @kids = current_family.kid
  end

  def edit
    @family = current_family
    @family_name = @family.surname
  end

end


