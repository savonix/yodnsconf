class PublicController < ApplicationController
  def index
    @zones = Zone.find_all_by_user_id(0).paginate(:page => params[:page], :per_page => 5)
    render :check
  end

  def check 
    @zones = Zone.find_all_by_user_id(0).paginate(:page => params[:page], :per_page => 5)
    begin
      @zone = Zone.find_by_origin("#{params[:id]}.")
      unless @zone
        @zone = Zone.new({:origin => "#{params[:id]}.", :ttl => 14400, :user_id => 0})
        @zone.save!
      end
      @zone.resolve_ns_records
    rescue 
      flash[:error] = "N0t a valid domain name!"
      redirect_to public_index_path
    end
  end

end
