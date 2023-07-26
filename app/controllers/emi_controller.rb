class EmiController < ApplicationController
  
  def index
    @emis = Emi.where(loan_id: params[:loan_id])
    @emis.each do |emi|
      if emi.status_unpaid?
        if Date.today > emi.due_date
          emi.penalty = (Date.today - emi.due_date)*50
          emi.save
        end
      end
    end
  end

end
