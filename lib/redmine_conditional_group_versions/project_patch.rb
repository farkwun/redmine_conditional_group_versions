module RedmineConditionalGroupVersions
  module Patches
    module ProjectPatch
      def self.included(base)
        base.send(:include, InstanceMethods)

        base.alias_method_chain :shared_versions, :conditional_group_versions
      end

      module InstanceMethods
        def shared_versions_with_conditional_group_versions
          the_versions = shared_versions_without_conditional_group_versions
          unless group_conditional_custom_field.nil?
            the_versions.reject! {|v| !user_group_can_see?(v)} 
          end
          the_versions
        end


        def user_group_can_see?(version)
          @visibilities ||= user_group_project_visibilities
          version_project = Project.find_by_id(version.project_id).name
          if is_a_conditional_version_project?(version_project)
            logger.warn(version_project)
            logger.warn @visibilities.include?(version_project)
            @visibilities.include?(version_project)
          else
            true
          end
        end

        def user_group_project_visibilities
          visibilities = Set.new
          User.current.groups.each do |g|
            g.custom_field_value(group_conditional_custom_field).each do |gcfv|
              visibilities.add gcfv.to_s
            end
          end
          visibilities
        end

        def is_a_conditional_version_project?(project_name)
          @version_projects ||= group_conditional_custom_field.possible_values
          @version_projects.include?(project_name)
        end

        def group_conditional_custom_field
          list_option = Setting.plugin_redmine_conditional_group_versions[:group_custom_list_field]
          return if list_option.eql?('none')
          GroupCustomField.find_by_name(list_option)
        end
      end
    end
  end
end

Project.send(:include, RedmineConditionalGroupVersions::Patches::ProjectPatch)
