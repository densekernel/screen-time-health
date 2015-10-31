class KidController < ApplicationController
  def view
    @kid = Kid.find(params[:id])
    gon.session = @kid.session
  end
end
