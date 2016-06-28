# update 'must_change_passwd' on admin login

require_dependency 'redmine_conditional_group_versions/project_patch'
require_dependency 'redmine_conditional_group_versions/settings_helper_patch'

Redmine::Plugin.register :redmine_conditional_group_versions do
  name 'Redmine Conditional Group Versions'
  description 'Restrict visibility and usage of versions per group'
  url 'https://github.com/farkwun/redmine_conditional_group_versions'

  author 'farkwun'
  author_url 'https://github.com/farkwun'

  version '0.1.0'
  requires_redmine :version_or_higher => '2.6.0'

  settings :default => { 
    group_custom_list_field: 'none'
    }, :partial => 'settings/conditional_group_versions_settings'
end
