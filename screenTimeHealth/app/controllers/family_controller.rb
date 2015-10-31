class FamilyController < ApplicationController

  def view
    @family = current_family
    @kids = current_family.kid
  end

  def edit
    @family = current_family
    @family_name = @family.surname
    @kid = @family.kids.build

  end

  # def update
  #   @family = current_family
  #   @kids = @family.kid
  #   redirect_to :controller => 'family', :action => 'view'
  # end

def create_kid
    family_attr = params[:family][:kids_attributes]
    @family = current_family

    puts 'familty attr here'
    puts family_attr

     params.each do |key, value|
      puts 'key:'
      puts key
      puts 'val:'
      puts value
    end

    # updates the document with signatures
    if @family.update(params.require(:family).permit(:id, :email, :surname, kids_attributes: [:id, :name, :_destroy]))
    # if @family.update_attributes(params[:family][:kids_attributes])
      redirect_to :controller => 'family', :action => 'view'
    else
      redirect_to :controller => 'family', :action => 'edit'
    end
end

 #  def update
 #   @family = Family.find(params[:id])
 #   if @family.update_attributes(params[:survey])
 #     redirect_to :controller => 'family', :action => 'view', :notice  => "Successfully updated family information."
 #   else
 #     render :action => 'edit'
 #   end
 # end

 # def destroy
 #   @family = Family.find(params[:id])
 #   @family.destroy
 #   redirect_to :controller => 'family', :action => 'view', :notice => "Successfully destroyed survey."
 # end


  def family_params
    params.require(:family).permit(:id, :email, :surname, kids_attributes: [:id, :name, :_destroy])
  end


end


