require 'bundler/setup'
Bundler.require(:default)

DB = Sequel.postgres('sfx')

Dir.glob(File.join(__dir__, 'lib', '*.rb')) { |f| require_relative f }

module Sfx
  class Root < Scorched::Controller
    config[:static_dir] = '../public'
    render_defaults.merge!(
      dir: 'views',
      tilt: {
        default_encoding: Encoding::UTF_8
      }
    )

    get '/'  do
      render :application, locals: {success: nil, warning: nil}
    end

    post '/' do
      if Subscription.subscribe(request[:student],
                             [request[:tuesday], request[:thursday]])
        success = "Je werd succesvol ingeschreven."
        warning = nil
      else
        success = nil
        warning = "Een gekozen activiteit is reeds volzet. Maak andere keuzes."
      end
      render :application, locals: {success: success, warning: warning}
    end
  end
end
