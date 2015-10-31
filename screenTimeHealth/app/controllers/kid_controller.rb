class KidController < ApplicationController
  def view
    @kid = Kid.get(params[:id])
  end
end
