require 'sprockets'
require 'tilt'
require 'execjs'

module Sprockets
  module DotJS
    class Compiler < Tilt::Template
      def self.default_mime_type
        'application/javascript'
      end

      def prepare
      end

      def render(scope, locals, &block)
        dotjs_lib = open(::File.join(::File.dirname(__FILE__), '..', '..', 'support', 'doT.js')).read

        context = ExecJS.compile(dotjs_lib)
        context.eval("doT.template(#{data.inspect}, undefined, undefined).toString()")
      end
    end
  end
end
