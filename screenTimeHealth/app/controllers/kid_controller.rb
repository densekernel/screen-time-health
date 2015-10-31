class KidController < ApplicationController
  def view
    @kid = Kid.find(params[:id])
  end
end
