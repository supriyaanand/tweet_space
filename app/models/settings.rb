class Settings < Settingslogic
  source "#{Rails.root}/config/application.yml.erb"
  namespace Rails.env
  load!
end

