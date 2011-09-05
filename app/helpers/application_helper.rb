module ApplicationHelper
  def app_name
    "YoDNSConf"
  end
  def app_link
    link_to app_name, app_home_url, :target => "_blank"
  end
  def app_home_url
    "http://www.yodnsconf.com"
  end
end
