class FamilyController < ApplicationController

def view

  @family = current_family
  @family_name = @family.surname
  


end


end


