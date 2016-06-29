module RedmineConditionalGroupVersions
  module Patches
    module ProjectsHelperPatch
      def self.included(base)
        base.send(:include, InstanceMethods)

        base.alias_method_chain :version_options_for_select, :group_conditional_versions
      end

      module InstanceMethods
        # enforces conditional group visibilities in an issue's edit menu
        def version_options_for_select_with_group_conditional_versions(versions, selected=nil)
          whitelist_versions = @project.shared_versions.to_a & versions
          version_options_for_select_without_group_conditional_versions(whitelist_versions, selected)
        end
      end
    end
  end
end


ProjectsHelper.send(:include, RedmineConditionalGroupVersions::Patches::ProjectsHelperPatch)
