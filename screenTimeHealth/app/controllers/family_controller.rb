class FamilyController < ApplicationController

  def view
    @family = current_family
    @kids = current_family.kids
    @last_kid_session = {}

    @kids.each do |k|
      sessions = k.session.where("DATE(created_at) = ?", Date.today)
      total = 0
      sessions.each do |s|
        total += s.endTime - s.startTime
      end

      @last_kid_session[k.id] = total
      
    end

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


