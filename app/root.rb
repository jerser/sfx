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
      render :application
    end

    post '/' do
      Subscription.subscribe(request[:student], request[:tuesday])
      Subscription.subscribe(request[:student], request[:thursday])
      render :application
    end
  end
end
