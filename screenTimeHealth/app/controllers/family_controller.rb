class FamilyController < ApplicationController

  def view
    @family = current_family
    @kids = current_family.kids
    @last_kid_session = {}

    @kids.each do |k|
      if(k.session.count != 0)
      sessions = k.session.where("DATE(startTime) = ?", Date.today)
      total = 0
      sessions.each do |s|
        if session.endTime.nil?
        total += ((s.endTime - s.startTime) / 60)
      end
      end

      @last_kid_session[k.id] = total.to_i
      end
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


