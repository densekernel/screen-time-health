class KidController < ApplicationController
  def view
    @kid = Kid.find(params[:id])
    gon.session = @kid.session
  end

  def add

  end

  def create
    @family = current_family
    if Kid.create(:name => params[:name], :family_id => @family.id)
      flash[:notice] = "Family member successfully added."
      redirect_to :controller => 'family', :action => 'view'
    else
      flash[:alert] = "Unsuccessful. Please try again."
      redirect_to :controller => 'family', :action => 'add'
    end
  end

  def delete
    @kid = Kid.find(params[:id])
    if @kid.destroy
      flash[:notice] = "Family member successfully deleted."
      redirect_to :controller => 'family', :action => 'view'
    end
  end

end
