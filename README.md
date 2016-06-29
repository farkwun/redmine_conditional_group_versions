# redmine_conditional_group_versions

This plugin allows admins to restrict visibility on shared versions from certain projects on a per-group basis.

# Instructions

In the configuration menu for this plugin, a drop-down menu containing all Group Custom Fields of type List can be found (if you haven't specified any, this plugin will not work). You can turn off this plugin at any time by setting this to 'none'.

Set this drop-down to the relevant List field that contains the names of the projects from which you are sharing versions (on which you'd like to restrict visibility).

This List field will act as a whitelist you can change using a Group's Edit Page.

Once these are set, a user will only be able to see shared versions that are either shared from projects you are not restricting, or from projects that the Groups they belong to are explicitly allowed to view (using the List Custom Field). 

