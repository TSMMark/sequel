# frozen-string-literal: true

module Sequel
  module Plugins
    # TODO DOCS
    module WarningSelect
      # TODO DOCS
      def self.configure(model, opts=OPTS)
        model.instance_eval do
          warning_type = opts[:type]||:print

          def_dataset_method(:columns=) do |cols|
            if cols.uniq.size != cols.size
              message = "tbd"
              if warning_type == :raise
                raise Sequel::Error.new(message)
              else
                puts message
              end
            end
            @columns = cols
          end
        end
      end

    end
  end
end
