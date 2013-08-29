require 'bundler/setup'
Bundler.require(:default)
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
  end
end
