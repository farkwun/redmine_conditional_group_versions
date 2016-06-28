module RedmineConditionalGroupVersions
  module Patches
    module SettingsHelperPatch
      def self.included(base)
        base.send(:include, InstanceMethods)
      end

      module InstanceMethods
        def gcf_list_options
          @options_array = Array.new
          @options_array << 'none'
          GroupCustomField.all.each do |gcf|
            logger.warn gcf.inspect
            @options_array << gcf.name if gcf.field_format.eql?('list')
          end
          @options_array
        end
      end
    end
  end
end

SettingsHelper.send(:include, RedmineConditionalGroupVersions::Patches::SettingsHelperPatch)
