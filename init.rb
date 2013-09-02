require 'redmine'

require_dependency 'issue_id_hook'

Rails.logger.info 'Starting ISSUE-id Plugin for Redmine'

# FIXME: Attempted to update a stale object (when updating project key, looks to be a problem in update_attributes)

Rails.configuration.to_prepare do
    unless Project.included_modules.include?(IssueProjectPatch)
        Project.send(:include, IssueProjectPatch)
    end
    unless Issue.included_modules.include?(IssueIdPatch)
        Issue.send(:include, IssueIdPatch)
    end
end

Redmine::Plugin.register :issue_id do
    name 'ISSUE-id'
    author 'Andriy Lesyuk'
    author_url 'http://www.andriylesyuk.com/'
    description 'Adds support for issue ids in format: CODE-number.'
    url 'http://projects.andriylesyuk.com/projects/issue-id'
    version '0.0.1'

    settings :default => {
        :issue_key_sharing => false
    }, :partial => 'settings/issue_id'
end
