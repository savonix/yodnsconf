class PublicController < ApplicationController
  before_filter :zones

  def index
    render :check
  end

  def check 
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

  def zones
    zones_serial = Rails.cache.fetch("zones_public", :expires_in => 1.day) do
      Zone.find_all_by_user_id(0).to_yaml
    end
    @zones = YAML.load(zones_serial).paginate(:page => params[:page], :per_page => 5)
  end
end
