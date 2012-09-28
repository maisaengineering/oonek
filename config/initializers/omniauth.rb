require 'omniauth-openid'
require 'openid/store/filesystem'

Rails.application.config.middleware.use OmniAuth::Builder do  
  use OmniAuth::Strategies::OpenID, :store => OpenID::Store::Filesystem.new("#{Rails.root}/tmp")

  provider :twitter, 'RH5sh1YYCEyoFpBLVbGBBQ','janoUzmSnutayDUMru3oh8Jqxoua1o2tuc0tjGDoY'
  provider :facebook,'268297616612467','05462b87c68346f7d9c9b15d8e6d3ae1'
  provider :open_id, :name => 'google', :identifier => 'https://www.google.com/accounts/o8/id'
  begin
    OauthProvider.all.each do |p|
      # This hack can be removed after the upgrade to omniauth 2.0
      # Where every provider will accept the options hash
      unless p.scope.nil?
        provider p.strategy, p.key, p.secret, {:scope => p.scope}
      else
        provider p.strategy, p.key, p.secret
      end
    end
  rescue Exception => e
    # We should initialize even with errors during providers setup
    Rails.logger.error "Error while setting omniauth providers: #{e.inspect}"
  end
end
